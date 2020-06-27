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
    public partial class GoodsEditorForm : Form
    {
        public GoodsEditorForm()
        {
            InitializeComponent();
        }

        public PRODUCT Product { get; set; }

        private void GoodsEditorForm_Load(object sender, EventArgs e)
        {
            edtName.DataBindings.Add("Text", this.Product, "NAME");
            edtCost.DataBindings.Add("Value", this.Product, "PRICE");
            edtDescription.DataBindings.Add("Text", this.Product, "DESCRIPTION");
        }
    }
}
