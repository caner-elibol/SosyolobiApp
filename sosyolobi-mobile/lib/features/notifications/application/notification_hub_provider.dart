import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/realtime/hub_connection_factory.dart';
import '../../auth/application/auth_notifier.dart';
import 'notifications_controller.dart';

part 'notification_hub_provider.g.dart';

@Riverpod(keepAlive: true)
class NotificationHub extends _$NotificationHub {
  HubConnection? _connection;

  @override
  Future<void> build() async {
    final authState = await ref.watch(authProvider.future);
    ref.onDispose(_disconnect);

    if (!authState.isAuthenticated) {
      await _disconnect();
      return;
    }

    await _connect();
  }

  Future<void> _connect() async {
    if (_connection != null) return;
    final tokenStorage = ref.read(tokenStorageProvider);
    final connection = buildHubConnection(AppConfig.notificationHubUrl, tokenStorage);
    _connection = connection;

    connection.on('ReceiveNotification', (arguments) {
      ref.invalidate(notificationsControllerProvider);
    });

    try {
      await connection.start();
    } catch (_) {
    }
  }

  Future<void> _disconnect() async {
    final connection = _connection;
    _connection = null;
    if (connection == null) return;
    await connection.stop();
  }
}
