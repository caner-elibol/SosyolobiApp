import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/category_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/image_url.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/user_link.dart';
import '../../auth/application/auth_notifier.dart';
import '../../chat/presentation/chat_panel.dart';
import '../../requests/application/requests_providers.dart';
import '../application/activities_providers.dart';
import '../domain/activity.dart';
import 'widgets/join_activity_dialog.dart';
import 'widgets/owner_requests_dialog.dart';
import 'widgets/participants_dialog.dart';

const _skillLabels = {
  SkillLevel.any: 'Herkes',
  SkillLevel.beginner: 'Başlangıç',
  SkillLevel.intermediate: 'Orta',
  SkillLevel.advanced: 'İleri',
};
const _genderLabels = {
  GenderPreference.any: 'Herkes',
  GenderPreference.male: 'Erkek',
  GenderPreference.female: 'Kadın',
  GenderPreference.mixed: 'Karışık',
};

class ActivityDetailScreen extends ConsumerWidget {
  const ActivityDetailScreen({required this.activityId, super.key});

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityDetailProvider(activityId));

    return Scaffold(
      body: AsyncValueWidget<ActivityDetail>(
        value: activityAsync,
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => const EmptyStateWidget(
          icon: Icons.error_outline,
          title: 'Etkinlik bulunamadı',
          description: '',
        ),
        data: (activity) =>
            _ActivityDetailBody(activityId: activityId, activity: activity),
      ),
    );
  }
}

class _ActivityDetailBody extends ConsumerStatefulWidget {
  const _ActivityDetailBody({required this.activityId, required this.activity});

  final String activityId;
  final ActivityDetail activity;

  @override
  ConsumerState<_ActivityDetailBody> createState() =>
      _ActivityDetailBodyState();
}

class _ActivityDetailBodyState extends ConsumerState<_ActivityDetailBody> {
  Future<void> _handleJoin() async {
    await ref
        .read(requestActionsControllerProvider.notifier)
        .join(widget.activityId);
    if (!mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    if (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('İstek gönderilemedi.')));
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Katılım isteği gönderildi!')));
  }

  Future<void> _openJoinDialog(ActivityDetail activity, Color color) async {
    final totalSpots = activity.neededPeopleCount + 1;
    final priceLabel = (activity.pricePerPerson ?? 0) > 0
        ? '${activity.pricePerPerson} ₺'
        : 'Ücretsiz';
    final confirmed = await showJoinActivityDialog(
      context,
      title: activity.title,
      categoryName: activity.categoryName,
      categoryColor: color,
      categoryIcon: CategoryIcons.iconFor(activity.categoryName),
      dateLabel: Formatters.eventDate(activity.eventDate),
      addressText: activity.addressText,
      priceLabel: priceLabel,
      spotsLabel: '${activity.currentPeopleCount} / $totalSpots kişi',
    );
    if (confirmed) await _handleJoin();
  }

  void _addToCalendar(ActivityDetail activity) {
    final location = (activity.addressDetailPrivate?.isNotEmpty ?? false)
        ? '${activity.addressText}, ${activity.addressDetailPrivate}'
        : activity.addressText;
    final start = activity.eventDate.toLocal();
    Add2Calendar.addEvent2Cal(Event(
      title: activity.title,
      description: activity.description ?? '',
      location: location,
      startDate: start,
      endDate: start.add(const Duration(hours: 2)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final authState = ref.watch(authProvider).value;
    final currentUserId = authState?.userId;
    final color = CategoryIcons.colorFor(activity.categoryName);
    final totalSpots = activity.neededPeopleCount + 1;
    final dist = Formatters.distanceMeters(activity.distanceMeters);
    final isCancelled = activity.status == ActivityStatus.cancelled;
    final isFull = activity.status == ActivityStatus.full;
    final isParticipant =
        currentUserId != null &&
        activity.participants.any((p) => p.userId == currentUserId);
    final hasPendingRequest =
        activity.myRequestStatus == ActivityRequestStatus.pending;
    final canJoin = !isCancelled && !isFull && !isParticipant;
    final isOwner = currentUserId != null && currentUserId == activity.createdByUserId;
    final pendingRequestsAsync = isOwner
        ? ref.watch(activityRequestsProvider(widget.activityId))
        : null;
    final pendingCount = pendingRequestsAsync
            ?.value
            ?.where((r) => r.status == ActivityRequestStatus.pending)
            .length ??
        0;
    final priceLabel = (activity.pricePerPerson ?? 0) > 0
        ? '${activity.pricePerPerson} ₺'
        : 'Ücretsiz';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          expandedHeight: 180,
          leading: const BackButton(color: Colors.white),
          flexibleSpace: FlexibleSpaceBar(
            background: activity.categoryImageUrl.resolved != null
                ? Image.network(
                    activity.categoryImageUrl.resolved!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        _CategoryHeroFallback(activity: activity, color: color),
                  )
                : _CategoryHeroFallback(activity: activity, color: color),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          Formatters.eventDate(activity.eventDate),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                    if (!isCancelled)
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 13,
                            color: AppColors.mutedForeground,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            Formatters.countdown(activity.eventDate),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 14),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (activity.description != null &&
                              activity.description!.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(
                              activity.description!,
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.foreground,
                                height: 1.4,
                              ),
                            ),
                          ],
                          const SizedBox(height: 6),
                          UserLink(
                            userId: activity.createdByUserId,
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.mutedForeground,
                                ),
                                children: [
                                  const TextSpan(text: 'Düzenleyen: '),
                                  TextSpan(
                                    text: activity.createdByDisplayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.foreground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                size: 14,
                                color: AppColors.mutedForeground,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  dist.isNotEmpty
                                      ? '${activity.addressText} · $dist'
                                      : activity.addressText,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.mutedForeground,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (activity.participants.isNotEmpty)
                                SizedBox(
                                  width:
                                      26.0 +
                                      (activity.participants.length.clamp(
                                            0,
                                            4,
                                          ) -
                                          1) *
                                          18.0,
                                  height: 26,
                                  child: Stack(
                                    children: [
                                      for (
                                        var i = 0;
                                        i <
                                            activity.participants
                                                .take(4)
                                                .length;
                                        i++
                                      )
                                        Positioned(
                                          left: i * 18.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.fromBorderSide(
                                                BorderSide(
                                                  color: AppColors.background,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            child: UserAvatar(
                                              displayName: activity
                                                  .participants[i]
                                                  .displayName,
                                              avatarUrl: activity
                                                  .participants[i]
                                                  .avatarUrl,
                                              size: 26,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  '${activity.currentPeopleCount} / $totalSpots katılıyor',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (hasPendingRequest)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(
                                AppRadius.full,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 14,
                                  color: AppColors.mutedForeground,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'İstek Bekliyor',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (canJoin)
                          ElevatedButton.icon(
                            onPressed: () => _openJoinDialog(activity, color),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(Icons.people_outline, size: 15),
                            label: const Text('Katıl'),
                          )
                        else if (isParticipant)
                          ElevatedButton.icon(
                            onPressed: () => _addToCalendar(activity),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(Icons.event_available_outlined, size: 15),
                            label: const Text('Takvime Ekle'),
                          ),
                        if (canJoin || hasPendingRequest || isParticipant)
                          const SizedBox(height: 8),
                        SizedBox(
                          width: 150,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              _CategoryBadge(
                                name: activity.categoryName,
                                color: color,
                              ),
                              if (isCancelled)
                                const _InfoChip(
                                  icon: Icons.cancel_outlined,
                                  label: 'İptal edildi',
                                  tone: _ChipTone.muted,
                                )
                              else if (isFull)
                                const _InfoChip(
                                  icon: Icons.people_outline,
                                  label: 'Dolu',
                                  tone: _ChipTone.muted,
                                )
                              else
                                const _InfoChip(
                                  icon: Icons.people_outline,
                                  label: 'Açık',
                                  tone: _ChipTone.success,
                                ),
                              _InfoChip(
                                icon: Icons.account_balance_wallet_outlined,
                                label: priceLabel,
                              ),
                              _InfoChip(
                                icon: Icons.emoji_events_outlined,
                                label: _skillLabels[activity.skillLevel]!,
                              ),
                              _InfoChip(
                                icon: Icons.people_outline,
                                label:
                                    _genderLabels[activity.genderPreference]!,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (activity.addressDetailPrivate != null &&
                    activity.addressDetailPrivate!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const _SectionTitle('Konum'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.vpn_key_outlined,
                              size: 12,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              activity.addressDetailPrivate!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Bu adres detayı sadece onaylı katılımcılara gösterilir.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (activity.participants.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => showParticipantsDialog(
                      context,
                      participants: activity.participants,
                      currentUserId: currentUserId,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    28.0 +
                                    (activity.participants.length.clamp(
                                          0,
                                          4,
                                        ) -
                                        1) *
                                        20.0,
                                height: 28,
                                child: Stack(
                                  children: [
                                    for (
                                      var i = 0;
                                      i < activity.participants.take(4).length;
                                      i++
                                    )
                                      Positioned(
                                        left: i * 20.0,
                                        child: UserAvatar(
                                          displayName: activity
                                              .participants[i]
                                              .displayName,
                                          avatarUrl: activity
                                              .participants[i]
                                              .avatarUrl,
                                          size: 28,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Katılımcılar · ${activity.participants.length} kişi',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: AppColors.mutedForeground,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (isOwner && pendingCount > 0) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => showOwnerRequestsDialog(context, activityId: widget.activityId),
                      icon: const Icon(Icons.inbox_outlined, size: 16),
                      label: Text('Katılım İstekleri ($pendingCount)'),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (isFull && !isCancelled)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Text(
                      'Kontenjan doldu',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.mutedForeground),
                    ),
                  ),
                if (isCancelled)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.destructiveBg,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Text(
                      'Bu etkinlik iptal edildi',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.destructive),
                    ),
                  ),
                if (isParticipant) ChatPanel(activityId: widget.activityId),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    );
  }
}

enum _ChipTone { none, success, muted }

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.tone = _ChipTone.none,
  });

  final IconData icon;
  final String label;
  final _ChipTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      _ChipTone.success => AppColors.success,
      _ChipTone.muted => AppColors.mutedForeground,
      _ChipTone.none => const Color(0xFF374151),
    };
    final background = tone == _ChipTone.success
        ? AppColors.successBg
        : const Color(0xFFF3F4F6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: tone == _ChipTone.none
                  ? FontWeight.normal
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeroFallback extends StatelessWidget {
  const _CategoryHeroFallback({required this.activity, required this.color});

  final ActivityDetail activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.3)!],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        CategoryIcons.iconFor(activity.categoryName),
        size: 56,
        color: Colors.white.withValues(alpha: 0.85),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
