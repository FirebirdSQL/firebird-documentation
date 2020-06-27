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
    public partial class RangeDateForm : Form
    {
        public RangeDateForm()
        {
            InitializeComponent();
        }

        public DateTime StartDate {
            get {
                return edtDateBegin.Value;
            }
            set {
                edtDateBegin.Value = value;
            }
        }

        public DateTime FinishDate {
            get {
                return edtDateEnd.Value;
            }
            set
            {
                edtDateEnd.Value = value;
            }
        }
    }
}
