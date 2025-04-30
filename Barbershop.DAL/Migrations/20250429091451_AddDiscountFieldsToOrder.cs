using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Barbershop.DAL.Migrations
{
    /// <inheritdoc />
    public partial class AddDiscountFieldsToOrder : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "DiscountApplied",
                table: "Order",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<decimal>(
                name: "DiscountRate",
                table: "Order",
                type: "numeric",
                nullable: false,
                defaultValue: 0m);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DiscountApplied",
                table: "Order");

            migrationBuilder.DropColumn(
                name: "DiscountRate",
                table: "Order");
        }
    }
}
