using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sosyolobi.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddCategoryImageUrl : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "image_fetched_at",
                table: "activity_categories",
                type: "timestamp with time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "image_url",
                table: "activity_categories",
                type: "text",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "image_fetched_at",
                table: "activity_categories");

            migrationBuilder.DropColumn(
                name: "image_url",
                table: "activity_categories");
        }
    }
}
