using System;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Drawing;
using System.Linq;
using System.ComponentModel;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FBFormAppExample
{

    public partial class CustomerForm : Form
    {

        public CustomerForm()
        {
            InitializeComponent();
        }

        private void LoadCustomersData()
        {
            var dbContext = AppVariables.getDbContext();
            // отсоединяем все загруженные объекты
            // это необходимо чтобы обнвился внутренний кеш
            // при второй и последующих вызовах этого метода
            dbContext.DetachAll(dbContext.CUSTOMERS);

            var customers =
                from customer in dbContext.CUSTOMERS
                orderby customer.NAME
                select customer;


            bindingSource.DataSource = customers.ToBindingList();

        }

        private void CustomerForm_Load(object sender, EventArgs e)
        {
            LoadCustomersData();

            dataGridView.DataSource = bindingSource;
            dataGridView.Columns["INVOICES"].Visible = false;
            dataGridView.Columns["CUSTOMER_ID"].Visible = false;
            dataGridView.Columns["NAME"].HeaderText = "Name";
            dataGridView.Columns["ADDRESS"].HeaderText = "Address";
            dataGridView.Columns["ZIPCODE"].HeaderText = "ZipCode";
            dataGridView.Columns["PHONE"].HeaderText = "Phone";
        }

        public CUSTOMER CurrentCustomer
        {
            get
            {
                return (CUSTOMER)bindingSource.Current;
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            // создание нового экземпляра сущности        
            var customer = (CUSTOMER)bindingSource.AddNew();
            // создаём форму для редактирования
            using (CustomerEditorForm editor = new CustomerEditorForm())
            {
                editor.Text = "Add customer";
                editor.Customer = customer;
                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // получаем новое значение генератора
                            // и присваиваем его идентификатору
                            customer.CUSTOMER_ID = dbContext.NextValueFor("GEN_CUSTOMER_ID");
                            // добавляем нового заказчика
                            dbContext.CUSTOMERS.Add(customer);
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            // и обновить текущую запись
                            dbContext.Refresh(RefreshMode.StoreWins, customer);
                        }
                        catch (Exception ex)
                        {
                            // отображаем ошибку
                            MessageBox.Show(ex.Message, "Error");
                            // не закрываем форму для возможности исправления ошибки
                            fe.Cancel = true;
                        }
                    }
                    else
                        bindingSource.CancelEdit();

                };
                // показываем модальную форму
                editor.ShowDialog(this);
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            // получаем сущность
            var customer = (CUSTOMER)bindingSource.Current;
            // создаём форму для редактирования
            using (CustomerEditorForm editor = new CustomerEditorForm())
            {
                editor.Text = "Edit customer";
                editor.Customer = customer;
                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            dbContext.Refresh(RefreshMode.StoreWins, customer);
                            // обновляем все связанные контролы
                            bindingSource.ResetCurrentItem();
                        }
                        catch (Exception ex)
                        {
                            // отображаем ошибку
                            MessageBox.Show(ex.Message, "Error");
                            // не закрываем форму для возможности исправления ошибки
                            fe.Cancel = true;
                        }
                    }
                    else
                        bindingSource.CancelEdit();

                };
                // показываем модальную форму
                editor.ShowDialog(this);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            var result = MessageBox.Show("Are you sure you want to delete the customer?",
                "Confirm",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                // получаем сущность 
                var customer = (CUSTOMER)bindingSource.Current;
                try
                {
                    dbContext.CUSTOMERS.Remove(customer);
                    // пытаемся сохранить изменения
                    dbContext.SaveChanges();
                    // удаляем из связанного списка
                    bindingSource.RemoveCurrent();
                }
                catch (Exception ex)
                {
                    // отображаем ошибку
                    MessageBox.Show(ex.Message, "Error");
                }
            }
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadCustomersData();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void CustomerForm_Shown(object sender, EventArgs e)
        {
            if (this.Modal)
            {
                this.StartPosition = FormStartPosition.CenterScreen;

                FlowLayoutPanel flowLayoutPanel = new FlowLayoutPanel();
                Button btnCancel = new Button();
                Button btnOK = new Button();

                this.Controls.Add(flowLayoutPanel);
                flowLayoutPanel.Controls.Add(btnCancel);
                flowLayoutPanel.Controls.Add(btnOK);
                flowLayoutPanel.Dock = DockStyle.Bottom;
                flowLayoutPanel.FlowDirection = FlowDirection.RightToLeft;
                flowLayoutPanel.Name = "flowLayoutPanel";
                flowLayoutPanel.Padding = new Padding(10);
                flowLayoutPanel.Size = new Size(333, 50);
                flowLayoutPanel.TabIndex = 0;

                // 
                // btnCancel
                // 
                btnCancel.DialogResult = DialogResult.Cancel;
                btnCancel.Name = "btnCancel";
                btnCancel.Size = new Size(75, 23);
                btnCancel.TabIndex = 0;
                btnCancel.Text = "Cancel";
                btnCancel.UseVisualStyleBackColor = true;
                // 
                // btnOK
                // 
                btnOK.DialogResult = DialogResult.OK;
                btnOK.Location = new Point(154, 13);
                btnOK.Name = "btnOK";
                btnOK.Size = new Size(75, 23);
                btnOK.TabIndex = 1;
                btnOK.Text = "OK";
                btnOK.UseVisualStyleBackColor = true;
            }
        }
    }
}
