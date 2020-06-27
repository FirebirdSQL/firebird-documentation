namespace FBFormAppExample
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.INVOICE")]
    public partial class INVOICE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public INVOICE()
        {
            INVOICE_LINES = new HashSet<INVOICE_LINE>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int INVOICE_ID { get; set; }

        public int CUSTOMER_ID { get; set; }

        public DateTime? INVOICE_DATE { get; set; }

        public decimal? TOTAL_SALE { get; set; }

        public short PAID { get; set; }

        public virtual CUSTOMER CUSTOMER { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<INVOICE_LINE> INVOICE_LINES { get; set; }
    }
}
