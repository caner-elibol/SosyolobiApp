using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sosyolobi.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddChatRoomRead : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "chat_room_reads",
                columns: table => new
                {
                    id = table.Column<Guid>(type: "uuid", nullable: false),
                    user_id = table.Column<Guid>(type: "uuid", nullable: false),
                    chat_room_id = table.Column<Guid>(type: "uuid", nullable: false),
                    last_read_at = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("pk_chat_room_reads", x => x.id);
                    table.ForeignKey(
                        name: "fk_chat_room_reads_chat_rooms_chat_room_id",
                        column: x => x.chat_room_id,
                        principalTable: "chat_rooms",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "fk_chat_room_reads_users_user_id",
                        column: x => x.user_id,
                        principalTable: "users",
                        principalColumn: "id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "ix_chat_room_reads_chat_room_id",
                table: "chat_room_reads",
                column: "chat_room_id");

            migrationBuilder.CreateIndex(
                name: "ix_chat_room_reads_user_id_chat_room_id",
                table: "chat_room_reads",
                columns: new[] { "user_id", "chat_room_id" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "chat_room_reads");
        }
    }
}
