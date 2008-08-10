/*
 * ASCompletion panel
 * 
 * Contributed by IAP: 
 * - Quick search field allowing to highlight members in the tree (see: region Find declaration)
 */

using System;
using System.Windows.Forms;
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Collections.Generic;
using PluginCore;
using PluginCore.Managers;
using ASCompletion.Model;
using ASCompletion.Context;
using ASCompletion.Settings;

namespace ASCompletion
{
    /// <summary>
    /// AS2 class treeview
    /// </summary>
    public class PluginUI : DockPanelControl
    {
        public const int ICON_FILE = 0;
        public const int ICON_FOLDER_CLOSED = 1;
        public const int ICON_FOLDER_OPEN = 2;
        public const int ICON_CHECK_SYNTAX = 3;
        public const int ICON_QUICK_BUILD = 4;
        public const int ICON_PACKAGE = 5;
        public const int ICON_INTERFACE = 6;
        public const int ICON_INTRINSIC_TYPE = 7;
        public const int ICON_TYPE = 8;
        public const int ICON_VAR = 9;
        public const int ICON_PROTECTED_VAR = 10;
        public const int ICON_PRIVATE_VAR = 11;
        public const int ICON_CONST = 12;
        public const int ICON_PROTECTED_CONST = 13;
        public const int ICON_PRIVATE_CONST = 14;
        public const int ICON_FUNCTION = 15;
        public const int ICON_PROTECTED_FUNCTION = 16;
        public const int ICON_PRIVATE_FUNCTION = 17;
        public const int ICON_PROPERTY = 18;
        public const int ICON_PROTECTED_PROPERTY = 19;
        public const int ICON_PRIVATE_PROPERTY = 20;
        public const int ICON_TEMPLATE = 21;
        public const int ICON_DECLARATION = 22;

        public int LookupCount
        {
            get { return (lookupLocations != null) ? lookupLocations.Count : 0; }
        }
        public FixedTreeView OutlineTree
        {
            get { return this.outlineTree; }
        }
        public ImageList TreeIcons
        {
            get { return treeIcons; }
        }

        public ToolStripMenuItem LookupMenuItem;
        private System.ComponentModel.IContainer components;
        public System.Windows.Forms.ImageList treeIcons;
        private System.Windows.Forms.Panel panelFind;
        private System.Windows.Forms.TextBox findProcTxt;
        private FixedTreeView outlineTree;
        private System.Timers.Timer tempoClick;

        private GeneralSettings settings;
        private string prevChecksum;
        private Stack<LookupLocation> lookupLocations;

        private TreeNode currentHighlight;
        private TreeNode nextHighlight;
        private Timer highlightTimer;

        #region initialization
        public PluginUI(PluginMain plugin)
        {
            settings = plugin.PluginSettings;
            //
            // Controls
            //
            InitializeComponent();
            outlineTree = new FixedTreeView();
            outlineTree.BorderStyle = BorderStyle.None;
            outlineTree.ShowRootLines = false;
            outlineTree.Location = new System.Drawing.Point(1, 0);
            outlineTree.Size = new System.Drawing.Size(198, 300);
            outlineTree.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            outlineTree.ImageList = treeIcons;
            outlineTree.HotTracking = true;
            outlineTree.TabIndex = 0;
            outlineTree.NodeClicked += new FixedTreeView.NodeClickedHandler(ClassTreeSelect);
            outlineTree.KeyDown += new System.Windows.Forms.KeyEventHandler(this.FindProcTxtKeyDown);
            outlineTree.AfterSelect += new TreeViewEventHandler(outlineTree_AfterSelect);
            Controls.Add(outlineTree);
            outlineTree.BringToFront();

            highlightTimer = new Timer();
            highlightTimer.Interval = 200;
            highlightTimer.Tick += new EventHandler(highlightTimer_Tick);
        }

        void outlineTree_AfterSelect(object sender, TreeViewEventArgs e)
        {
            // notify other plugins of tree nodes selection
            DataEvent de = new DataEvent(EventType.Command, "ASCompletion.TreeSelectionChanged", e.Node);
            EventManager.DispatchEvent(sender, de); 
        }

        public System.Drawing.Image GetIcon(int index)
        {
            if (treeIcons.Images.Count > 0)
                return treeIcons.Images[Math.Min(index, treeIcons.Images.Count)];
            else return null;
        }

        #endregion

        #region Windows Forms Designer generated code
        /// <summary>
        /// This method is required for Windows Forms designer support.
        /// Do not change the method contents inside the source code editor. The Forms designer might
        /// not be able to load this method if it was changed manually.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PluginUI));
            this.findProcTxt = new System.Windows.Forms.TextBox();
            this.panelFind = new System.Windows.Forms.Panel();
            this.treeIcons = new System.Windows.Forms.ImageList(this.components);
            this.panelFind.SuspendLayout();
            this.SuspendLayout();
            // 
            // findProcTxt
            // 
            this.findProcTxt.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.findProcTxt.Cursor = System.Windows.Forms.Cursors.IBeam;
            this.findProcTxt.Location = new System.Drawing.Point(0, 5);
            this.findProcTxt.Name = "findProcTxt";
            this.findProcTxt.Size = new System.Drawing.Size(198, 20);
            this.findProcTxt.TabIndex = 2;
            this.findProcTxt.Enter += new System.EventHandler(this.FindProcTxtEnter);
            this.findProcTxt.Leave += new System.EventHandler(this.FindProcTxtLeave);
            this.findProcTxt.TextChanged += new System.EventHandler(this.FindProcTxtChanged);
            this.findProcTxt.KeyDown += new System.Windows.Forms.KeyEventHandler(this.FindProcTxtKeyDown);
            // 
            // panelFind
            // 
            this.panelFind.Controls.Add(this.findProcTxt);
            this.panelFind.Dock = System.Windows.Forms.DockStyle.Top;
            this.panelFind.Location = new System.Drawing.Point(1, 1);
            this.panelFind.Name = "panelFind";
            this.panelFind.Size = new System.Drawing.Size(198, 32);
            this.panelFind.TabIndex = 1;
            this.panelFind.Visible = false;
            // 
            // treeIcons
            // 
            this.treeIcons.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("treeIcons.ImageStream")));
            this.treeIcons.TransparentColor = System.Drawing.Color.Transparent;
            this.treeIcons.Images.SetKeyName(0, "FilePlain.png");
            this.treeIcons.Images.SetKeyName(1, "FolderClosed.png");
            this.treeIcons.Images.SetKeyName(2, "FolderOpen.png");
            this.treeIcons.Images.SetKeyName(3, "CheckAS.png");
            this.treeIcons.Images.SetKeyName(4, "QuickBuild.png");
            this.treeIcons.Images.SetKeyName(5, "Package.png");
            this.treeIcons.Images.SetKeyName(6, "Interface.png");
            this.treeIcons.Images.SetKeyName(7, "Intrinsic.png");
            this.treeIcons.Images.SetKeyName(8, "Class.png");
            this.treeIcons.Images.SetKeyName(9, "Variable.png");
            this.treeIcons.Images.SetKeyName(10, "VariableProtected.png");
            this.treeIcons.Images.SetKeyName(11, "VariablePrivate.png");
            this.treeIcons.Images.SetKeyName(12, "Const.png");
            this.treeIcons.Images.SetKeyName(13, "ConstProtected.png");
            this.treeIcons.Images.SetKeyName(14, "ConstPrivate.png");
            this.treeIcons.Images.SetKeyName(15, "Method.png");
            this.treeIcons.Images.SetKeyName(16, "MethodProtected.png");
            this.treeIcons.Images.SetKeyName(17, "MethodPrivate.png");
            this.treeIcons.Images.SetKeyName(18, "Property.png");
            this.treeIcons.Images.SetKeyName(19, "PropertyProtected.png");
            this.treeIcons.Images.SetKeyName(20, "PropertyPrivate.png");
            this.treeIcons.Images.SetKeyName(21, "Template.png");
            this.treeIcons.Images.SetKeyName(22, "Declaration.png");
            // 
            // PluginUI
            //
            this.Name = "PluginUI";
            this.Controls.Add(this.panelFind);
            this.Size = new System.Drawing.Size(200, 300);
            this.panelFind.ResumeLayout(false);
            this.panelFind.PerformLayout();
            this.ResumeLayout(false);

        }
        #endregion

        #region Status

        private delegate void SetStatusInvoker(string state, int value, int max);

        /// <summary>
        /// Show a status bar
        /// - this method is always thread safe
        /// - if the message is 'null', hides the panel
        /// </summary>
        /// <param name="state">Message</param>
        /// <param name="value">ProgressBar's value</param>
        /// <param name="max">ProgressBar's maximum</param>
        public void SetStatus(string state, int value, int max)
        {
            // thread safe invocation
            if (InvokeRequired)
            {
                BeginInvoke(new SetStatusInvoker(SetStatus), new object[] { state, value, max });
                return;
            }
            if (state == null)
            {
                if (PluginBase.MainForm.ProgressLabel != null)
                    PluginBase.MainForm.ProgressLabel.Visible = false;
                if (PluginBase.MainForm.ProgressBar != null)
                    PluginBase.MainForm.ProgressBar.Visible = false;
                return;
            }
            if (PluginBase.MainForm.ProgressLabel != null)
            {
                PluginBase.MainForm.ProgressLabel.Text = state;
                PluginBase.MainForm.ProgressLabel.Visible = true;
            }
            if (PluginBase.MainForm.ProgressBar != null)
            {
                PluginBase.MainForm.ProgressBar.Maximum = max;
                PluginBase.MainForm.ProgressBar.Value = value;
                PluginBase.MainForm.ProgressBar.Visible = true;
            }
        }

        #endregion

        #region class_tree_display

        /// <summary>
        /// Show the current class/member in the current outline
        /// </summary>
        /// <param name="classModel"></param>
        /// <param name="memberModel"></param>
        internal void Highlight(ClassModel classModel, MemberModel memberModel)
        {
            if (outlineTree.Nodes.Count == 0) return;
            string match;
            // class or class member
            if (classModel != null)
            {
                match = classModel.Name;
                foreach (TreeNode node in outlineTree.Nodes[0].Nodes)
                {
                    if (node.Text == match)
                    {
                        if (memberModel != null)
                        {
                            match = memberModel.ToString();
                            foreach (TreeNode subnode in node.Nodes)
                            {
                                if (subnode.Text == match)
                                {
                                    SetHighlight(subnode);
                                    return;
                                }
                            }
                        }
                        SetHighlight(node);
                        return;
                    }
                }
            }
            // file member
            else if (memberModel != null)
            {
                match = memberModel.ToString();
                foreach (TreeNode node in outlineTree.Nodes)
                {
                    if (node.Text == match)
                    {
                        SetHighlight(node);
                        return;
                    }
                }
            }
            // no match
            SetHighlight(null);
        }

        private void SetHighlight(TreeNode node)
        {
            if (node == currentHighlight) return;
            nextHighlight = node;
            highlightTimer.Stop();
            highlightTimer.Start();
        }

        private void highlightTimer_Tick(object sender, EventArgs e)
        {
            highlightTimer.Stop();

            outlineTree.BeginUpdate();
            if (currentHighlight != null)
            {
                //currentHighlight.BackColor = System.Drawing.SystemColors.Window;
                currentHighlight.ForeColor = System.Drawing.SystemColors.WindowText;
            }
            outlineTree.SelectedNode = currentHighlight = nextHighlight;
            if (currentHighlight != null)
            {
                if (outlineTree.State != null && currentHighlight.TreeView != null)
                    outlineTree.State.highlight = currentHighlight.FullPath;

                //currentHighlight.BackColor = System.Drawing.Color.LightGray;
                currentHighlight.ForeColor = System.Drawing.Color.Blue;
            }
            outlineTree.EndUpdate();
        }

        /// <summary>
        /// Update outline view
        /// </summary>
        /// <param name="aFile"></param>
        internal void UpdateView(FileModel aFile)
        {
            try
            {
                // files "checksum"
                StringBuilder sb = new StringBuilder().Append(aFile.FileName).Append(aFile.Version).Append(aFile.Package);
                if (aFile != FileModel.Ignore)
                {
                    foreach (MemberModel import in aFile.Imports)
                        sb.Append(import.Type).Append(import.LineFrom);
                    foreach (MemberModel member in aFile.Members)
                        sb.Append(member.Flags.ToString()).Append(member.ToString()).Append(member.LineFrom);
                    foreach (ClassModel aClass in aFile.Classes)
                    {
                        sb.Append(aClass.Flags.ToString()).Append(aClass.Name).Append(aClass.LineFrom);
                        sb.Append(aClass.ExtendsType);
                        if (aClass.Implements != null)
                            foreach (string implements in aClass.Implements)
                                sb.Append(implements);
                        foreach (MemberModel member in aClass.Members)
                            sb.Append(member.Flags.ToString()).Append(member.ToString()).Append(member.LineFrom);
                    }

                    foreach (MemberModel region in aFile.Regions) {
                        sb.Append(region.Name).Append(region.LineFrom);
                    }
                }
                string checksum = sb.ToString();
                if (checksum != prevChecksum)
                {
                    prevChecksum = checksum;
                    RefreshView(aFile);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(/*ex.Message,*/ ex);
            }
        }

        private void RefreshView(FileModel aFile)
        {
            //TraceManager.Add("Outline refresh...");
            outlineTree.BeginStatefulUpdate();
            try
            {
                currentHighlight = null;
                outlineTree.Nodes.Clear();
                TreeNode root = new TreeNode(System.IO.Path.GetFileName(aFile.FileName), ICON_FILE, ICON_FILE);
                outlineTree.Nodes.Add(root);
                if (aFile == FileModel.Ignore)
                    return;

                TreeNodeCollection folders = root.Nodes;
                TreeNodeCollection nodes;
                TreeNode node;
                int img;

                // imports
                if (settings.ShowImports && aFile.Imports.Count > 0)
                {
                    node = new TreeNode("Imports", ICON_FOLDER_OPEN, ICON_FOLDER_OPEN);
                    folders.Add(node);
                    nodes = node.Nodes;
                    foreach (MemberModel import in aFile.Imports)
                    {
                        if (import.Type.EndsWith(".*"))
                            nodes.Add(new TreeNode(import.Type, ICON_PACKAGE, ICON_PACKAGE));
                        else
                        {
                            img = ((import.Flags & FlagType.Intrinsic) > 0) ? ICON_INTRINSIC_TYPE : ICON_TYPE;
                            node = new TreeNode(import.Type, img, img);
                            node.Tag = "import";
                            nodes.Add(node);
                        }
                    }
                }

                // class members
                if (aFile.Members.Count > 0)
                {
                    AddMembersSorted(folders, aFile.Members);
                }

                // regions
                if (settings.ShowRegions)
                {
                    if (aFile.Regions.Count > 0)
                    {
                        node = new TreeNode("Regions", ICON_PACKAGE, ICON_PACKAGE);
                        folders.Add(node);
                        AddRegions(node.Nodes, aFile.Regions);
                    }
                }

                // classes
                if (aFile.Classes.Count > 0)
                {
                    nodes = folders;

                    foreach (ClassModel aClass in aFile.Classes)
                    {
                        img = ((aClass.Flags & FlagType.Intrinsic) > 0) ? ICON_INTRINSIC_TYPE :
                            ((aClass.Flags & FlagType.Interface) > 0) ? ICON_INTERFACE : ICON_TYPE;
                        node = new TreeNode(aClass.Name, img, img);
                        node.Tag = "class";
                        nodes.Add(node);
                        if (settings.ShowExtends) AddExtend(node.Nodes, aClass);
                        if (settings.ShowImplements) AddImplements(node.Nodes, aClass.Implements);
                        AddMembersSorted(node.Nodes, aClass.Members);
                        node.Expand();
                    }
                }

                root.Expand();
            }
            catch (Exception ex)
            {
                ErrorManager.ShowError(/*ex.Message,*/ ex);
            }
            finally
            {
                // outline state will be restored/saved from the model data
                if (aFile.OutlineState == null)
                    aFile.OutlineState = new TreeState();
                // restore collapsing state
                outlineTree.EndStatefulUpdate(aFile.OutlineState);
                // restore highlighted item
                if (aFile.OutlineState.highlight != null)
                {
                    TreeNode toHighligh = outlineTree.FindClosestPath(outlineTree.State.highlight);
                    if (toHighligh != null) SetHighlight(toHighligh);
                }
            }
        }

        private void AddExtend(TreeNodeCollection tree, ClassModel aClass)
        {
            TreeNode folder = new TreeNode("Extends", ICON_FOLDER_CLOSED, ICON_FOLDER_OPEN);
            while (aClass.ExtendsType != null && aClass.ExtendsType.Length > 0 
                && aClass.ExtendsType != "Object" 
                && (!aClass.InFile.haXe || aClass.ExtendsType != "Dynamic"))
            {
                string extends = aClass.ExtendsType;
                aClass = aClass.Extends;
                if (!aClass.IsVoid()) extends = aClass.QualifiedName;
                if (extends.ToLower() == "void")
                    break;
                TreeNode extNode = new TreeNode(extends, ICON_TYPE, ICON_TYPE);
                extNode.Tag = "import";
                folder.Nodes.Add(extNode);
            }
            if (folder.Nodes.Count > 0) tree.Add(folder);
        }

        private void AddImplements(TreeNodeCollection tree, List<string> implementsTypes)
        {
            if (implementsTypes == null || implementsTypes.Count == 0)
                return;
            TreeNode folder = new TreeNode("Implements", ICON_FOLDER_CLOSED, ICON_FOLDER_OPEN);
            foreach (string implements in implementsTypes)
            {
                TreeNode impNode = new TreeNode(implements, ICON_INTERFACE, ICON_INTERFACE);
                impNode.Tag = "import";
                folder.Nodes.Add(impNode);
            }
            tree.Add(folder);
        }

        private void AddMembersSorted(TreeNodeCollection tree, MemberList members)
        {
            if (settings.SortingMode == OutlineSorting.None)
            {
                AddMembers(tree, members);
            }
            else if (settings.SortingMode == OutlineSorting.SortedGroup)
            {
                AddMembersGrouped(tree, members);
            }
            else
            {
                IComparer<MemberModel> comparer = null;
                if (settings.SortingMode == OutlineSorting.Sorted)
                    comparer = null;
                else if (settings.SortingMode == OutlineSorting.SortedByKind)
                    comparer = new ByKindMemberComparer();
                else if (settings.SortingMode == OutlineSorting.SortedSmart)
                    comparer = new SmartMemberComparer();
                else if (settings.SortingMode == OutlineSorting.SortedGroup)
                    comparer = new ByKindMemberComparer();

                MemberList copy = new MemberList();
                copy.Add(members);
                copy.Sort(comparer);
                AddMembers(tree, copy);
            }
        }

        private void AddRegions(TreeNodeCollection tree, MemberList members)
        {
            foreach (MemberModel member in members)
            {
                MemberTreeNode node = new MemberTreeNode(member, ICON_PACKAGE);
                tree.Add(node);
            }
        }

        /// <summary>
        /// Add tree nodes following the user defined members presentation
        /// </summary>
        /// <param name="tree"></param>
        /// <param name="members"></param>
        static public void AddMembers(TreeNodeCollection tree, MemberList members)
        {
            TreeNodeCollection nodes = tree;
            MemberTreeNode node = null;
            int img;
            foreach (MemberModel member in members)
                if ((member.Flags & FlagType.Constant) > 0)
                {
                    img = ((member.Access & Visibility.Private) > 0) ? ICON_PRIVATE_CONST :
                        ((member.Access & Visibility.Protected) > 0) ? ICON_PROTECTED_CONST : ICON_CONST;
                    node = new MemberTreeNode(member, img);
                    nodes.Add(node);
                }
                else if ((member.Flags & FlagType.Variable) > 0)
                {
                    img = ((member.Access & Visibility.Private) > 0) ? ICON_PRIVATE_VAR :
                        ((member.Access & Visibility.Protected) > 0) ? ICON_PROTECTED_VAR : ICON_VAR;
                    node = new MemberTreeNode(member, img);
                    nodes.Add(node);
                }
                else if ((member.Flags & (FlagType.Getter | FlagType.Setter)) > 0)
                {
                    if (node != null && node.Text == member.ToString()) // "collapse" properties
                        continue;
                    img = ((member.Access & Visibility.Private) > 0) ? ICON_PRIVATE_PROPERTY :
                        ((member.Access & Visibility.Protected) > 0) ? ICON_PROTECTED_PROPERTY : ICON_PROPERTY;
                    node = new MemberTreeNode(member, img);
                    nodes.Add(node);
                }
                else if ((member.Flags & FlagType.Function) > 0)
                {
                    img = ((member.Access & Visibility.Private) > 0) ? ICON_PRIVATE_FUNCTION :
                        ((member.Access & Visibility.Protected) > 0) ? ICON_PROTECTED_FUNCTION : ICON_FUNCTION;
                    node = new MemberTreeNode(member, img);
                    nodes.Add(node);
                }
        }

        static public void AddMembersGrouped(TreeNodeCollection tree, MemberList members)
        {
            FlagType[] typePriority = new FlagType[] { FlagType.Constructor, FlagType.Function, FlagType.Getter | FlagType.Setter, FlagType.Variable, FlagType.Constant };
            Visibility[] visibilityPriority = new Visibility[] { Visibility.Internal, Visibility.Private, Visibility.Protected, Visibility.Public };
            Dictionary<FlagType, List<MemberModel>> typeGroups = new Dictionary<FlagType, List<MemberModel>>();

            FlagType type;
            List<MemberModel> groupList;
            MemberTreeNode node = null;
            foreach (MemberModel member in members)
            {
                if (node != null && node.Text == member.ToString())
                    continue;

                // member type
                if ((member.Flags & FlagType.Constant) > 0)
                    type = FlagType.Constant;
                else if ((member.Flags & FlagType.Variable) > 0)
                    type = FlagType.Variable;
                else if ((member.Flags & (FlagType.Getter | FlagType.Setter)) > 0)
                    type = (FlagType.Getter | FlagType.Setter);
                else if ((member.Flags & FlagType.Constructor) > 0)
                    type = FlagType.Constructor;
                else type = FlagType.Function;

                // group
                if (!typeGroups.ContainsKey(type))
                {
                    groupList = new List<MemberModel>();
                    typeGroups.Add(type, groupList);
                }
                else groupList = typeGroups[type];

                groupList.Add(member);
            }

            for (int i = 0; i < typePriority.Length; i++)
            {
                if (typeGroups.ContainsKey(typePriority[i]))
                {
                    groupList = typeGroups[typePriority[i]];
                    if (groupList.Count == 0)
                        continue;
                    groupList.Sort();

                    TreeNode groupNode = new TreeNode(typePriority[i].ToString(), ICON_FOLDER_CLOSED, ICON_FOLDER_OPEN);
                    int img;
                    node = null;
                    foreach (MemberModel member in groupList)
                    {
                        if (node != null && node.Text == member.ToString())
                            continue;
                        img = GetMemberIcon(member.Flags, member.Access);
                        node = new MemberTreeNode(member, img);
                        groupNode.Nodes.Add(node);
                    }
                    if (typePriority[i] != FlagType.Constructor) groupNode.Expand();
                    tree.Add(groupNode);
                }
            }
        }

        static public int GetMemberIcon(FlagType flag, Visibility access)
        {
            int rst = 0;

            if ((flag & FlagType.Constant) > 0)
            {
                rst = ((access & Visibility.Private) > 0) ? ICON_PRIVATE_CONST :
                    ((access & Visibility.Protected) > 0) ? ICON_PROTECTED_CONST : ICON_CONST;
            }
            else if ((flag & FlagType.Variable) > 0)
            {
                rst = ((access & Visibility.Private) > 0) ? ICON_PRIVATE_VAR :
                    ((access & Visibility.Protected) > 0) ? ICON_PROTECTED_VAR : ICON_VAR;
            }
            else if ((flag & (FlagType.Getter | FlagType.Setter)) > 0)
            {
                rst = ((access & Visibility.Private) > 0) ? ICON_PRIVATE_PROPERTY :
                    ((access & Visibility.Protected) > 0) ? ICON_PROTECTED_PROPERTY : ICON_PROPERTY;
            }
            else if ((flag & FlagType.Function) > 0)
            {
                rst = ((access & Visibility.Private) > 0) ? ICON_PRIVATE_FUNCTION :
                    ((access & Visibility.Protected) > 0) ? ICON_PROTECTED_FUNCTION : ICON_FUNCTION;
            }
            return rst;
        }
        #endregion

        #region tree_items_selection
        /// <summary>
        /// Selection des items de l'arbre
        /// </summary>
        private void ClassTreeSelect(object sender, TreeNode node)
        {
            if (tempoClick == null)
            {
                tempoClick = new System.Timers.Timer();
                tempoClick.Interval = 50;
                tempoClick.SynchronizingObject = this;
                tempoClick.AutoReset = false;
                tempoClick.Elapsed += new System.Timers.ElapsedEventHandler(delayedClassTreeSelect);
            }
            tempoClick.Enabled = true;
        }

        private void delayedClassTreeSelect(Object sender, System.Timers.ElapsedEventArgs e)
        {
            TreeNode node = outlineTree.SelectedNode;
            if (node == null)
                return;
            ASContext.Context.OnSelectOutlineNode(node);
        }

        public void GotoPosAndFocus(ScintillaNet.ScintillaControl sci, int position)
        {
            int pos = sci.MBSafePosition(position);
            int line = sci.LineFromPosition(pos);
            sci.EnsureVisible(line);
            sci.GotoPos(pos);
        }

        public void SetLastLookupPosition(string file, int line, int column)
        {
            // store location
            if (lookupLocations == null) lookupLocations = new Stack<LookupLocation>();
            lookupLocations.Push(new LookupLocation(file, line, column));
            if (lookupLocations.Count > 100) lookupLocations.TrimExcess();
            // menu item
            if (LookupMenuItem != null) LookupMenuItem.Enabled = true;
        }
        public bool RestoreLastLookupPosition()
        {
            if (lookupLocations == null || lookupLocations.Count == 0)
                return false;

            LookupLocation location = lookupLocations.Pop();
            // menu item
            if (lookupLocations.Count == 0 && LookupMenuItem != null) LookupMenuItem.Enabled = false;

            PluginBase.MainForm.OpenEditableDocument(location.file, false);
            ScintillaNet.ScintillaControl sci = ASContext.CurSciControl;
            if (sci != null)
            {
                int position = sci.PositionFromLine(location.line) + location.column;
                sci.SetSel(position, position);
                int line = sci.LineFromPosition(sci.CurrentPos);
                sci.EnsureVisible(line);
                int top = sci.FirstVisibleLine;
                int middle = top + sci.LinesOnScreen / 2;
                sci.LineScroll(0, line - middle);
                return true;
            }
            return false;
        }

        #endregion

        #region Find declaration

        // if hilight is true, shows the node and paint it with color 
        private void ShowAndHilightNode(TreeNode node, bool hilight)
        {
            if (hilight)
            {
                node.EnsureVisible();
                node.BackColor = System.Drawing.Color.Aqua;
            }
            else
            {
                node.BackColor = System.Drawing.Color.White;
            }
        }

        private void HilightDeclarationInGroup(TreeNodeCollection nodes, string text)
        {
            foreach (TreeNode sub in nodes)
            {
                ShowAndHilightNode(sub, IsMach(sub.Tag as string, text));
            }
        }

        private bool IsMach(string inputText, string searchText)
        {
            if (inputText == null || searchText == "")
            {
                return false;
            }
            return (inputText.ToUpper().IndexOf(searchText) >= 0);
        }

        private void HighlightAllMachingDeclaration(string text)
        {
            try
            {
                outlineTree.BeginUpdate();
                outlineTree.CollapseAll();
                TreeNodeCollection nodes = outlineTree.Nodes;
                TreeNode node;
                TreeNode expandedNode = null;
                // checking wich node is expanded
                foreach (TreeNode sub in nodes)
                {
                    if (sub.IsExpanded)
                        expandedNode = sub;
                }
                foreach (TreeNode sub in nodes)
                {
                    node = sub;

                    // hilights the name of the class (if mach)
                    ShowAndHilightNode(node, IsMach(node.Text, text));
                    // where to start the hilighting
                    int startWith = 0;
                    if (settings.ShowExtends) startWith++; // has Extend node
                    if (settings.ShowImports) startWith++; // has Imports node
                    for (int index = startWith; index < node.Nodes.Count; index++)
                    {
                        TreeNodeCollection groupNodes = node.Nodes[index].Nodes;
                        HilightDeclarationInGroup(groupNodes, text);
                    }
                }
                Win32.Scrolling.scrollToLeft(outlineTree);
                if (expandedNode != null)
                    expandedNode.Expand();
            }
            catch (Exception ex)
            {
                // log error and disable search field
                ErrorManager.ShowError(ex);
                findProcTxt.Visible = false;
            }
            finally
            {
                outlineTree.EndUpdate();
            }
        }

        void FindProcTxtChanged(object sender, System.EventArgs e)
        {
            string text = findProcTxt.Text;
            if (text == searchInvitation) text = "";
            HighlightAllMachingDeclaration(text.ToUpper());
        }

        // Display informative text in the search field
        private string searchInvitation = "Search...";

        void FindProcTxtEnter(object sender, System.EventArgs e)
        {
            if (findProcTxt.Text == searchInvitation)
            {
                findProcTxt.Text = "";
                findProcTxt.ForeColor = System.Drawing.SystemColors.WindowText;
            }
        }

        void FindProcTxtLeave(object sender, System.EventArgs e)
        {
            if (findProcTxt.Text == "")
            {
                findProcTxt.Text = searchInvitation;
                findProcTxt.ForeColor = System.Drawing.SystemColors.GrayText;
            }
        }

        /// <summary>
        /// Go to the matched declaration on Enter - clear field on Escape
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void FindProcTxtKeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                e.Handled = true;
                if (findProcTxt.Text != searchInvitation)
                {
                    TreeNode node = FindMatch(outlineTree.Nodes);
                    if (node != null)
                    {
                        outlineTree.SelectedNode = node;
                        delayedClassTreeSelect(null, null);
                    }
                }
            }
            else if (e.KeyCode == Keys.Escape)
            {
                findProcTxt.Text = "";
                FindProcTxtLeave(null, null);
                outlineTree.Focus();
            }
        }

        /// <summary>
        /// Find an highlighted item and "click" it
        /// </summary>
        /// <param name="nodes"></param>
        /// <returns></returns>
        private TreeNode FindMatch(TreeNodeCollection nodes)
        {
            foreach (TreeNode node in nodes)
            {
                if (node.BackColor == System.Drawing.Color.Aqua)
                    return node;
                if (node.Nodes.Count > 0)
                {
                    TreeNode subnode = FindMatch(node.Nodes);
                    if (subnode != null) return subnode;
                }
            }
            return null;
        }
        #endregion

    }

    #region Custom structures
    struct LookupLocation
    {
        public string file;
        public int line;
        public int column;
        public LookupLocation(string file, int line, int column)
        {
            this.file = file;
            this.line = line;
            this.column = column;
        }
    }

    class MemberTreeNode : TreeNode
    {
        public MemberTreeNode(MemberModel member, int imageIndex)
            : base(member.ToString(), imageIndex, imageIndex)
        {
            Tag = member.Name + "@" + member.LineFrom;
        }
    }
    #endregion

}
