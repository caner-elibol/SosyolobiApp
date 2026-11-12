import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/api_error_snackbar.dart';
import '../../application/friends_providers.dart';

class FriendActionButton extends ConsumerWidget {
  const FriendActionButton({required this.userId, super.key});

  final String userId;

  Future<void> _run(BuildContext context, WidgetRef ref, Future<void> Function() action, String successMessage) async {
    await action();
    if (!context.mounted) return;
    final error = ref.read(friendActionsControllerProvider).hasError;
    if (error) {
      final err = ref.read(friendActionsControllerProvider).error;
      showApiErrorSnackBar(context, err ?? Exception('unknown'));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(friendStatusProvider(userId));
    final actions = ref.read(friendActionsControllerProvider.notifier);
    final busy = ref.watch(friendActionsControllerProvider).isLoading;

    switch (info.status) {
      case FriendStatus.friends:
        return OutlinedButton.icon(
          onPressed: busy ? null : () => _run(context, ref, () => actions.removeFriend(userId), 'Arkadaşlıktan çıkarıldı.'),
          icon: const Icon(Icons.how_to_reg, size: 16),
          label: const Text('Arkadaşsınız'),
        );
      case FriendStatus.pendingSent:
        final requestId = info.request?.id;
        return OutlinedButton.icon(
          onPressed: busy || requestId == null
              ? null
              : () => _run(context, ref, () => actions.cancel(requestId, userId: userId), 'İstek iptal edildi.'),
          icon: const Icon(Icons.person_remove_outlined, size: 16),
          label: const Text('İsteği İptal Et'),
        );
      case FriendStatus.pendingIncoming:
        final requestId = info.request?.id;
        return ElevatedButton.icon(
          onPressed: busy || requestId == null
              ? null
              : () => _run(context, ref, () => actions.accept(requestId, userId: userId), 'Arkadaşlık isteği kabul edildi.'),
          icon: const Icon(Icons.how_to_reg, size: 16),
          label: const Text('İsteği Kabul Et'),
        );
      case FriendStatus.none:
        return ElevatedButton.icon(
          onPressed: busy || info.isLoading ? null : () => _run(context, ref, () => actions.sendRequest(userId), 'Arkadaşlık isteği gönderildi.'),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
          icon: const Icon(Icons.person_add_alt_1, size: 16),
          label: const Text('Arkadaş Ekle'),
        );
    }
  }
}
