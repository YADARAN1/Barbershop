using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Barbershop.DAL.Migrations
{
    /// <inheritdoc />
    public partial class ServiceMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ServiceSkillLevel_Service_ServiceId",
                table: "ServiceSkillLevel");

            migrationBuilder.AddForeignKey(
                name: "FK_ServiceSkillLevel_Service_ServiceId",
                table: "ServiceSkillLevel",
                column: "ServiceId",
                principalTable: "Service",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ServiceSkillLevel_Service_ServiceId",
                table: "ServiceSkillLevel");

            migrationBuilder.AddForeignKey(
                name: "FK_ServiceSkillLevel_Service_ServiceId",
                table: "ServiceSkillLevel",
                column: "ServiceId",
                principalTable: "Service",
                principalColumn: "Id");
        }
    }
}
