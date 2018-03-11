using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FBMVCExample.Models;

namespace FBMVCExample.Controllers
{
    [Authorize(Roles = "manager")]
    public class CustomerController : Controller
    {
        private DbModel db = new DbModel();

        // Отображение представления
        public ActionResult Index()
        {
            return View();
        }

        // Получение данных в виде JSON для грида
        public ActionResult GetData(int? rows, int? page, string sidx, string sord, 
            string searchField, string searchString, string searchOper)
        {
            // получаем номер страницы, количество отображаемых данных
            int pageNo = page ?? 1;
            int limit = rows ?? 20;
            // вычисляем смещение
            int offset = (pageNo - 1) * limit;

            // строим запрос для получения поставщиков
            var customersQuery =
                from customer in db.CUSTOMERS             
                select new
                {
                    CUSTOMER_ID = customer.CUSTOMER_ID,
                    NAME = customer.NAME,
                    ADDRESS = customer.ADDRESS,
                    ZIPCODE = customer.ZIPCODE,
                    PHONE = customer.PHONE
                };
            // добавлением в запрос условия поиска, если он производится
            if (searchField != null)
            {
                switch (searchOper)
                {
                    case "eq":
                        customersQuery = customersQuery.Where(c => c.NAME == searchString);
                        break;
                    case "bw":
                        customersQuery = customersQuery.Where(c => c.NAME.StartsWith(searchString));
                        break;
                    case "cn":
                        customersQuery = customersQuery.Where(c => c.NAME.Contains(searchString));
                        break;
                }
            }
            // получаем общее количество поставщиков
            int totalRows = customersQuery.Count();

            // добавляем сортировку
            switch (sord) {
                case "asc":
                    customersQuery = customersQuery.OrderBy(customer => customer.NAME);
                    break;
                case "desc":
                    customersQuery = customersQuery.OrderByDescending(customer => customer.NAME);
                    break;
            }

           // получаем список поставщиков
           var customers = customersQuery
                .Skip(offset)
                .Take(limit)
                .ToList();

            // вычисляем общее количество страниц
            int totalPages = totalRows / limit + 1;

            // создаём результат для jqGrid
            var result = new
            {
                page = pageNo,
                total = totalPages,
                records = totalRows,
                rows = customers
            };
            // преобразуем результат в JSON
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        // Добавление нового поставщика
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "NAME,ADDRESS,ZIPCODE,PHONE")] CUSTOMER customer)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                // получаем новый идентификатор с помощью генератора
                customer.CUSTOMER_ID = db.NextValueFor("GEN_CUSTOMER_ID");
                // добавляем модель в список
                db.CUSTOMERS.Add(customer);
                // сохраняем модель
                db.SaveChanges();
                // возвращаем успех в формате JSON
                return Json(true);
            }
            else {
                // соединяем ошибки модели в одну строку
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }

        // Редактирование поставщика
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CUSTOMER_ID,NAME,ADDRESS,ZIPCODE,PHONE")] CUSTOMER customer)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                // помечаем модель как изменённую
                db.Entry(customer).State = EntityState.Modified;
                // сохраняем модель
                db.SaveChanges();
                // возвращаем успех в формате JSON
                return Json(true);
            }
            else {
                // соединяем ошибки модели в одну строку
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }

        // Удаление поставщика
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            // ищем постащика по идентификтаору
            CUSTOMER customer = db.CUSTOMERS.Find(id);
            // удаляем постащика
            db.CUSTOMERS.Remove(customer);
            // сохраняем модель
            db.SaveChanges();
            // возвращаем успех в формате JSON
            return Json(true);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
