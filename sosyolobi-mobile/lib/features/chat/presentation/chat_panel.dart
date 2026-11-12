import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/api_error_snackbar.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/user_avatar.dart';
import '../application/chat_messages_notifier.dart';
import '../application/chat_room_provider.dart';
import '../domain/chat.dart';

class ChatPanel extends ConsumerStatefulWidget {
  const ChatPanel({required this.activityId, super.key});

  final String activityId;

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  ChatMessage? _replyTarget;
  bool _sending = false;

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send(String roomId) async {
    final content = _textController.text.trim();
    if (content.isEmpty || _sending) return;
    setState(() => _sending = true);
    final replyToMessageId = _replyTarget?.id;
    _textController.clear();
    setState(() => _replyTarget = null);
    try {
      await ref.read(chatMessagesProvider(roomId).notifier).sendMessage(
            content: content,
            replyToMessageId: replyToMessageId,
          );
      _scrollToBottom();
    } on ApiException catch (e) {
      if (!mounted) return;
      showApiErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  String _formatTime(DateTime date) => Formatters.time(date);

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(chatRoomProvider(widget.activityId));

    return roomAsync.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const EmptyStateWidget(icon: Icons.forum_outlined, title: 'Sohbete erişilemiyor', description: ''),
      data: (room) => _ChatPanelBody(
        roomId: room.id,
        activityId: widget.activityId,
        initialStatus: room.status,
        textController: _textController,
        scrollController: _scrollController,
        replyTarget: _replyTarget,
        sending: _sending,
        onReply: (message) => setState(() => _replyTarget = message),
        onCancelReply: () => setState(() => _replyTarget = null),
        onSend: _send,
        formatTime: _formatTime,
        scrollToBottom: _scrollToBottom,
      ),
    );
  }
}

class _ChatPanelBody extends ConsumerWidget {
  const _ChatPanelBody({
    required this.roomId,
    required this.activityId,
    required this.initialStatus,
    required this.textController,
    required this.scrollController,
    required this.replyTarget,
    required this.sending,
    required this.onReply,
    required this.onCancelReply,
    required this.onSend,
    required this.formatTime,
    required this.scrollToBottom,
  });

  final String roomId;
  final String activityId;
  final ChatRoomStatus initialStatus;
  final TextEditingController textController;
  final ScrollController scrollController;
  final ChatMessage? replyTarget;
  final bool sending;
  final ValueChanged<ChatMessage> onReply;
  final VoidCallback onCancelReply;
  final Future<void> Function(String roomId) onSend;
  final String Function(DateTime) formatTime;
  final VoidCallback scrollToBottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(roomId));

    ref.listen(chatMessagesProvider(roomId), (previous, next) {
      final prevLen = previous?.value?.messages.length ?? 0;
      final nextLen = next.value?.messages.length ?? 0;
      if (nextLen > prevLen) scrollToBottom();
    });

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(Icons.forum_outlined, size: 17, color: AppColors.accent),
                SizedBox(width: 8),
                Text('Sohbet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: 360,
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => const Center(child: Text('Mesajlar yüklenemedi.')),
              data: (roomState) {
                if (roomState.messages.isEmpty) {
                  return const EmptyStateWidget(icon: Icons.forum_outlined, title: 'Henüz mesaj yok', description: 'İlk mesajı sen gönder.');
                }
                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemCount: roomState.messages.length,
                  itemBuilder: (context, index) {
                    final message = roomState.messages[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onLongPress: () => onReply(message),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UserAvatar(displayName: message.senderDisplayName, avatarUrl: message.senderAvatarUrl, size: 32),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${message.senderDisplayName} · ${formatTime(message.createdAt)}',
                                    style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    constraints: const BoxConstraints(maxWidth: 260),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(AppRadius.md)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (message.replyTo != null)
                                          Container(
                                            padding: const EdgeInsets.only(left: 8),
                                            margin: const EdgeInsets.only(bottom: 6),
                                            decoration: const BoxDecoration(
                                              border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(message.replyTo!.senderDisplayName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent)),
                                                Text(message.replyTo!.content, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis),
                                              ],
                                            ),
                                          ),
                                        Text(message.content, style: const TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildFooter(context, ref, messagesAsync.value?.closed ?? (initialStatus == ChatRoomStatus.closed)),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, WidgetRef ref, bool closed) {
    if (closed) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(color: Color(0xFFF3F4F6), border: Border(top: BorderSide(color: AppColors.border))),
        child: const Text(
          'Bu etkinlik tamamlandığı için sohbet arşivlendi.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: AppColors.mutedForeground),
        ),
      );
    }

    return Column(
      children: [
        if (replyTarget != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                const Icon(Icons.reply, size: 14, color: AppColors.accent),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(replyTarget!.senderDisplayName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.accent)),
                      Text(replyTarget!.content, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.close, size: 16), onPressed: onCancelReply),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border))),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Mesaj yaz...',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(roomId),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: sending ? null : () => onSend(roomId),
                icon: const Icon(Icons.send, size: 18),
                style: IconButton.styleFrom(backgroundColor: AppColors.accent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
