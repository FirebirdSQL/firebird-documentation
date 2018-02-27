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
    public class ProductController : Controller
    {
        private DbModel db = new DbModel();

        // GET: Product
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult GetData(int? rows, int? page, string sidx, string sord,
            string searchField, string searchString, string searchOper) {

            int pageNo = page ?? 1;
            int limit = rows ?? 20;
            int offset = (pageNo - 1) * limit;

            var productsQuery =
                from product in db.PRODUCTS
                select new
                {
                    PRODUCT_ID = product.PRODUCT_ID,
                    NAME = product.NAME,
                    PRICE = product.PRICE,
                    DESCRIPTION = product.DESCRIPTION
                };

            if (searchField != null)
            {
                switch (searchOper)
                {
                    case "eq":
                        productsQuery = productsQuery.Where(c => c.NAME == searchString);
                        break;
                    case "bw":
                        productsQuery = productsQuery.Where(c => c.NAME.StartsWith(searchString));
                        break;
                    case "cn":
                        productsQuery = productsQuery.Where(c => c.NAME.Contains(searchString));
                        break;
                }
            }

            int totalRows = productsQuery.Count();

            if (sord == "asc")
            {
                switch (sidx)
                {
                    case "NAME":
                        productsQuery = productsQuery.OrderBy(product => product.NAME);
                        break;

                    case "PRICE":
                        productsQuery = productsQuery.OrderBy(product => product.PRICE);
                        break;
                }
            }
            else {
                switch (sidx)
                {
                    case "NAME":
                        productsQuery = productsQuery.OrderByDescending(product => product.NAME);
                        break;

                    case "PRICE":
                        productsQuery = productsQuery.OrderByDescending(product => product.PRICE);
                        break;
                }
            }

            var products = productsQuery
                .Skip(offset)
                .Take(limit)
                .ToList();

            int totalPages = totalRows / limit + 1;

            var result = new
            {
                page = pageNo,
                total = totalPages,
                records = totalRows,
                rows = products
            };

            return Json(result, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "NAME,PRICE,DESCRIPTION")] PRODUCT product)
        {
            if (ModelState.IsValid)
            {
                product.PRODUCT_ID = db.NextValueFor("GEN_PRODUCT_ID");
                db.PRODUCTS.Add(product);
                db.SaveChanges();
                return Json(true);
            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));

                return Json(new { error = messages });
            }
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PRODUCT_ID,NAME,PRICE,DESCRIPTION")] PRODUCT product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return Json(true);
            }
            else {
                string messages = string.Join("; ", ModelState.Values
                                        .SelectMany(x => x.Errors)
                                        .Select(x => x.ErrorMessage));
                return Json(new { error = messages });
            }
        }

        // POST: Product/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            PRODUCT product = db.PRODUCTS.Find(id);
            db.PRODUCTS.Remove(product);
            db.SaveChanges();
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
