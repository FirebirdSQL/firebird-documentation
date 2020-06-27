using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FBFormAppExample
{
    public partial class InvoiceEditorForm : Form
    {
        public InvoiceEditorForm()
        {
            InitializeComponent();
        }

        public INVOICE Invoice { get; set; }

        private void btnChooseCustomer_Click(object sender, EventArgs e)
        {
            CustomerForm customerForm = new CustomerForm();
            if (customerForm.ShowDialog() == DialogResult.OK)
            {
                Invoice.CUSTOMER_ID = customerForm.CurrentCustomer.CUSTOMER_ID;
                edtCustomer.Text = customerForm.CurrentCustomer.NAME;
            }
        }

        private void InvoiceEditorForm_Load(object sender, EventArgs e)
        {
            if (this.Invoice.INVOICE_DATE == null)
                this.Invoice.INVOICE_DATE = DateTime.Now;
            edtDate.DataBindings.Add("Value", this.Invoice, "INVOICE_DATE");
            if (this.Invoice.CUSTOMER != null)
            {
                edtCustomer.Text = this.Invoice.CUSTOMER.NAME;
                btnChooseCustomer.Click -= this.btnChooseCustomer_Click;
            }
        }

        private void edtDate_ValueChanged(object sender, EventArgs e)
        {
            this.Invoice.INVOICE_DATE = edtDate.Value; 
        }
    }
}
