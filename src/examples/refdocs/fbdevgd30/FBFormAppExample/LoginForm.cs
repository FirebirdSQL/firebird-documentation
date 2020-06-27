using System;
using System.Windows.Forms;

namespace FBFormAppExample
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        public string UserName
        {
            get
            {
                return edtUserName.Text;
            }
            set
            {
                edtUserName.Text = value;
            }
        }

        public string Password
        {
            get
            {
                return edtPassword.Text;
            }
            set
            {
                edtPassword.Text = value;
            }
        }
    }
}
