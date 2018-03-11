namespace FBFormAppExample
{
    partial class InvoiceForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.masterGridView = new System.Windows.Forms.DataGridView();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.btnAddInvoice = new System.Windows.Forms.ToolStripButton();
            this.btnEditInvoice = new System.Windows.Forms.ToolStripButton();
            this.btnDeleteInvoice = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.btnInvoicePay = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.btnInvoiceRefresh = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.btnExit = new System.Windows.Forms.ToolStripButton();
            this.detailGridView = new System.Windows.Forms.DataGridView();
            this.toolStrip2 = new System.Windows.Forms.ToolStrip();
            this.btnAddInvoiceLine = new System.Windows.Forms.ToolStripButton();
            this.btnEditInvoiceLine = new System.Windows.Forms.ToolStripButton();
            this.btnDeleteInvoiceLine = new System.Windows.Forms.ToolStripButton();
            this.masterBinding = new System.Windows.Forms.BindingSource(this.components);
            this.detailBinding = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.masterGridView)).BeginInit();
            this.toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.detailGridView)).BeginInit();
            this.toolStrip2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.masterBinding)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailBinding)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.masterGridView);
            this.splitContainer1.Panel1.Controls.Add(this.toolStrip1);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.detailGridView);
            this.splitContainer1.Panel2.Controls.Add(this.toolStrip2);
            this.splitContainer1.Size = new System.Drawing.Size(695, 427);
            this.splitContainer1.SplitterDistance = 223;
            this.splitContainer1.TabIndex = 1;
            // 
            // masterGridView
            // 
            this.masterGridView.AllowUserToAddRows = false;
            this.masterGridView.AllowUserToDeleteRows = false;
            this.masterGridView.AllowUserToOrderColumns = true;
            this.masterGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.masterGridView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.masterGridView.Location = new System.Drawing.Point(0, 31);
            this.masterGridView.Name = "masterGridView";
            this.masterGridView.ReadOnly = true;
            this.masterGridView.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.masterGridView.Size = new System.Drawing.Size(695, 192);
            this.masterGridView.TabIndex = 1;
            // 
            // toolStrip1
            // 
            this.toolStrip1.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnAddInvoice,
            this.btnEditInvoice,
            this.btnDeleteInvoice,
            this.toolStripSeparator1,
            this.btnInvoicePay,
            this.toolStripSeparator2,
            this.btnInvoiceRefresh,
            this.toolStripSeparator3,
            this.btnExit});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(695, 31);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // btnAddInvoice
            // 
            this.btnAddInvoice.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnAddInvoice.Image = global::FBFormAppExample.Properties.Resources.Add;
            this.btnAddInvoice.ImageTransparentColor = System.Drawing.Color.White;
            this.btnAddInvoice.Name = "btnAddInvoice";
            this.btnAddInvoice.Size = new System.Drawing.Size(28, 28);
            this.btnAddInvoice.Text = "Add invoice";
            this.btnAddInvoice.Click += new System.EventHandler(this.btnAddInvoice_Click);
            // 
            // btnEditInvoice
            // 
            this.btnEditInvoice.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnEditInvoice.Image = global::FBFormAppExample.Properties.Resources.Modify;
            this.btnEditInvoice.ImageTransparentColor = System.Drawing.Color.White;
            this.btnEditInvoice.Name = "btnEditInvoice";
            this.btnEditInvoice.Size = new System.Drawing.Size(28, 28);
            this.btnEditInvoice.Text = "Edit invoice";
            this.btnEditInvoice.Click += new System.EventHandler(this.btnEditInvoice_Click);
            // 
            // btnDeleteInvoice
            // 
            this.btnDeleteInvoice.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnDeleteInvoice.Image = global::FBFormAppExample.Properties.Resources.Delete;
            this.btnDeleteInvoice.ImageTransparentColor = System.Drawing.Color.White;
            this.btnDeleteInvoice.Name = "btnDeleteInvoice";
            this.btnDeleteInvoice.Size = new System.Drawing.Size(28, 28);
            this.btnDeleteInvoice.Text = "Delete invoice";
            this.btnDeleteInvoice.Click += new System.EventHandler(this.btnDeleteInvoice_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 31);
            // 
            // btnInvoicePay
            // 
            this.btnInvoicePay.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnInvoicePay.Image = global::FBFormAppExample.Properties.Resources.Dollar;
            this.btnInvoicePay.ImageTransparentColor = System.Drawing.Color.White;
            this.btnInvoicePay.Name = "btnInvoicePay";
            this.btnInvoicePay.Size = new System.Drawing.Size(28, 28);
            this.btnInvoicePay.Text = "Pay for invoice";
            this.btnInvoicePay.Click += new System.EventHandler(this.btnInvoicePay_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 31);
            // 
            // btnInvoiceRefresh
            // 
            this.btnInvoiceRefresh.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnInvoiceRefresh.Image = global::FBFormAppExample.Properties.Resources.Refresh;
            this.btnInvoiceRefresh.ImageTransparentColor = System.Drawing.Color.White;
            this.btnInvoiceRefresh.Name = "btnInvoiceRefresh";
            this.btnInvoiceRefresh.Size = new System.Drawing.Size(28, 28);
            this.btnInvoiceRefresh.Text = "Refresh";
            this.btnInvoiceRefresh.Click += new System.EventHandler(this.btnInvoiceRefresh_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 31);
            // 
            // btnExit
            // 
            this.btnExit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnExit.Image = global::FBFormAppExample.Properties.Resources.Exit;
            this.btnExit.ImageTransparentColor = System.Drawing.Color.White;
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(28, 28);
            this.btnExit.Text = "Close";
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // detailGridView
            // 
            this.detailGridView.AllowUserToAddRows = false;
            this.detailGridView.AllowUserToDeleteRows = false;
            this.detailGridView.AllowUserToOrderColumns = true;
            this.detailGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.detailGridView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.detailGridView.Location = new System.Drawing.Point(0, 31);
            this.detailGridView.Name = "detailGridView";
            this.detailGridView.ReadOnly = true;
            this.detailGridView.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.detailGridView.Size = new System.Drawing.Size(695, 169);
            this.detailGridView.TabIndex = 1;
            // 
            // toolStrip2
            // 
            this.toolStrip2.ImageScalingSize = new System.Drawing.Size(24, 24);
            this.toolStrip2.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnAddInvoiceLine,
            this.btnEditInvoiceLine,
            this.btnDeleteInvoiceLine});
            this.toolStrip2.Location = new System.Drawing.Point(0, 0);
            this.toolStrip2.Name = "toolStrip2";
            this.toolStrip2.Size = new System.Drawing.Size(695, 31);
            this.toolStrip2.TabIndex = 0;
            this.toolStrip2.Text = "toolStrip2";
            // 
            // btnAddInvoiceLine
            // 
            this.btnAddInvoiceLine.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnAddInvoiceLine.Image = global::FBFormAppExample.Properties.Resources.Add;
            this.btnAddInvoiceLine.ImageTransparentColor = System.Drawing.Color.White;
            this.btnAddInvoiceLine.Name = "btnAddInvoiceLine";
            this.btnAddInvoiceLine.Size = new System.Drawing.Size(28, 28);
            this.btnAddInvoiceLine.Text = "Add invoice line";
            this.btnAddInvoiceLine.Click += new System.EventHandler(this.btnAddInvoiceLine_Click);
            // 
            // btnEditInvoiceLine
            // 
            this.btnEditInvoiceLine.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnEditInvoiceLine.Image = global::FBFormAppExample.Properties.Resources.Modify;
            this.btnEditInvoiceLine.ImageTransparentColor = System.Drawing.Color.White;
            this.btnEditInvoiceLine.Name = "btnEditInvoiceLine";
            this.btnEditInvoiceLine.Size = new System.Drawing.Size(28, 28);
            this.btnEditInvoiceLine.Text = "Edit invoice line";
            this.btnEditInvoiceLine.Click += new System.EventHandler(this.btnEditInvoiceLine_Click);
            // 
            // btnDeleteInvoiceLine
            // 
            this.btnDeleteInvoiceLine.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.btnDeleteInvoiceLine.Image = global::FBFormAppExample.Properties.Resources.Delete;
            this.btnDeleteInvoiceLine.ImageTransparentColor = System.Drawing.Color.White;
            this.btnDeleteInvoiceLine.Name = "btnDeleteInvoiceLine";
            this.btnDeleteInvoiceLine.Size = new System.Drawing.Size(28, 28);
            this.btnDeleteInvoiceLine.Text = "Delete invoice line";
            this.btnDeleteInvoiceLine.Click += new System.EventHandler(this.btnDeleteInvoiceLine_Click);
            // 
            // masterBinding
            // 
            this.masterBinding.CurrentChanged += new System.EventHandler(this.masterBinding_CurrentChanged);
            // 
            // InvoiceForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(695, 427);
            this.Controls.Add(this.splitContainer1);
            this.Name = "InvoiceForm";
            this.Text = "InvoiceForm";
            this.Load += new System.EventHandler(this.InvoiceForm_Load);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainer1)).EndInit();
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.masterGridView)).EndInit();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.detailGridView)).EndInit();
            this.toolStrip2.ResumeLayout(false);
            this.toolStrip2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.masterBinding)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.detailBinding)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.SplitContainer splitContainer1;
        private System.Windows.Forms.DataGridView masterGridView;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.DataGridView detailGridView;
        private System.Windows.Forms.ToolStrip toolStrip2;
        private System.Windows.Forms.BindingSource masterBinding;
        private System.Windows.Forms.BindingSource detailBinding;
        private System.Windows.Forms.ToolStripButton btnAddInvoice;
        private System.Windows.Forms.ToolStripButton btnEditInvoice;
        private System.Windows.Forms.ToolStripButton btnDeleteInvoice;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton btnInvoicePay;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton btnInvoiceRefresh;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripButton btnExit;
        private System.Windows.Forms.ToolStripButton btnAddInvoiceLine;
        private System.Windows.Forms.ToolStripButton btnEditInvoiceLine;
        private System.Windows.Forms.ToolStripButton btnDeleteInvoiceLine;
    }
}