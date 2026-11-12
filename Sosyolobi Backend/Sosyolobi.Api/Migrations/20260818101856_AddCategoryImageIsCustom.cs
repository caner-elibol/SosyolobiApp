using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sosyolobi.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddCategoryImageIsCustom : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "image_is_custom",
                table: "activity_categories",
                type: "boolean",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "image_is_custom",
                table: "activity_categories");
        }
    }
}
