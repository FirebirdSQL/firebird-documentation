using System;


namespace FBFormAppExample
{
    static class AppVariables
    {

        private static DbModel dbContext = null;


         /// <summary>
         /// Дата начала рабочего периода
         /// </summary>
         public static DateTime StartDate { get; set; }

         /// <summary>
         /// Дата окончания рабочего периода
         /// </summary>
         public static DateTime FinishDate { get; set; }

        /// <summary>
        /// Возвращает экземпляр модели (контекста)
        /// </summary>
        /// <returns>Модель</returns>
        public static DbModel getDbContext() {
            dbContext = dbContext ?? new DbModel();
            return dbContext;
        }
    }
}
