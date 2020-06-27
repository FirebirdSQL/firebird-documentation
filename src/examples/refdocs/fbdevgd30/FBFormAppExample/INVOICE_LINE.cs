namespace FBFormAppExample
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.INVOICE_LINE")]
    public partial class INVOICE_LINE
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int INVOICE_LINE_ID { get; set; }

        public int INVOICE_ID { get; set; }

        public int PRODUCT_ID { get; set; }

        public decimal QUANTITY { get; set; }

        public decimal SALE_PRICE { get; set; }

        public virtual INVOICE INVOICE { get; set; }

        public virtual PRODUCT PRODUCT { get; set; }
    }
}
