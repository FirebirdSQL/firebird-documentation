using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FBFormAppExample
{
    public class InvoiceView
    {
        public int Id { get; set; }
        public int Cusomer_Id { get; set; }
        public string Customer { get; set; }
        public DateTime? Date { get; set; }
        public decimal? Amount { get; set; }
        public string Paid { get; set; }

        public void Load(int Id)
        {
            var dbContext = AppVariables.getDbContext();

            var invoices =
                from invoice in dbContext.INVOICES
                where invoice.INVOICE_ID == Id
                select new InvoiceView
                {
                    Id = invoice.INVOICE_ID,
                    Cusomer_Id = invoice.CUSTOMER_ID,
                    Customer = invoice.CUSTOMER.NAME,
                    Date = invoice.INVOICE_DATE,
                    Amount = invoice.TOTAL_SALE,
                    Paid = (invoice.PAID == 1) ? "Yes" : "No"
                };

            InvoiceView invoiceView = invoices.ToList().First();
            this.Id = invoiceView.Id;
            this.Cusomer_Id = invoiceView.Cusomer_Id;
            this.Customer = invoiceView.Customer;
            this.Date = invoiceView.Date;
            this.Amount = invoiceView.Amount;
            this.Paid = invoiceView.Paid;
        }
    }

    public class InvoiceLineView
    {
        public int Id { get; set; }
        public int Invoice_Id { get; set; }
        public int Product_Id { get; set; }
        public string Product { get; set; }
        public decimal Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal Total { get; set; }
    }
}
