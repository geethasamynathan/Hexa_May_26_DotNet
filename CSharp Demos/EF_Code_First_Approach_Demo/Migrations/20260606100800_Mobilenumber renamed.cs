using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EF_Code_First_Approach_Demo.Migrations
{
    /// <inheritdoc />
    public partial class Mobilenumberrenamed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MobileNumner",
                table: "Students",
                newName: "MobileNumber");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MobileNumber",
                table: "Students",
                newName: "MobileNumner");
        }
    }
}
