using System;
using System.IO;
using System.Text;
using System.Collections;
using PluginCore.Managers;
using PluginCore.Helpers;
using PluginCore;

namespace ASCompletion.Commands
{
    public class CreateTrustFile
    {
        private const string FULLPATH = "{0}{1}Macromedia{1}Flash Player{1}#Security{1}FlashPlayerTrust";
        
        /// <summary>
        /// Executes the command and returns if the command was successful
        /// </summary>
        /// <param name="name">Trust file name</param>
        /// <param name="path">Path to trust</param>
        /// <returns>Operation successful</returns>
        public static bool Run(string name, string path)
        {
            if (name == null || path == null) return false;
            try
            {
                string separator = Path.DirectorySeparatorChar.ToString();
                string appDataDir = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
                string fixedPath = String.Format(FULLPATH, appDataDir, separator);
                if (!Directory.Exists(fixedPath)) Directory.CreateDirectory(fixedPath);
                string file = Path.Combine(fixedPath, name);
                FileHelper.WriteFile(file, path, Encoding.Default);
                return true;
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(ex);
                return false;
            }
        }

    }

}
