import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chat/application/chat_unread_provider.dart';
import 'notifications_controller.dart';

part 'notifications_providers.g.dart';

@riverpod
int unreadBadgeCount(Ref ref) {
  return ref.watch(unreadNotificationsCountProvider) + ref.watch(totalUnreadChatRoomsProvider);
}
