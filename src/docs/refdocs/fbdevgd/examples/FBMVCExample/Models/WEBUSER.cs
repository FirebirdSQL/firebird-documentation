namespace FBMVCExample.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.WEBUSER")]
    public partial class WEBUSER
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public WEBUSER()
        {
            WEBUSERINROLES = new HashSet<WEBUSERINROLE>();
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int WEBUSER_ID { get; set; }

        [Required]
        [StringLength(63)]
        public string EMAIL { get; set; }

        [Required]
        [StringLength(63)]
        public string PASSWD { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<WEBUSERINROLE> WEBUSERINROLES { get; set; }
    }
}