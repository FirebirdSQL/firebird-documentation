namespace FBMVCExample.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.WEBROLE")]
    public partial class WEBROLE
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int WEBROLE_ID { get; set; }

        [Required]
        [StringLength(63)]
        public string NAME { get; set; }

    }
}