using System;
using System.ComponentModel;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.Collections;
using System.Collections.ObjectModel;
using System.Linq;



namespace FBFormAppExample
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
        /// Преобразование IQueryable в BindingList
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="source"></param>
        /// <returns>BindingList</returns>
        public static BindingList<T> ToBindingList<T>
            (this IQueryable<T> source) where T : class
        {
            return (new ObservableCollection<T>(source)).ToBindingList();
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

        /// <summary>
        /// Отсоединение всех объектов коллекции DbSet от контекста
        /// Полезно для обновлении кеша
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dbContext"></param>
        /// <param name="dbSet"></param>
        public static void DetachAll<T>(this DbModel dbContext, DbSet<T> dbSet) where T : class {         
            foreach (var obj in dbSet.Local.ToList())
            {
                dbContext.Entry(obj).State = EntityState.Detached;
            }
        }

        /// <summary>
        /// Обновление всех изменённых объектов в коллекции
        /// </summary>
        /// <param name="dbContext"></param>
        /// <param name="mode"></param>
        /// <param name="collection"></param>
        public static void Refresh(this DbModel dbContext, RefreshMode mode, IEnumerable collection)
        {
            var objectContext = ((IObjectContextAdapter)dbContext).ObjectContext;
            objectContext.Refresh(mode, collection);
        }

        /// <summary>
        /// Обновление объекта
        /// </summary>
        /// <param name="dbContext"></param>
        /// <param name="mode"></param>
        /// <param name="entity"></param>
        public static void Refresh(this DbModel dbContext, RefreshMode mode, object entity)
        {
            var objectContext = ((IObjectContextAdapter)dbContext).ObjectContext;
            objectContext.Refresh(mode, entity);
        }
    }
}
