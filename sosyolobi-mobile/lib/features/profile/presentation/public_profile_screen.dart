import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/router/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/trust_badge.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../activities/domain/activity.dart';
import '../../activities/presentation/widgets/activity_card.dart';
import '../../auth/application/auth_notifier.dart';
import '../../friends/application/friends_providers.dart';
import '../../friends/presentation/widgets/friend_action_button.dart';
import '../application/profile_providers.dart';
import '../domain/profile.dart';

class PublicProfileScreen extends ConsumerWidget {
  const PublicProfileScreen({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(authProvider).value?.userId;
    final isSelf = currentUserId != null && currentUserId == userId;

    if (isSelf) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.pushReplacement(RoutePaths.profile);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profileAsync = ref.watch(publicProfileProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: AsyncValueWidget<PublicProfile>(
        value: profileAsync,
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              error is ApiException ? error.message : 'Profil bulunamadı.',
              style: const TextStyle(color: AppColors.destructive),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (profile) => _PublicProfileBody(userId: userId, profile: profile),
      ),
    );
  }
}

class _PublicProfileBody extends ConsumerWidget {
  const _PublicProfileBody({required this.userId, required this.profile});

  final String userId;
  final PublicProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(friendStatusProvider(userId)).status;
    final isFriend = status == FriendStatus.friends;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(AppRadius.xl)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAvatar(displayName: profile.displayName, avatarUrl: profile.avatarUrl, size: 64),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.displayName, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
                        if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(profile.bio!, style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
                        ],
                        const SizedBox(height: 6),
                        TrustBadge(rating: profile.averageRating),
                        const SizedBox(height: 4),
                        Text(
                          '${profile.completedActivityCount} tamamlanan etkinlik · ${profile.reviewCount} yorum',
                          style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              FriendActionButton(userId: userId),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Oluşturduğu Etkinlikler', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        _FriendActivities(userId: userId, isFriend: isFriend),
      ],
    );
  }
}

class _FriendActivities extends ConsumerWidget {
  const _FriendActivities({required this.userId, required this.isFriend});

  final String userId;
  final bool isFriend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isFriend) {
      return const EmptyStateWidget(
        icon: Icons.lock_outline,
        title: 'Etkinlikler kilitli',
        description: 'Bu kullanıcının oluşturduğu etkinlikleri görmek için arkadaş olmanız gerekiyor.',
      );
    }

    final activitiesAsync = ref.watch(friendActivitiesProvider(userId));
    return AsyncValueWidget<List<Activity>>(
      value: activitiesAsync,
      error: (error, stack) => const EmptyStateWidget(icon: Icons.calendar_month_outlined, title: 'Etkinlik bulunamadı', description: 'Bu kullanıcının oluşturduğu aktif bir etkinlik yok.'),
      data: (activities) {
        if (activities.isEmpty) {
          return const EmptyStateWidget(icon: Icons.calendar_month_outlined, title: 'Etkinlik bulunamadı', description: 'Bu kullanıcının oluşturduğu aktif bir etkinlik yok.');
        }
        return Column(
          children: [
            for (final activity in activities) ...[
              ActivityCard(activity: activity, onTap: () => context.push(RoutePaths.activityDetail(activity.id))),
              const SizedBox(height: 12),
            ],
          ],
        );
      },
    );
  }
}
