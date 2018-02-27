namespace FBFormAppExample
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class DbModel : DbContext
    {
        public DbModel()
            : base("name=DbModel")
        {
        }

        public virtual DbSet<CUSTOMER> CUSTOMERS { get; set; }
        public virtual DbSet<INVOICE> INVOICES { get; set; }
        public virtual DbSet<INVOICE_LINE> INVOICE_LINES { get; set; }
        public virtual DbSet<PRODUCT> PRODUCTS { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CUSTOMER>()
                .Property(e => e.ZIPCODE)
                .IsFixedLength();

            modelBuilder.Entity<CUSTOMER>()
                .HasMany(e => e.INVOICES)
                .WithRequired(e => e.CUSTOMER)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PRODUCT>()
                .HasMany(e => e.INVOICE_LINES)
                .WithRequired(e => e.PRODUCT)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PRODUCT>()
                .Property(p => p.PRICE)
                .HasPrecision(15, 2);

            modelBuilder.Entity<INVOICE>()
                .HasMany(e => e.INVOICE_LINES)
                .WithRequired(e => e.INVOICE)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<INVOICE>()
                .Property(p => p.TOTAL_SALE)
                .HasPrecision(15, 2);

            modelBuilder.Entity<INVOICE_LINE>()
                .Property(p => p.SALE_PRICE)
                .HasPrecision(15, 2);

            modelBuilder.Entity<INVOICE_LINE>()
                .Property(p => p.QUANTITY)
                .HasPrecision(15, 0);

        }
    }
}
