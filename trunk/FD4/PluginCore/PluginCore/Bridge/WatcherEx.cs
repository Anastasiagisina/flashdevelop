﻿using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using PluginCore.Bridge;
using PluginCore.Managers;

namespace PluginCore.Bridge
{
    public class WatcherEx
    {
        string path;
        string filter;
        string realPath;
        bool enabled;
        FileSystemWatcher watcher;
        BridgeClient bridge;

        public bool IsRemote { get { return realPath != null; } }

        /// <summary>
        /// Either watch a single file (if specified) or an entire directory tree.
        /// </summary>
        public WatcherEx(string path)
            : this(path, null)
        {
        }

        public WatcherEx(string path, string file)
        {
            this.path = path;
            this.filter = file;
            realPath = BridgeManager.GetSharedPath(path);
            if (realPath == null) SetupRegularWatcher();
        }

        public void Dispose()
        {
            if (watcher != null) watcher.Dispose();
        }

        #region FSW emulation

        public event FileSystemEventHandler Created;
        public event FileSystemEventHandler Changed;
        public event FileSystemEventHandler Deleted;
        public event RenamedEventHandler Renamed;

        public bool EnableRaisingEvents
        {
            get { return enabled; }
            set
            {
                enabled = value;
                if (watcher != null) watcher.EnableRaisingEvents = value;
                else if (enabled)
                {
                    bridge = new BridgeClient();
                    if (!bridge.Connected)
                    {
                        TraceManager.AddAsync("Unable to connect to FlashDevelop Mac Bridge");
                        enabled = false;
                        bridge = null;
                    }
                    else
                    {
                        TraceManager.AddAsync("Connected: " + realPath + " " + filter);
                        bridge.DataReceived += new DataReceivedEventHandler(bridge_DataReceived);
                        if (filter == null) bridge.Send("watch:" + realPath);
                        else bridge.Send("watch:" + Path.Combine(realPath, filter));
                    }
                }
                else if (bridge != null)
                {
                    if (bridge.Connected)
                    {
                        bridge.Send("unwatch:");
                        try
                        {
                            bridge.Disconnect();
                        }
                        catch { }
                    }
                    bridge = null;
                }
            }
        }

        void bridge_DataReceived(object sender, DataReceivedEventArgs e)
        {
            TraceManager.AddAsync("received: " + e.Text);
            string remotePath = e.Text.Replace('/', '\\');
            if (!remotePath.EndsWith("\\")) remotePath += '\\';
            int len = realPath.Length;
            if (len > remotePath.Length) return;
            string fullPath = path + '\\' + remotePath.Substring(len);
            TraceManager.AddAsync("changed: " + fullPath); 
            string folder = Path.GetDirectoryName(fullPath);
            string name = Path.GetFileName(fullPath);
            if (Changed != null) 
                Changed(this, new FileSystemEventArgs(WatcherChangeTypes.Changed, folder, name));
        }

        #endregion

        #region regular watcher implementation

        private void SetupRegularWatcher()
        {
            watcher = new FileSystemWatcher(path);
            if (filter != null)
            {
                watcher.IncludeSubdirectories = false;
                watcher.Filter = filter;
            }
            else
            {
                watcher.IncludeSubdirectories = true;
                watcher.InternalBufferSize = 4096 * 8;
            }
            watcher.Created += watcher_Created;
            watcher.Changed += watcher_Changed;
            watcher.Deleted += watcher_Deleted;
            watcher.Renamed += watcher_Renamed;
        }

        private void watcher_Created(object sender, FileSystemEventArgs e)
        {
            if (Created != null) Created(this, e);
        }
        private void watcher_Changed(object sender, FileSystemEventArgs e)
        {
            if (Changed != null) Changed(this, e);
        }
        private void watcher_Deleted(object sender, FileSystemEventArgs e)
        {
            if (Deleted != null) Deleted(this, e);
        }
        private void watcher_Renamed(object sender, RenamedEventArgs e)
        {
            if (Renamed != null) Renamed(this, e);
        }

        #endregion

    }
}