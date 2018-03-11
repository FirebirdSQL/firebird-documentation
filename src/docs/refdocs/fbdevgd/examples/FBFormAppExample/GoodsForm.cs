using System;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using FirebirdSql.Data.FirebirdClient;
using System.Windows.Forms;

namespace FBFormAppExample
{

    public partial class GoodsForm : Form
    {

        public GoodsForm()
        {
            InitializeComponent();
        }

        private void LoadGoodsData()
        {
            var dbContext = AppVariables.getDbContext();
            // отсоединяем все загруженные объекты
            // это необходимо чтобы обнвился внутренний кеш
            // при второй и последующих вызовах этого метода
            dbContext.DetachAll(dbContext.PRODUCTS);

            var goods =
                from product in dbContext.PRODUCTS
                orderby product.NAME
                select product;

            bindingSource.DataSource = goods.ToBindingList();

        }

        private void GoodsForm_Load(object sender, EventArgs e)
        {
            LoadGoodsData();

            dataGridView.DataSource = bindingSource;
            dataGridView.Columns["PRODUCT_ID"].Visible = false;
            dataGridView.Columns["INVOICE_LINES"].Visible = false;
            dataGridView.Columns["DESCRIPTION"].Visible = false;
            dataGridView.Columns["NAME"].HeaderText = "Name";
            dataGridView.Columns["PRICE"].HeaderText = "Price";

            textBoxDescription.DataBindings.Add("Text", bindingSource, "DESCRIPTION");
        }

        public PRODUCT CurrentProduct
        {
            get
            {
                return (PRODUCT)bindingSource.Current;
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            var product = (PRODUCT)bindingSource.AddNew();

            using (GoodsEditorForm editor = new GoodsEditorForm())
            {
                editor.Text = "Add product";
                editor.Product = product;

                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // получаем новое значение генератора
                            // и присваиваем его идентификатору
                            product.PRODUCT_ID = dbContext.NextValueFor("GEN_PRODUCT_ID");
                            // добавляем новый продукт
                            dbContext.PRODUCTS.Add(product);
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            dbContext.Refresh(RefreshMode.StoreWins, product);
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
                editor.ShowDialog();
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            // получаем сущность
            var product = (PRODUCT)bindingSource.Current;

            using (GoodsEditorForm editor = new GoodsEditorForm())
            {
                editor.Text = "Edit product";
                editor.Product = product;

                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            dbContext.Refresh(RefreshMode.StoreWins, product);
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

                };
                // показываем модальную форму
                editor.ShowDialog(this);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();

            var result = MessageBox.Show("Are you sure you want to delete the product?",
                "Confirm",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {

                var product = (PRODUCT)bindingSource.Current;
                try
                {
                    dbContext.PRODUCTS.Remove(product);
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
            LoadGoodsData();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void GoodsForm_Shown(object sender, EventArgs e)
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

        private void btnDiscount_Click(object sender, EventArgs e)
        {         
            DiscountEditorForm editor = new DiscountEditorForm();

            editor.Text = "Enter discount";
            if (editor.ShowDialog() != DialogResult.OK)
                return;


            bool needUpdate = false;

            var dbContext = AppVariables.getDbContext();
            var connection = dbContext.Database.Connection;
            // явный старт транзакции по умолчанию
            using (var dbTransaction = connection.BeginTransaction(IsolationLevel.Snapshot))
            {
                dbContext.Database.UseTransaction(dbTransaction);
                string sql =
                    "UPDATE PRODUCT " +
                    "SET PRICE =  ROUND(PRICE * (100 - @DISCOUNT)/100, 2) " +
                    "WHERE PRODUCT_ID = @PRODUCT_ID";
                try
                {
                    // создаём параметры запроса
                    var idParam = new FbParameter("PRODUCT_ID", FbDbType.Integer);
                    var discountParam = new FbParameter("DISCOUNT", FbDbType.Decimal);
                    // создаём SQL комманду для обновления записей
                    var sqlCommand = connection.CreateCommand();
                    sqlCommand.CommandText = sql;
                    // указываем команде какую транзакцию использовать
                    sqlCommand.Transaction = dbTransaction;
                    sqlCommand.Parameters.Add(discountParam);
                    sqlCommand.Parameters.Add(idParam);
                    // подготовливаем команду
                    sqlCommand.Prepare();
                    // для всех выделенных записей в гриде
                    foreach (DataGridViewRow gridRows in dataGridView.SelectedRows)
                    {
                        int id = (int)gridRows.Cells["PRODUCT_ID"].Value;
                        // инициализируем параметры запроса
                        idParam.Value = id;
                        discountParam.Value = editor.Discount;
                        // выполняем sql запрос                            
                        needUpdate = (sqlCommand.ExecuteNonQuery() > 0) || needUpdate;
                    }
                    dbTransaction.Commit();
                }
                catch (Exception ex)
                {
                    dbTransaction.Rollback();
                    MessageBox.Show(ex.Message, "error");
                    needUpdate = false;
                }
            }
            // перезагружаем содержимое грида
            if (needUpdate)
            {
                // для всех выделенных записей в гриде
                foreach (DataGridViewRow gridRows in dataGridView.SelectedRows)
                {
                    var product = (PRODUCT)bindingSource.List[gridRows.Index];
                    dbContext.Refresh(RefreshMode.StoreWins, product);
                }
                bindingSource.ResetBindings(false);
            }

        }
    }
}
