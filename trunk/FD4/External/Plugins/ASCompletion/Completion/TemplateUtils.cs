using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using ASCompletion.Model;
using PluginCore.Helpers;

namespace ASCompletion.Completion
{
    public class TemplateUtils
    {
        public static string generators_folder = "generators";
        public static string template_variable = @"<<[^\$]*?\$\({0}\).*?>>";

        public static string GetStaticExternOverride(MemberModel member)
        {
            FlagType ft = member.Flags;
            string modifiers = "";
            if ((ft & FlagType.Extern) > 0)
                modifiers += "extern ";
            if ((ft & FlagType.Static) > 0)
                modifiers += "static ";
            if ((ft & FlagType.Override) > 0)
                modifiers += "override ";
            return modifiers;
        }

        public static string GetModifiers(MemberModel member)
        {
            string modifiers = "";
            Visibility acc = member.Access;
            if ((acc & Visibility.Private) > 0)
                modifiers += "private ";
            else if ((acc & Visibility.Public) > 0)
                modifiers += "public ";
            else if ((acc & Visibility.Protected) > 0)
                modifiers += "protected ";
            else if ((acc & Visibility.Internal) > 0)
                modifiers += "internal ";
            return modifiers;
        }

        public static string ToDeclarationWithModifiersString(MemberModel m, string template)
        {
            bool isConstructor = (m.Flags & FlagType.Constructor) > 0;

            string methodModifiers;
            if (isConstructor)
                methodModifiers = GetModifiers(m).Trim();
            else
                methodModifiers = (GetStaticExternOverride(m) + GetModifiers(m)).Trim();

            // Insert Modifiers (private, static, etc)
            string res = ReplaceTemplateVariable(template, "modifiers", methodModifiers);

            // Insert Declaration
            res = ToDeclarationString(m, res);

            return res;
        }

        public static string ToDeclarationString(MemberModel m, string template)
        {
            // Insert Name
            if (m.Name != null)
                template = ReplaceTemplateVariable(template, "name", m.Name);
            else
                template = ReplaceTemplateVariable(template, "name", null);

            // If method, insert arguments
            template = ReplaceTemplateVariable(template, "arguments", ParametersString(m, true));

            if (m.Type != null && m.Type.Length > 0)
                template = ReplaceTemplateVariable(template, "type", FormatType(m.Type));
            else
                template = ReplaceTemplateVariable(template, "type", null);

            if (m.Value != null)
                template = ReplaceTemplateVariable(template, "value", m.Value);
            else
                template = ReplaceTemplateVariable(template, "value", null);

            return template;
        }

        public static string ParametersString(MemberModel member, bool formated)
        {
            string template = GetTemplate("FunctionParameter");
            string res = "";
            if (member.Parameters != null && member.Parameters.Count > 0)
            {
                for (int i = 0; i < member.Parameters.Count; i++)
                {
                    MemberModel param = member.Parameters[i];
                    string one = template;

                    if (i + 1 < member.Parameters.Count)
                        one = ReplaceTemplateVariable(one, "p_comma", ",");
                    else
                        one = ReplaceTemplateVariable(one, "p_comma", null);

                    one = ReplaceTemplateVariable(one, "p_name", param.Name);

                    if (param.Type != null && param.Type.Length > 0)
                        one = ReplaceTemplateVariable(one, "p_type", formated ? FormatType(param.Type) : param.Type);
                    else
                        one = ReplaceTemplateVariable(one, "p_type", null);

                    if (param.Value != null)
                        one = ReplaceTemplateVariable(one, "p_default_value", param.Value.Trim());
                    else
                        one = ReplaceTemplateVariable(one, "p_default_value", null);

                    res += one;
                }
            }
            return res;
        }

        public static string CallParametersString(MemberModel member)
        {
            string template = GetTemplate("FunctionParameter");
            string res = "";
            if (member.Parameters != null && member.Parameters.Count > 0)
            {
                for (int i = 0; i < member.Parameters.Count; i++)
                {
                    MemberModel param = member.Parameters[i];
                    string one = template;

                    if (i + 1 < member.Parameters.Count)
                        one = ReplaceTemplateVariable(one, "p_comma", ",");
                    else
                        one = ReplaceTemplateVariable(one, "p_comma", null);

                    one = ReplaceTemplateVariable(one, "p_name", param.Name);

                    one = ReplaceTemplateVariable(one, "p_type", null);
                    one = ReplaceTemplateVariable(one, "p_default_value", null);

                    res += one;
                }
            }
            return res;
        }

        public static string ReplaceTemplateVariable(string template, string var, string replace)
        {
            Match m = Regex.Match(template, String.Format(template_variable, var));
            if (m.Success)
            {
                if (replace == null)
                {
                    template = template.Substring(0, m.Index) + template.Substring(m.Index + m.Length);
                    return template;
                }
                else
                {
                    string val = m.Value;
                    val = val.Substring(2, val.Length - 4);
                    template = template.Substring(0, m.Index) + val + template.Substring(m.Index + m.Length);
                }
            }
            template = template.Replace("$(" + var + ")", replace);
            return template;
        }

        private static string FormatType(string type)
        {
            return MemberModel.FormatType(type);
        }

        /// <summary>
        /// Templates are stored in the plugin's Data folder
        /// </summary>
        public static string GetTemplate(string name)
        {
            string path = Path.Combine(PathHelper.SnippetDir, generators_folder);
            path = Path.Combine(path, name + ".fds");
            if (!File.Exists(path))
            {
                path = Path.Combine(PathHelper.SnippetDir, PluginCore.PluginBase.MainForm.CurrentDocument.SciControl.ConfigurationLanguage);
                path = Path.Combine(path, generators_folder);
                path = Path.Combine(path, name + ".fds");
                if (!File.Exists(path))
                    return "";
            }

            Stream src = File.OpenRead(path);
            if (src == null) 
                return "";

            String content;
            using (StreamReader sr = new StreamReader(src))
            {
                content = sr.ReadToEnd();
                sr.Close();
            }
            return "$(Boundary)" + content + "$(Boundary)";
        }
    }
}