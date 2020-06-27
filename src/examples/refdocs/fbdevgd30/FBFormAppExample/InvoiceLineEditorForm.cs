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
    public partial class InvoiceLineEditorForm : Form
    {
        public InvoiceLineEditorForm()
        {
            InitializeComponent();
        }


        public INVOICE_LINE InvoiceLine { get; set; }

        private void InvoiceLineEditorForm_Load(object sender, EventArgs e)
        {
            if (this.InvoiceLine.PRODUCT != null) {
                edtProduct.Text = this.InvoiceLine.PRODUCT.NAME;
                edtPrice.Text = this.InvoiceLine.PRODUCT.PRICE.ToString("F2");
                btnChooseProduct.Click -= this.btnChooseProduct_Click;
            }
            if (this.InvoiceLine.QUANTITY == 0)
                this.InvoiceLine.QUANTITY = 1;
            edtQuantity.DataBindings.Add("Value", this.InvoiceLine, "QUANTITY");
        }

        private void btnChooseProduct_Click(object sender, EventArgs e)
        {
            GoodsForm goodsForm = new GoodsForm();
            if (goodsForm.ShowDialog() == DialogResult.OK)
            {
                InvoiceLine.PRODUCT_ID = goodsForm.CurrentProduct.PRODUCT_ID;
                edtProduct.Text = goodsForm.CurrentProduct.NAME;
                edtPrice.Text = goodsForm.CurrentProduct.PRICE.ToString("F2");
            }
        }
    }
}
