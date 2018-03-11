namespace FBFormAppExample
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.CUSTOMER")]
    public partial class CUSTOMER
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CUSTOMER()
        {
            INVOICES = new HashSet<INVOICE>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CUSTOMER_ID { get; set; }

        [Required]
        [StringLength(60)]
        public string NAME { get; set; }

        [StringLength(250)]
        public string ADDRESS { get; set; }

        [StringLength(10)]
        public string ZIPCODE { get; set; }

        [StringLength(14)]
        public string PHONE { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<INVOICE> INVOICES { get; set; }
    }
}
