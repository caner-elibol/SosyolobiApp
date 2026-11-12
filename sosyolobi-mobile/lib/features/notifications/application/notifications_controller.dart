import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/polling/poll_ticker.dart';
import '../../auth/application/auth_notifier.dart';
import '../data/notifications_api.dart';
import '../domain/notification.dart';

part 'notifications_controller.g.dart';

@Riverpod(keepAlive: true)
class NotificationsController extends _$NotificationsController {
  @override
  Future<List<AppNotification>> build() async {
    ref.watch(pollTickerProvider);
    final authState = await ref.watch(authProvider.future);
    if (!authState.isAuthenticated) return const [];

    return ref.watch(notificationsApiProvider).getAll();
  }

  Future<void> markRead(String id) async {
    await ref.read(notificationsApiProvider).markRead(id);
    ref.invalidateSelf();
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsApiProvider).markAllRead();
    ref.invalidateSelf();
  }
}

@riverpod
int unreadNotificationsCount(Ref ref) {
  final notifications =
      ref.watch(notificationsControllerProvider).value ?? const [];
  return notifications.where((n) => !n.isRead).length;
}
