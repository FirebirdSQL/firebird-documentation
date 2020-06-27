using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FirebirdSql.Data.FirebirdClient;
using System.Windows.Forms;

namespace FBFormAppExample
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        public delegate void ChangeRangeDateHandler(object sender);

        public event ChangeRangeDateHandler ChangeRangeDate;

        private Form createForm(string name)
        {
            Form form = null;
            switch (name)
            {
                case "goods":
                    form = new GoodsForm();
                    break;
                case "customers":
                    form = new CustomerForm();
                    break;
                case "invoices":
                    form = new InvoiceForm();
                    ChangeRangeDate += delegate (object sender)
                    {
                        ((InvoiceForm)form).LoadInvoicesData();
                    };

                    break;
            }
            return form;
        }

        private TabPage getTabPage(string caption)
        {
            TabPage newTabPage = tabControl.TabPages[caption];
            if (newTabPage == null)
            {
                tabControl.TabPages.Add(caption, caption);
                newTabPage = tabControl.TabPages[caption];
                Form form = createForm(caption);
                form.MdiParent = this;
                form.Parent = newTabPage;
                form.Dock = DockStyle.Fill;
                form.FormBorderStyle = FormBorderStyle.None;
                form.FormClosed += this.closeTab;
                form.Show();
            }
            tabControl.SelectedTab = newTabPage;
            return newTabPage;
        }

        private void closeTab(object sender, EventArgs e)
        {
            tabControl.TabPages.Remove(((TabPage)((Form)sender).Parent));
        }

        private void customersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            getTabPage("customers");
        }

        private void goodsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            getTabPage("goods");
        }

        private void invoicesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            getTabPage("invoices");
        }

        private void operatingRangeOfDatesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var dialog = new RangeDateForm();
            dialog.StartDate = AppVariables.StartDate;
            dialog.FinishDate = AppVariables.FinishDate;
            if (dialog.ShowDialog() == DialogResult.OK)
            {
                AppVariables.StartDate = dialog.StartDate;
                AppVariables.FinishDate = dialog.FinishDate;
                // надо оповестить всех подписавшихся
                if (ChangeRangeDate != null)
                    ChangeRangeDate(this);
            }
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            var dialog = new LoginForm();
            //dialog.UserName = "sysdba";
            //dialog.Password = "masterkey";

            if (dialog.ShowDialog() == DialogResult.OK)
            {
                var dbContext = AppVariables.getDbContext();

                try
                {
                    string s = dbContext.Database.Connection.ConnectionString;
                    var builder = new FbConnectionStringBuilder(s);
                    builder.UserID = dialog.UserName;
                    builder.Password = dialog.Password;

                    dbContext.Database.Connection.ConnectionString = builder.ConnectionString;

                    // пробуем подключится
                    dbContext.Database.Connection.Open();
                }
                catch (Exception ex)
                {
                    // отображаем ошибку
                    MessageBox.Show(ex.Message, "Error");
                    Application.Exit();
                }
            }
            else
                Application.Exit();
        }
    }
}
