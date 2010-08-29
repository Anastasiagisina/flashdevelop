using System;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections.Generic;
using PluginCore.Localization;
using ASCompletion.Model;
using PluginCore;

namespace CodeRefactor.Controls
{
    public class DelegateMethodsDialog : Form
    {
        private Button btnOK;
        private Button btnCancel;
        private DividedCheckedListBox checkedListBox;
        private Dictionary<MemberModel, ClassModel> members;
        public Dictionary<MemberModel, ClassModel> checkedMembers;
        private Dictionary<String, MemberModel> members2;

        public DelegateMethodsDialog()
        {
            this.Owner = (Form)PluginBase.MainForm;
            this.Font = PluginBase.Settings.DefaultFont;
            this.Text = TextHelper.GetString("Title.DelegateMethods");
            this.InitializeComponent();
            this.btnOK.Focus();
        }

        #region Windows Form Designer Generated Code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnOK = new System.Windows.Forms.Button();
            this.checkedListBox = new DividedCheckedListBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnOK
            //
            this.btnOK.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnOK.Location = new System.Drawing.Point(392, 283);
            this.btnOK.Name = "btnOK";
            this.btnOK.Size = new System.Drawing.Size(80, 23);
            this.btnOK.TabIndex = 0;
            this.btnOK.Text = "OK";
            this.btnOK.UseVisualStyleBackColor = true;
            this.btnOK.Click += new System.EventHandler(this.OkButtonClick);
            // 
            // checkedListBox
            //
            this.checkedListBox.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) | System.Windows.Forms.AnchorStyles.Left) | System.Windows.Forms.AnchorStyles.Right)));
            this.checkedListBox.CheckOnClick = true;
            this.checkedListBox.FormattingEnabled = true;
            this.checkedListBox.Font = PluginBase.Settings.DefaultFont; // Do not remove!!!
            this.checkedListBox.Location = new System.Drawing.Point(9, 9);
            this.checkedListBox.Name = "checkedListBox";
            this.checkedListBox.Size = new System.Drawing.Size(463, 270);
            this.checkedListBox.IntegralHeight = false;
            this.checkedListBox.TabIndex = 2;
            // 
            // btnCancel
            //
            this.btnCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.btnCancel.Location = new System.Drawing.Point(301, 283);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(85, 23);
            this.btnCancel.TabIndex = 1;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.CancelButtonClick);
            // 
            // DelegateMethodsDialog
            //
            this.ShowIcon = false;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.ShowInTaskbar = false;
            this.AcceptButton = this.btnOK;
            this.CancelButton = this.btnCancel;
            this.MinimumSize = new System.Drawing.Size(400, 200);
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(480, 316);
            this.Controls.Add(this.btnOK);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.checkedListBox);
            this.Name = "DelegateMethodsDialog";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.ResumeLayout(false);

        }

        #endregion

        #region Methods And Event Handlers

        /// <summary>
        /// 
        /// </summary>
        public void FillData(Dictionary<MemberModel, ClassModel> members, ClassModel cm)
        {
            String label;
            this.members = members;
            String separatorInserted = null;
            members2 = new Dictionary<String, MemberModel>();
            CheckedListBox.ObjectCollection items = checkedListBox.Items;
            Dictionary<MemberModel, ClassModel>.KeyCollection keys = members.Keys;
            items.Clear(); // Clear items...
            foreach (MemberModel member in keys)
            {
                String qname = members[member].QualifiedName;
                if (separatorInserted != qname)
                {
                    separatorInserted = qname;
                    items.Add("--- " + qname);
                }
                label = member.ToDeclarationString();
                items.Add(label, false);
                members2.Add(label, member);
            }
        }

        /// <summary>
        /// Just hides the dialog window when closing
        /// </summary>
        private void DialogClosing(Object sender, CancelEventArgs e)
        {
            e.Cancel = true;
            PluginBase.MainForm.CurrentDocument.Activate();
            members = null;
            this.Hide();
        }

        /// <summary>
        /// 
        /// </summary>
        private void OkButtonClick(object sender, EventArgs e)
        {
            this.checkedMembers = new Dictionary<MemberModel, ClassModel>();
            foreach (string item in checkedListBox.CheckedItems)
            {
                if (item.StartsWith("---")) continue;
                checkedMembers[members2[item]] = members[members2[item]];
            }
            CancelEventArgs cancelArgs = new CancelEventArgs(false);
            OnValidating(cancelArgs);
            if (!cancelArgs.Cancel)
            {
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        private void CancelButtonClick(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            this.Close();
        }

        /// <summary>
        /// Update the dialog args when show is called
        /// </summary>
        public new void Show()
        {
            base.Show();
        }

        #endregion

    }

}
