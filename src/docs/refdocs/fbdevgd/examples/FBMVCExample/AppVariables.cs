using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FBMVCExample
{
    public class AppVariables
    {
        /// <summary>
        /// Дата начала рабочего периода
        /// </summary>
        public static DateTime StartDate { get; set; }

        /// <summary>
        /// Дата окончания рабочего периода
        /// </summary>
        public static DateTime FinishDate { get; set; }
    }
}