import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/api_error_snackbar.dart';
import '../../../friends/application/friends_providers.dart';
import '../../application/users_actions_provider.dart';
import 'report_user_dialog.dart';

class ParticipantActionsMenu extends ConsumerWidget {
  const ParticipantActionsMenu({
    required this.userId,
    required this.displayName,
    this.onBeforeNavigateToProfile,
    super.key,
  });

  final String userId;
  final String displayName;

  final VoidCallback? onBeforeNavigateToProfile;

  Future<void> _handleFriendAction(BuildContext context, WidgetRef ref, Future<void> Function() action, String successMessage) async {
    await action();
    if (!context.mounted) return;
    final state = ref.read(friendActionsControllerProvider);
    if (state.hasError) {
      showApiErrorSnackBar(context, state.error!);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage)));
  }

  Future<void> _handleBlock(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kullanıcıyı engelle'),
        content: Text('$displayName kullanıcısını engellemek istediğinize emin misiniz? Bu kullanıcının etkinliklerini artık görmeyeceksiniz.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Vazgeç')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Engelle')),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(userActionsControllerProvider.notifier).block(userId);
    if (!context.mounted) return;
    final state = ref.read(userActionsControllerProvider);
    if (state.hasError) {
      showApiErrorSnackBar(context, state.error!);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kullanıcı engellendi.')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendInfo = ref.watch(friendStatusProvider(userId));
    final friendActions = ref.read(friendActionsControllerProvider.notifier);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, size: 18, color: AppColors.mutedForeground),
      onSelected: (value) {
        if (value == 'profile') {
          onBeforeNavigateToProfile?.call();
          context.push(RoutePaths.publicProfile(userId));
        } else if (value == 'report') {
          showReportUserDialog(context, userId: userId, displayName: displayName);
        } else if (value == 'block') {
          _handleBlock(context, ref);
        } else if (value == 'friend-add') {
          _handleFriendAction(context, ref, () => friendActions.sendRequest(userId), 'Arkadaşlık isteği gönderildi.');
        } else if (value == 'friend-cancel') {
          final requestId = friendInfo.request?.id;
          if (requestId != null) {
            _handleFriendAction(context, ref, () => friendActions.cancel(requestId, userId: userId), 'İstek iptal edildi.');
          }
        } else if (value == 'friend-accept') {
          final requestId = friendInfo.request?.id;
          if (requestId != null) {
            _handleFriendAction(context, ref, () => friendActions.accept(requestId, userId: userId), 'Arkadaşlık isteği kabul edildi.');
          }
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'profile', child: Row(children: [Icon(Icons.person_outline, size: 16), SizedBox(width: 8), Text('Profiline Git')])),
        const PopupMenuDivider(),
        if (friendInfo.status == FriendStatus.none)
          const PopupMenuItem(value: 'friend-add', child: Row(children: [Icon(Icons.person_add_alt_1, size: 16), SizedBox(width: 8), Text('Arkadaş Ekle')])),
        if (friendInfo.status == FriendStatus.pendingSent)
          const PopupMenuItem(value: 'friend-cancel', child: Row(children: [Icon(Icons.person_remove_outlined, size: 16), SizedBox(width: 8), Text('İsteği İptal Et')])),
        if (friendInfo.status == FriendStatus.pendingIncoming)
          const PopupMenuItem(value: 'friend-accept', child: Row(children: [Icon(Icons.how_to_reg, size: 16), SizedBox(width: 8), Text('İsteği Kabul Et')])),
        const PopupMenuItem(value: 'report', child: Row(children: [Icon(Icons.flag_outlined, size: 16), SizedBox(width: 8), Text('Şikayet Et')])),
        const PopupMenuItem(
          value: 'block',
          child: Row(
            children: [
              Icon(Icons.block, size: 16, color: AppColors.destructive),
              SizedBox(width: 8),
              Text('Kullanıcıyı Engelle', style: TextStyle(color: AppColors.destructive)),
            ],
          ),
        ),
      ],
    );
  }
}
