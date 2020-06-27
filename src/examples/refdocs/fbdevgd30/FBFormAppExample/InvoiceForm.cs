using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FirebirdSql.Data.FirebirdClient;
using System.Windows.Forms;

namespace FBFormAppExample
{
    public partial class InvoiceForm : Form
    {


        public InvoiceForm()
        {
            InitializeComponent();
        }

        public void LoadInvoicesData()
        {
            var dbContext = AppVariables.getDbContext();

            // запрос на LINQ преобразуется в SQL
            var invoices =
                from invoice in dbContext.INVOICES
                where (invoice.INVOICE_DATE >= AppVariables.StartDate) &&
                      (invoice.INVOICE_DATE <= AppVariables.FinishDate)
                orderby invoice.INVOICE_DATE descending
                select new InvoiceView
                {
                    Id = invoice.INVOICE_ID,
                    Cusomer_Id = invoice.CUSTOMER_ID,
                    Customer = invoice.CUSTOMER.NAME,
                    Date = invoice.INVOICE_DATE,
                    Amount = invoice.TOTAL_SALE,
                    Paid = (invoice.PAID == 1) ? "Yes" : "No"
                };

            masterBinding.DataSource = invoices.ToBindingList();
        }

        private void LoadInvoiceLineData(int? id)
        {
            var dbContext = AppVariables.getDbContext();

            var lines =
                from line in dbContext.INVOICE_LINES
                where line.INVOICE_ID == id
                select new InvoiceLineView
                {
                    Id = line.INVOICE_LINE_ID,
                    Invoice_Id = line.INVOICE_ID,
                    Product_Id = line.PRODUCT_ID,
                    Product = line.PRODUCT.NAME,
                    Quantity = line.QUANTITY,
                    Price = line.SALE_PRICE,
                    Total = line.QUANTITY * line.SALE_PRICE
                };

            detailBinding.DataSource = lines.ToBindingList();
        }

        private void InvoiceForm_Load(object sender, EventArgs e)
        {
            LoadInvoicesData();
            masterGridView.DataSource = masterBinding;

            masterGridView.Columns["Id"].HeaderText = "Number";
            masterGridView.Columns["Cusomer_Id"].Visible = false;
        }

        public InvoiceView CurrentInvoice
        {
            get
            {
                return (InvoiceView)masterBinding.Current;
            }
        }

        public InvoiceLineView CurrentInvoiceLine
        {
            get
            {
                return (InvoiceLineView)detailBinding.Current;
            }
        }

        private void masterBinding_CurrentChanged(object sender, EventArgs e)
        {
            LoadInvoiceLineData(this.CurrentInvoice.Id);
            detailGridView.DataSource = detailBinding;

            detailGridView.Columns["Id"].Visible = false;
            detailGridView.Columns["Invoice_Id"].Visible = false;
            detailGridView.Columns["Product_Id"].Visible = false;
        }

        private void btnAddInvoice_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            var invoice = dbContext.INVOICES.Create();

            using (InvoiceEditorForm editor = new InvoiceEditorForm())
            {
                editor.Text = "Add invoice";
                editor.Invoice = invoice;
                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // получаем значение генератора
                            invoice.INVOICE_ID = dbContext.NextValueFor("GEN_INVOICE_ID");
                            // добавляем запись
                            dbContext.INVOICES.Add(invoice);
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            // добавляем проекцию в список для грида
                            ((InvoiceView)masterBinding.AddNew()).Load(invoice.INVOICE_ID);
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

        private void btnEditInvoice_Click(object sender, EventArgs e)
        {
            // получение контекста
            var dbContext = AppVariables.getDbContext();
            // поиск сущности по идентификатору
            var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);

            if (invoice.PAID == 1)
            {
                MessageBox.Show("Change is impossible, invoice paid.", "Error");
                return;
            }

            using (InvoiceEditorForm editor = new InvoiceEditorForm())
            {
                editor.Text = "Edit invoice";
                editor.Invoice = invoice;
                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // пытаемся сохранить изменения
                            dbContext.SaveChanges();
                            // перезагружаем проекцию
                            CurrentInvoice.Load(invoice.INVOICE_ID);
                            masterBinding.ResetCurrentItem();
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

        private void btnDeleteInvoice_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Are you sure you want to delete the invoice?",
                "Confirm",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                var dbContext = AppVariables.getDbContext();
                var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);
                try
                {
                    if (invoice.PAID == 1)
                        throw new Exception("Remove is impossible, invoice paid.");

                    dbContext.INVOICES.Remove(invoice);
                    dbContext.SaveChanges();
                    // обновляется очень быстро
                    masterBinding.RemoveCurrent();
                }
                catch (Exception ex)
                {
                    // отображаем ошибку
                    MessageBox.Show(ex.Message, "Error");
                }
            }
        }

        private void btnInvoicePay_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);
            try
            {
                if (invoice.PAID == 1)
                    throw new Exception("Change is impossible, invoice paid.");

                invoice.PAID = 1;
                // сохраняем изменения
                dbContext.SaveChanges();
                // перезагружаем изменённую запись
                CurrentInvoice.Load(invoice.INVOICE_ID);
                masterBinding.ResetCurrentItem();
            }
            catch (Exception ex)
            {
                // отображаем ошибку
                MessageBox.Show(ex.Message, "Error");
            }
        }

        private void btnInvoiceRefresh_Click(object sender, EventArgs e)
        {
            LoadInvoicesData();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnAddInvoiceLine_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            // получаем текущую счёт-фактуру
            var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);
            // проверяем не оплачена ли счёт-фактура
            if (invoice.PAID == 1)
            {
                MessageBox.Show("Change is impossible, invoice paid.", "Error");
                return;
            }
            // создаём позицию счёт-фактуры
            var invoiceLine = dbContext.INVOICE_LINES.Create();
            invoiceLine.INVOICE_ID = invoice.INVOICE_ID;
            // создаём редактор позиции счёт фактуры
            using (InvoiceLineEditorForm editor = new InvoiceLineEditorForm())
            {
                editor.Text = "Add invoice line";
                editor.InvoiceLine = invoiceLine;

                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // создаём параметры ХП
                            var invoiceIdParam = new FbParameter("INVOICE_ID", FbDbType.Integer);
                            var productIdParam = new FbParameter("PRODUCT_ID", FbDbType.Integer);
                            var quantityParam = new FbParameter("QUANTITY", FbDbType.Integer);
                            // инициализируем параметры значениями
                            invoiceIdParam.Value = invoiceLine.INVOICE_ID;
                            productIdParam.Value = invoiceLine.PRODUCT_ID;
                            quantityParam.Value = invoiceLine.QUANTITY;
                            // выполняем хранимую процедуру
                            dbContext.Database.ExecuteSqlCommand(
                                    "EXECUTE PROCEDURE SP_ADD_INVOICE_LINE(@INVOICE_ID, @PRODUCT_ID, @QUANTITY)",
                                    invoiceIdParam,
                                    productIdParam,
                                    quantityParam);
                            // обновляем гриды
                            // перезагрузка текущей записи счёт-фактуры
                            CurrentInvoice.Load(invoice.INVOICE_ID);
                            // перезагрузка всех записей детейл грида
                            LoadInvoiceLineData(invoice.INVOICE_ID);
                            // обновляем связанные даные
                            masterBinding.ResetCurrentItem();
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

        private void btnEditInvoiceLine_Click(object sender, EventArgs e)
        {
            var dbContext = AppVariables.getDbContext();
            // получаем текущую счёт-фактуру
            var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);
            // проверяем не оплачена ли счёт-фактура
            if (invoice.PAID == 1)
            {
                MessageBox.Show("Change is impossible, invoice paid.", "Error");
                return;
            }
            // получаем текущую позицию счёт-фактуры
            var invoiceLine = invoice.INVOICE_LINES
                .Where(p => p.INVOICE_LINE_ID == this.CurrentInvoiceLine.Id)
                .First();
            // создаём редактор позиции счёт фактуры
            using (InvoiceLineEditorForm editor = new InvoiceLineEditorForm())
            {
                editor.Text = "Edit invoice line";
                editor.InvoiceLine = invoiceLine;

                // Обработчик закрытия формы
                editor.FormClosing += delegate (object fSender, FormClosingEventArgs fe)
                {
                    if (editor.DialogResult == DialogResult.OK)
                    {
                        try
                        {
                            // создаём параметры ХП
                            var idParam = new FbParameter("INVOICE_LINE_ID", FbDbType.Integer);
                            var quantityParam = new FbParameter("QUANTITY", FbDbType.Integer);
                            // инициализируем параметры значениями
                            idParam.Value = invoiceLine.INVOICE_LINE_ID;
                            quantityParam.Value = invoiceLine.QUANTITY;
                            // выполняем хранимую процедуру
                            dbContext.Database.ExecuteSqlCommand(
                                    "EXECUTE PROCEDURE SP_EDIT_INVOICE_LINE(@INVOICE_LINE_ID, @QUANTITY)",
                                    idParam,
                                    quantityParam);
                            // обновляем гриды
                            // перезагрузка текущей записи счёт-фактуры
                            CurrentInvoice.Load(invoice.INVOICE_ID);
                            // перезагрузка всех записей детейл грида
                            LoadInvoiceLineData(invoice.INVOICE_ID);
                            // обновляем связанные даные
                            masterBinding.ResetCurrentItem();
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

        private void btnDeleteInvoiceLine_Click(object sender, EventArgs e)
        {
            var result = MessageBox.Show("Are you sure you want to delete the invoice item?",
                "Confirm",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                var dbContext = AppVariables.getDbContext();
                // получаем текущую счёт-фактуру
                var invoice = dbContext.INVOICES.Find(this.CurrentInvoice.Id);

                try
                {
                    // проверяем не оплачена ли счёт-фактура
                    if (invoice.PAID == 1)
                        throw new Exception("Remove is impossible, invoice paid.");
                    // создаём параметры ХП
                    var idParam = new FbParameter("INVOICE_LINE_ID", FbDbType.Integer);
                    // инициализируем параметры значениями
                    idParam.Value = this.CurrentInvoiceLine.Id;
                    // выполняем хранимую процедуру
                    dbContext.Database.ExecuteSqlCommand("EXECUTE PROCEDURE SP_DELETE_INVOICE_LINE(@INVOICE_LINE_ID)", idParam);

                    // обновляем гриды
                    // перезагрузка текущей записи счёт-фактуры
                    CurrentInvoice.Load(invoice.INVOICE_ID);
                    // перезагрузка всех записей детейл грида
                    LoadInvoiceLineData(invoice.INVOICE_ID);
                    // обновляем связанные даные
                    masterBinding.ResetCurrentItem();
                }
                catch (Exception ex)
                {
                    // отображаем ошибку
                    MessageBox.Show(ex.Message, "Error");
                }
            }
        }
    }
}
