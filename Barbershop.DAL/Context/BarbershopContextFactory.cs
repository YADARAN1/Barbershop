using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace Barbershop.DAL.Context;

internal class BarbershopContextFactory : IDesignTimeDbContextFactory<BarbershopContext>
{
    public string ConnectionString { get; } =
        "Host=localhost;Port=5432;Database=Barbershop;Username=postgres;Password=12345";

    public BarbershopContext CreateContext() => CreateDbContext(Array.Empty<string>());

    public BarbershopContext CreateDbContext(string[] args)
    {
        var optionsBuilder = new DbContextOptionsBuilder<BarbershopContext>()
            .UseNpgsql(ConnectionString,
                x => { x.MigrationsHistoryTable("__EFMigrationsHistory", "public"); });

        return new BarbershopContext(optionsBuilder.Options);
    }
}