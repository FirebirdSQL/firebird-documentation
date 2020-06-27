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
    public partial class DiscountEditorForm : Form
    {
        public DiscountEditorForm()
        {
            InitializeComponent();
        }

        public decimal Discount { get { return edtDiscount.Value; } }
    }
}
