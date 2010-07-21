﻿using System;
using System.Collections.Generic;
using System.Text;
using PluginCore.Utilities;
using PluginCore.Managers;
using PluginCore.Helpers;
using System.Threading;
using PluginCore;
using System.Windows.Forms;
using System.IO;

namespace SourceControl.Sources.Git
{
    class BaseCommand
    {
        static private string resolvedCmd;
        static private string qualifiedCmd;

        protected ProcessRunner runner;
        protected List<string> errors = new List<string>();

        protected virtual void Run(string args, string workingDirectory)
        {
            try
            {
                if (!args.StartsWith("status")) TraceManager.AddAsync("git " + args);

                runner = new ProcessRunner();
                runner.WorkingDirectory = workingDirectory;
                runner.Run(GetGitCmd(), args);
                runner.Output += new LineOutputHandler(runner_Output);
                runner.Error += new LineOutputHandler(runner_Error);
                runner.ProcessEnded += new ProcessEndedHandler(runner_ProcessEnded);
            }
            catch (Exception ex)
            {
                runner = null;
                TraceManager.AddAsync("Unable to start git command:\n" + ex.Message);
            }
        }

        protected virtual string GetGitCmd()
        {
            string cmd = PluginMain.SCSettings.GitPath;
            if (cmd == null) cmd = "git";
            string resolve = PathHelper.ResolvePath(cmd);
            return resolve ?? ResolveGitPath(cmd);
        }

        static private string ResolveGitPath(string cmd)
        {
            if (resolvedCmd == cmd || Path.IsPathRooted(cmd))
                return qualifiedCmd;
            
            resolvedCmd = cmd;
            qualifiedCmd = cmd;
            string cp = Environment.GetEnvironmentVariable("PATH");
            foreach (string path in cp.Split(';'))
            {
                if (path.IndexOf("git", StringComparison.OrdinalIgnoreCase) > 0 && Directory.Exists(path))
                {
                    string test = Path.Combine(path, cmd + ".cmd");
                    if (File.Exists(test)) { qualifiedCmd = test; break; }
                    test = Path.Combine(path, cmd + ".exe");
                    if (File.Exists(test)) { qualifiedCmd = test; break; }
                }
            }
            return qualifiedCmd;
        }

        protected virtual void runner_ProcessEnded(object sender, int exitCode)
        {
            runner = null;
            DisplayErrors();
        }

        protected virtual void DisplayErrors()
        {
            if (errors.Count > 0)
            {
                (PluginBase.MainForm as Form).BeginInvoke((MethodInvoker)delegate
                {
                    ErrorManager.ShowInfo(String.Join("\n", errors.ToArray()));
                });
            }
        }

        protected virtual void runner_Error(object sender, string line)
        {
            errors.Add(line.StartsWith("git: ") ? line.Substring(5) : line);
        }

        protected virtual void runner_Output(object sender, string line)
        {
        }
    }
}
