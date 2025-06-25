using Barbershop.Domain.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace Barbershop.DAL.Configurations;

internal class OrderConfiguration : IEntityTypeConfiguration<Order>
{
    public void Configure(EntityTypeBuilder<Order> builder)
    {
        builder.ToTable("Order");

        builder
            .HasOne(o => o.Barber)
            .WithMany(b => b.Orders)
            .HasForeignKey(k => k.BarberId)
            .OnDelete(DeleteBehavior.Cascade);

        builder
           .HasOne(o => o.Client)
           .WithMany(b => b.Orders)
           .HasForeignKey(k => k.ClientId)
           .OnDelete(DeleteBehavior.Cascade);

        builder.Property(e => e.OrderStatus).HasConversion(new EnumToStringConverter<OrderStatus>());
    }
}