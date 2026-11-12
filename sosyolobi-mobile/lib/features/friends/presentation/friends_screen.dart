import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widgets/api_error_snackbar.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/user_link.dart';
import '../../../core/utils/formatters.dart';
import '../application/friends_providers.dart';
import '../domain/friend.dart';

enum _FriendsTab { list, incoming, sent }

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  _FriendsTab _tab = _FriendsTab.list;

  @override
  Widget build(BuildContext context) {
    final incomingCount = ref.watch(incomingFriendRequestsProvider).value?.length ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Arkadaşlar')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(AppRadius.md)),
              child: Row(
                children: [
                  Expanded(child: _TabButton(label: 'Arkadaşlarım', active: _tab == _FriendsTab.list, onTap: () => setState(() => _tab = _FriendsTab.list))),
                  Expanded(
                    child: _TabButton(
                      label: 'Gelen İstekler',
                      badge: incomingCount > 0 ? incomingCount : null,
                      active: _tab == _FriendsTab.incoming,
                      onTap: () => setState(() => _tab = _FriendsTab.incoming),
                    ),
                  ),
                  Expanded(child: _TabButton(label: 'Gönderdiğim', active: _tab == _FriendsTab.sent, onTap: () => setState(() => _tab = _FriendsTab.sent))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: switch (_tab) {
                _FriendsTab.list => const _FriendsList(),
                _FriendsTab.incoming => const _IncomingRequestsList(),
                _FriendsTab.sent => const _SentRequestsList(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.label, required this.active, required this.onTap, this.badge});

  final String label;
  final bool active;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.surface : null,
          borderRadius: BorderRadius.circular(9),
          boxShadow: active ? [const BoxShadow(color: Color(0x14000000), blurRadius: 4)] : null,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: active ? AppColors.foreground : AppColors.mutedForeground)),
            if (badge != null) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(AppRadius.full)),
                child: Text('$badge', style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FriendsList extends ConsumerWidget {
  const _FriendsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendsAsync = ref.watch(friendsProvider);
    return AsyncValueWidget<List<Friend>>(
      value: friendsAsync,
      data: (friends) {
        if (friends.isEmpty) {
          return const EmptyStateWidget(icon: Icons.people_outline, title: 'Henüz arkadaşınız yok', description: 'Etkinlik katılımcılarını arkadaş olarak ekleyebilirsiniz.');
        }
        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(friendsProvider),
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: friends.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) => _FriendTile(friend: friends[index]),
          ),
        );
      },
    );
  }
}

class _FriendTile extends ConsumerWidget {
  const _FriendTile({required this.friend});

  final Friend friend;

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arkadaşlıktan çıkar'),
        content: Text('${friend.user.displayName} kullanıcısını arkadaşlıktan çıkarmak istediğinize emin misiniz?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Vazgeç')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Çıkar')),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(friendActionsControllerProvider.notifier).removeFriend(friend.user.userId);
    if (!context.mounted) return;
    final error = ref.read(friendActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ? 'İşlem başarısız.' : 'Arkadaşlıktan çıkarıldı.')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(AppRadius.lg)),
      child: Row(
        children: [
          UserLink(
            userId: friend.user.userId,
            child: Row(
              children: [
                UserAvatar(displayName: friend.user.displayName, avatarUrl: friend.user.avatarUrl, size: 44),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(friend.user.displayName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    Text('${Formatters.shortDate(friend.friendsSinceUtc)} tarihinden beri arkadaş', style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => _remove(context, ref),
            icon: const Icon(Icons.person_remove_outlined, size: 18, color: AppColors.destructive),
            tooltip: 'Arkadaşlıktan çıkar',
          ),
        ],
      ),
    );
  }
}

class _IncomingRequestsList extends ConsumerWidget {
  const _IncomingRequestsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incomingAsync = ref.watch(incomingFriendRequestsProvider);
    return AsyncValueWidget<List<FriendRequest>>(
      value: incomingAsync,
      data: (requests) {
        if (requests.isEmpty) {
          return const EmptyStateWidget(icon: Icons.inbox_outlined, title: 'Gelen istek yok', description: 'Size gelen arkadaşlık istekleri burada görünecek.');
        }
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: requests.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _RequestTile(request: requests[index], mode: _RequestTileMode.incoming),
        );
      },
    );
  }
}

class _SentRequestsList extends ConsumerWidget {
  const _SentRequestsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sentAsync = ref.watch(sentFriendRequestsProvider);
    return AsyncValueWidget<List<FriendRequest>>(
      value: sentAsync,
      data: (requests) {
        if (requests.isEmpty) {
          return const EmptyStateWidget(icon: Icons.send_outlined, title: 'Gönderdiğiniz istek yok', description: 'Gönderdiğiniz arkadaşlık istekleri burada görünecek.');
        }
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: requests.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) => _RequestTile(request: requests[index], mode: _RequestTileMode.sent),
        );
      },
    );
  }
}

enum _RequestTileMode { incoming, sent }

class _RequestTile extends ConsumerWidget {
  const _RequestTile({required this.request, required this.mode});

  final FriendRequest request;
  final _RequestTileMode mode;

  Future<void> _act(BuildContext context, WidgetRef ref, Future<void> Function() action, String successMessage, String failureMessage) async {
    await action();
    if (!context.mounted) return;
    final error = ref.read(friendActionsControllerProvider).hasError;
    if (error) {
      final err = ref.read(friendActionsControllerProvider).error;
      showApiErrorSnackBar(context, err ?? Exception(failureMessage));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMessage)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.read(friendActionsControllerProvider.notifier);
    final busy = ref.watch(friendActionsControllerProvider).isLoading;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(AppRadius.lg)),
      child: Row(
        children: [
          UserLink(
            userId: request.user.userId,
            child: Row(
              children: [
                UserAvatar(displayName: request.user.displayName, avatarUrl: request.user.avatarUrl, size: 44),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.user.displayName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    if (request.user.averageRating > 0)
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 4),
                          Text('${request.user.averageRating.toStringAsFixed(1)} · ${request.user.completedActivityCount} etkinlik', style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          if (mode == _RequestTileMode.incoming) ...[
            IconButton(
              onPressed: busy ? null : () => _act(context, ref, () => actions.reject(request.id, userId: request.user.userId), 'İstek reddedildi.', 'Reddedilemedi.'),
              icon: const Icon(Icons.close, size: 18, color: AppColors.destructive),
            ),
            IconButton(
              onPressed: busy ? null : () => _act(context, ref, () => actions.accept(request.id, userId: request.user.userId), 'Arkadaşlık isteği kabul edildi.', 'Kabul edilemedi.'),
              icon: const Icon(Icons.check, size: 18, color: AppColors.success),
            ),
          ] else
            OutlinedButton(
              onPressed: busy ? null : () => _act(context, ref, () => actions.cancel(request.id, userId: request.user.userId), 'İstek iptal edildi.', 'İptal edilemedi.'),
              child: const Text('İptal Et'),
            ),
        ],
      ),
    );
  }
}
