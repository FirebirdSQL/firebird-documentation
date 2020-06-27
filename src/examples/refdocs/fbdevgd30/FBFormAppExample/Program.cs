using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FBFormAppExample
{
    static class Program
    {
        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            AppVariables.StartDate = DateTime.Parse("01.06.2015");
            AppVariables.FinishDate = DateTime.Parse("01.10.2015");


            Application.Run(new MainForm());
        }
    }
}
