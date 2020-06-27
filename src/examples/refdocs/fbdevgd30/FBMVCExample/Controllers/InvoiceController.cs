using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FirebirdSql.Data.FirebirdClient;
using FBMVCExample.Models;

namespace FBMVCExample.Controllers
{
    [Authorize(Roles = "manager")]
    public class InvoiceController : Controller
    {
        private DbModel db = new DbModel();

        // Отображение представления
        public ActionResult Index()
        {
            return View();
        }

        // Получение данных в виде JSON для главного грида
        public ActionResult GetData(int? rows, int? page, string sidx, string sord,
            string searchField, string searchString, string searchOper)
        {
            // получаем номер страницы, количество отображаемых данных
            int pageNo = page ?? 1;
            int limit = rows ?? 20;
            // вычисляем смещение
            int offset = (pageNo - 1) * limit;

            // строим запрос для получения счёт-фактур
            var invoicesQuery =
                from invoice in db.INVOICES
                where (invoice.INVOICE_DATE >= AppVariables.StartDate) &&
                      (invoice.INVOICE_DATE <= AppVariables.FinishDate)
                select new
                {
                    INVOICE_ID = invoice.INVOICE_ID,
                    CUSTOMER_ID = invoice.CUSTOMER_ID,
                    CUSTOMER_NAME = invoice.CUSTOMER.NAME,
                    INVOICE_DATE = invoice.INVOICE_DATE,
                    TOTAL_SALE = invoice.TOTAL_SALE,
                    PAID = invoice.PAID
                };

            // добавлением в запрос условия поиска, если он производится
            // для разных полей доступны разные операторы
            // сравнения при поиске
            if (searchField == "CUSTOMER_NAME")
            {
                switch (searchOper)
                {
                    case "eq": // equal
                        invoicesQuery = invoicesQuery.Where(c => c.CUSTOMER_NAME == searchString);
                        break;
                    case "bw": // starting with
                        invoicesQuery = invoicesQuery.Where(c => c.CUSTOMER_NAME.StartsWith(searchString));
                        break;
                    case "cn": // containing
                        invoicesQuery = invoicesQuery.Where(c => c.CUSTOMER_NAME.Contains(searchString));
                        break;
                }
            }
            if (searchField == "INVOICE_DATE")
            {
                var dateValue = DateTime.Parse(searchString);
                switch (searchOper)
                {
                    case "eq": // =
                        invoicesQuery = invoicesQuery.Where(c => c.INVOICE_DATE == dateValue);
                        break;
                    case "lt": // <
                        invoicesQuery = invoicesQuery.Where(c => c.INVOICE_DATE < dateValue);
                        break;
                    case "le": // <=
                        invoicesQuery = invoicesQuery.Where(c => c.INVOICE_DATE <= dateValue);
                        break;
                    case "gt": // >
                        invoicesQuery = invoicesQuery.Where(c => c.INVOICE_DATE > dateValue);
                        break;
                    case "ge": // >=
                        invoicesQuery = invoicesQuery.Where(c => c.INVOICE_DATE >= dateValue);
                        break;

                }
            }
            if (searchField == "PAID")
            {
                int iVal = (searchString == "on") ? 1 : 0;
                invoicesQuery = invoicesQuery.Where(c => c.PAID == iVal);
            }

            // получаем общее количество счёт-фактур
            int totalRows = invoicesQuery.Count();

            // добавляем сортировку
            switch (sord)
            {
                case "asc":
                    invoicesQuery = invoicesQuery.OrderBy(invoice => invoice.INVOICE_DATE);
                    break;
                case "desc":
                    invoicesQuery = invoicesQuery.OrderByDescending(invoice => invoice.INVOICE_DATE);
                    break;
            }

            // получаем список счёт-фактур
            var invoices = invoicesQuery
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
                rows = invoices
            };

            // преобразуем результат в JSON
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        // Получение данных в виде JSON для детализирующего грида
        public ActionResult GetDetailData(int? invoice_id)
        {

            // строим запрос для получения позиций счёт-фактуры
            // отфильтрованный по коду счёт-фактуры
            var lines =
                from line in db.INVOICE_LINES
                where line.INVOICE_ID == invoice_id
                select new
                {
                    INVOICE_LINE_ID = line.INVOICE_LINE_ID,
                    INVOICE_ID = line.INVOICE_ID,
                    PRODUCT_ID = line.PRODUCT_ID,
                    Product = line.PRODUCT.NAME,
                    Quantity = line.QUANTITY,
                    Price = line.SALE_PRICE,
                    Total = line.QUANTITY * line.SALE_PRICE
                };

            // получаем список позиций 
            var invoices = lines
                .ToList();

            // создаём результат для jqGrid
            var result = new
            {
                rows = invoices
            };

            // преобразуем результат в JSON
            return Json(result, JsonRequestBehavior.AllowGet);
        }


        // Добавление новой шапки счёт-фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CUSTOMER_ID,INVOICE_DATE")] INVOICE invoice)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                try
                {

                    var INVOICE_ID = new FbParameter("INVOICE_ID", FbDbType.Integer);
                    var CUSTOMER_ID = new FbParameter("CUSTOMER_ID", FbDbType.Integer);
                    var INVOICE_DATE = new FbParameter("INVOICE_DATE", FbDbType.TimeStamp);
                    // инициализируем параметры значениями
                    INVOICE_ID.Value = db.NextValueFor("GEN_INVOICE_ID");
                    CUSTOMER_ID.Value = invoice.CUSTOMER_ID;
                    INVOICE_DATE.Value = invoice.INVOICE_DATE;
                    // выполняем ХП
                    db.Database.ExecuteSqlCommand(
                        "EXECUTE PROCEDURE SP_ADD_INVOICE(@INVOICE_ID, @CUSTOMER_ID, @INVOICE_DATE)",
                        INVOICE_ID,
                        CUSTOMER_ID,
                        INVOICE_DATE);
                    // возвращаем успех в формате JSON
                    return Json(true);
                }
                catch (Exception ex)
                {
                    // возвращаем ошибку в формате JSON
                    return Json(new { error = ex.Message });
                }

            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }


        // Редактирование шапки счёт-фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "INVOICE_ID,CUSTOMER_ID,INVOICE_DATE")] INVOICE invoice)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                try
                {
                    var INVOICE_ID = new FbParameter("INVOICE_ID", FbDbType.Integer);
                    var CUSTOMER_ID = new FbParameter("CUSTOMER_ID", FbDbType.Integer);
                    var INVOICE_DATE = new FbParameter("INVOICE_DATE", FbDbType.TimeStamp);
                    // инициализируем параметры значениями
                    INVOICE_ID.Value = invoice.INVOICE_ID;
                    CUSTOMER_ID.Value = invoice.CUSTOMER_ID;
                    INVOICE_DATE.Value = invoice.INVOICE_DATE;
                    // выполняем ХП
                    db.Database.ExecuteSqlCommand(
                        "EXECUTE PROCEDURE SP_EDIT_INVOICE(@INVOICE_ID, @CUSTOMER_ID, @INVOICE_DATE)",
                        INVOICE_ID,
                        CUSTOMER_ID,
                        INVOICE_DATE);
                    // возвращаем успех в формате JSON
                    return Json(true);
                }
                catch (Exception ex)
                {
                    // возвращаем ошибку в формате JSON
                    return Json(new { error = ex.Message });
                }
            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }


        // Удаление шапки счёт-фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            try
            {
                var INVOICE_ID = new FbParameter("INVOICE_ID", FbDbType.Integer);
                // инициализируем параметры значениями
                INVOICE_ID.Value = id;
                // выполняем ХП
                db.Database.ExecuteSqlCommand(
                    "EXECUTE PROCEDURE SP_DELETE_INVOICE(@INVOICE_ID)",
                    INVOICE_ID);
                // возвращаем успех в формате JSON
                return Json(true);
            }
            catch (Exception ex)
            {
                // возвращаем ошибку в формате JSON
                return Json(new { error = ex.Message });
            }
        }

        // Оплата счёт фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Pay(int id)
        {
            try
            {
                var INVOICE_ID = new FbParameter("INVOICE_ID", FbDbType.Integer);
                // инициализируем параметры значениями
                INVOICE_ID.Value = id;
                // выполняем ХП
                db.Database.ExecuteSqlCommand(
                    "EXECUTE PROCEDURE SP_PAY_FOR_INOVICE(@INVOICE_ID)",
                    INVOICE_ID);
                // возвращаем успех в формате JSON
                return Json(true);
            }
            catch (Exception ex)
            {
                // возвращаем ошибку в формате JSON
                return Json(new { error = ex.Message });
            }
        }

        // Добавление позиции счёт фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateDetail([Bind(Include = "INVOICE_ID,PRODUCT_ID,QUANTITY")] INVOICE_LINE invoiceLine)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                try
                {
                    var INVOICE_ID = new FbParameter("INVOICE_ID", FbDbType.Integer);
                    var PRODUCT_ID = new FbParameter("PRODUCT_ID", FbDbType.Integer);
                    var QUANTITY = new FbParameter("QUANTITY", FbDbType.Integer);
                    // инициализируем параметры значениями
                    INVOICE_ID.Value = invoiceLine.INVOICE_ID;
                    PRODUCT_ID.Value = invoiceLine.PRODUCT_ID;
                    QUANTITY.Value = invoiceLine.QUANTITY;
                    // выполняем ХП
                    db.Database.ExecuteSqlCommand(
                        "EXECUTE PROCEDURE SP_ADD_INVOICE_LINE(@INVOICE_ID, @PRODUCT_ID, @QUANTITY)",
                        INVOICE_ID,
                        PRODUCT_ID,
                        QUANTITY);
                    // возвращаем успех в формате JSON
                    return Json(true);
                }
                catch (Exception ex)
                {
                    // возвращаем ошибку в формате JSON
                    return Json(new { error = ex.Message });
                }

            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }

        // редактирование позиции счёт фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditDetail([Bind(Include = "INVOICE_LINE_ID,INVOICE_ID,PRODUCT_ID,QUANTITY")] INVOICE_LINE invoiceLine)
        {
            // проверяем правильность модели
            if (ModelState.IsValid)
            {
                try
                {
                    // Создание параметров
                    var INVOICE_LINE_ID = new FbParameter("INVOICE_LINE_ID", FbDbType.Integer);
                    var QUANTITY = new FbParameter("QUANTITY", FbDbType.Integer);
                    // инициализируем параметры значениями
                    INVOICE_LINE_ID.Value = invoiceLine.INVOICE_LINE_ID;
                    QUANTITY.Value = invoiceLine.QUANTITY;
                    // выполняем ХП
                    db.Database.ExecuteSqlCommand(
                        "EXECUTE PROCEDURE SP_EDIT_INVOICE_LINE(@INVOICE_LINE_ID, @QUANTITY)",
                        INVOICE_LINE_ID,
                        QUANTITY);
                    // возвращаем успех в формате JSON
                    return Json(true);
                }
                catch (Exception ex)
                {
                    // возвращаем ошибку в формате JSON
                    return Json(new { error = ex.Message });
                }
            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                // возвращаем ошибку в формате JSON
                return Json(new { error = messages });
            }
        }

        // Удаление позиции счёт фактуры
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteDetail(int id)
        {
            try
            {
                // Создание параметров
                var INVOICE_LINE_ID = new FbParameter("INVOICE_LINE_ID", FbDbType.Integer);
                // инициализируем параметры значениями
                INVOICE_LINE_ID.Value = id;
                // выполняем ХП
                db.Database.ExecuteSqlCommand(
                    "EXECUTE PROCEDURE SP_DELETE_INVOICE_LINE(@INVOICE_LINE_ID)",
                    INVOICE_LINE_ID);
                // возвращаем успех в формате JSON
                return Json(true);
            }
            catch (Exception ex)
            {
                // возвращаем ошибку в формате JSON
                return Json(new { error = ex.Message });
            }
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
