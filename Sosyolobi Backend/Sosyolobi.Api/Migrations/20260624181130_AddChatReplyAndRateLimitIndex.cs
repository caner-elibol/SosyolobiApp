using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Sosyolobi.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddChatReplyAndRateLimitIndex : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "ix_chat_messages_chat_room_id",
                table: "chat_messages");

            migrationBuilder.AddColumn<Guid>(
                name: "reply_to_message_id",
                table: "chat_messages",
                type: "uuid",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "ix_chat_messages_chat_room_id_sender_user_id_created_at",
                table: "chat_messages",
                columns: new[] { "chat_room_id", "sender_user_id", "created_at" });

            migrationBuilder.CreateIndex(
                name: "ix_chat_messages_reply_to_message_id",
                table: "chat_messages",
                column: "reply_to_message_id");

            migrationBuilder.AddForeignKey(
                name: "fk_chat_messages_chat_messages_reply_to_message_id",
                table: "chat_messages",
                column: "reply_to_message_id",
                principalTable: "chat_messages",
                principalColumn: "id",
                onDelete: ReferentialAction.SetNull);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "fk_chat_messages_chat_messages_reply_to_message_id",
                table: "chat_messages");

            migrationBuilder.DropIndex(
                name: "ix_chat_messages_chat_room_id_sender_user_id_created_at",
                table: "chat_messages");

            migrationBuilder.DropIndex(
                name: "ix_chat_messages_reply_to_message_id",
                table: "chat_messages");

            migrationBuilder.DropColumn(
                name: "reply_to_message_id",
                table: "chat_messages");

            migrationBuilder.CreateIndex(
                name: "ix_chat_messages_chat_room_id",
                table: "chat_messages",
                column: "chat_room_id");
        }
    }
}
