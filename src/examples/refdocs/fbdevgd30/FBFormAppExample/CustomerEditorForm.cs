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
    public partial class CustomerEditorForm : Form
    {
        public CustomerEditorForm()
        {
            InitializeComponent();
        }

        public CUSTOMER Customer { get; set; }

        private void CustomerEditorForm_Load(object sender, EventArgs e)
        {
            edtName.DataBindings.Add("Text", this.Customer, "NAME");
            edtAddress.DataBindings.Add("Text", this.Customer, "ADDRESS");
            edtZipCode.DataBindings.Add("Text", this.Customer, "ZIPCODE");
            edtPhone.DataBindings.Add("Text", this.Customer, "PHONE");
        }
    }
}
