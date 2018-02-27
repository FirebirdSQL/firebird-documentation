namespace FBMVCExample.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Firebird.WEBUSERINROLE")]
    public partial class WEBUSERINROLE
    {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int ID { get; set; }

        [Required]
        public int WEBUSER_ID { get; set; }

        [Required]
        public int WEBROLE_ID { get; set; }

        public virtual WEBUSER WEBUSER { get; set; }

        public virtual WEBROLE WEBROLE { get; set; }
    }
}