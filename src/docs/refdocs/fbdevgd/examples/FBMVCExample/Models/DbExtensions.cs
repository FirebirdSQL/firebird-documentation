using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FBMVCExample.Models
{
    public static class DbExtensions
    {
        /// <summary>
        /// Внутренний класс для маппинга на него значения генератора
        /// </summary>
        private class IdResult
        {
            public int Id { get; set; }
        }

        /// <summary>
        /// Получение следующего значения последовательности
        /// </summary>
        /// <param name="dbContext"></param>
        /// <param name="genName"></param>
        /// <returns>Значение последовательности</returns>
        public static int NextValueFor(this DbModel dbContext, string genName)
        {
            string sql = String.Format("SELECT NEXT VALUE FOR {0} AS Id FROM RDB$DATABASE", genName);
            return dbContext.Database.SqlQuery<IdResult>(sql).First().Id;
        }
    }
}