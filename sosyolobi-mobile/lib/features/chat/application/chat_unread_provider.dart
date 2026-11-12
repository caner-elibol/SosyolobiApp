import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/polling/poll_ticker.dart';
import '../../auth/application/auth_notifier.dart';
import '../data/chat_api.dart';
import '../domain/chat.dart';

part 'chat_unread_provider.g.dart';

@Riverpod(keepAlive: true)
class ChatUnread extends _$ChatUnread {
  @override
  Future<List<ChatUnreadSummary>> build() async {
    ref.watch(pollTickerProvider);
    final authState = await ref.watch(authProvider.future);
    if (!authState.isAuthenticated) return const [];

    return ref.watch(chatApiProvider).unreadSummary();
  }

  Future<void> markRead(String roomId) async {
    await ref.read(chatApiProvider).markRead(roomId);
    ref.invalidateSelf();
  }
}

@riverpod
int totalUnreadChatRooms(Ref ref) {
  return ref.watch(chatUnreadProvider).value?.length ?? 0;
}
