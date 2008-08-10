using System;
using System.Text;
using System.Drawing;
using System.Reflection;
using System.Collections;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using System.Windows.Forms;
using PluginCore.Managers;
using PluginCore;

namespace FlashDevelop.Settings
{
    public partial class SettingObject : ISettings
    {
        /// <summary>
        /// Sets a value of a setting
        /// </summary>
        public void SetValue(String name, Object value)
        {
            try
            {
                Type type = this.GetType();
                PropertyInfo info = type.GetProperty(name);
                info.SetValue(this, value, null);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Gets a value of a setting as an object
        /// </summary>
        public Object GetValue(String name)
        {
            try
            {
                Type type = this.GetType();
                PropertyInfo info = type.GetProperty(name);
                return info.GetValue(this, null);
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return null;
            }
        }

        /// <summary>
        /// Ensures that the values of the settings are not null
        /// </summary>
        public static void EnsureValidity(SettingObject settings)
        {
            try
            {
                SettingObject defaults = GetDefaultSettings();
                PropertyInfo[] properties = settings.GetType().GetProperties();
                foreach (PropertyInfo property in properties)
                {
                    if (settings.GetValue(property.Name) == null)
                    {
                        Object value = defaults.GetValue(property.Name);
                        settings.SetValue(property.Name, value);
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
            }
        }

        /// <summary>
        /// Gets a fresh copy of the settings
        /// </summary>
        public static SettingObject GetDefaultSettings()
        {
            SettingObject settings = new SettingObject();
            List<Argument> arguments = new List<Argument>();
            arguments.Add(new Argument("DefaultUser", "DefaultUser (Tools -> Custom Arguments...)"));
            settings.CustomArguments = arguments;
            return settings;
        }

    }

}
