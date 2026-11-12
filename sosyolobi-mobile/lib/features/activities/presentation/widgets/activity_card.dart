import 'package:flutter/material.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/image_url.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../domain/activity.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({required this.activity, required this.onTap, super.key});

  final Activity activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = activity.categoryImageUrl.resolved;
    return imageUrl != null ? _ImageCard(activity: activity, imageUrl: imageUrl, onTap: onTap) : _IconCard(activity: activity, onTap: onTap);
  }
}

class _ImageCard extends StatelessWidget {
  const _ImageCard({required this.activity, required this.imageUrl, required this.onTap});

  final Activity activity;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(activity.categoryName);
    final isFull = activity.status == ActivityStatus.full;
    final dist = Formatters.distanceMeters(activity.distanceMeters);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: SizedBox(
          height: 172,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => _IconCard(activity: activity, onTap: onTap, bare: true),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x0D000000), Color(0x59000000), Color(0xCC000000)],
                    stops: [0, 0.55, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(7, 2, 9, 2),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.22), borderRadius: BorderRadius.circular(AppRadius.full)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                          const SizedBox(width: 5),
                          Text(activity.categoryName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activity.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white, shadows: [Shadow(blurRadius: 3, color: Color(0x66000000))]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 12, color: Color(0xE6FFFFFF)),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            Formatters.eventDate(activity.eventDate),
                            style: const TextStyle(fontSize: 12, color: Color(0xE6FFFFFF), fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isFull) const Text(' · Dolu', style: TextStyle(fontSize: 12, color: Color(0xFFFFB4B4), fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.place_outlined, size: 12, color: Color(0xD9FFFFFF)),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            dist.isNotEmpty ? '${activity.addressText} · $dist' : activity.addressText,
                            style: const TextStyle(fontSize: 12, color: Color(0xD9FFFFFF), fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        UserAvatar(displayName: activity.createdByDisplayName, avatarUrl: activity.createdByAvatarUrl, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '${activity.currentPeopleCount} / ${activity.neededPeopleCount + 1} katılıyor',
                          style: const TextStyle(fontSize: 12, color: Color(0xD9FFFFFF), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconCard extends StatelessWidget {
  const _IconCard({required this.activity, required this.onTap, this.bare = false});

  final Activity activity;
  final VoidCallback onTap;
  final bool bare;

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(activity.categoryName);
    final isFull = activity.status == ActivityStatus.full;
    final dist = Formatters.distanceMeters(activity.distanceMeters);

    final content = Container(
      padding: const EdgeInsets.all(14),
      decoration: bare
          ? null
          : BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(CategoryIcons.iconFor(activity.categoryName), size: 26, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryBadge(name: activity.categoryName, color: color),
                const SizedBox(height: 4),
                Text(
                  activity.title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: AppColors.accent),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        Formatters.eventDate(activity.eventDate),
                        style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isFull)
                      const Text(' · Dolu', style: TextStyle(fontSize: 12, color: AppColors.destructive, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 12, color: AppColors.mutedForeground),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        dist.isNotEmpty ? '${activity.addressText} · $dist' : activity.addressText,
                        style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    UserAvatar(displayName: activity.createdByDisplayName, avatarUrl: activity.createdByAvatarUrl, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      '${activity.currentPeopleCount} / ${activity.neededPeopleCount + 1} katılıyor',
                      style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (bare) return content;
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(AppRadius.lg), child: content);
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(7, 2, 9, 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(AppRadius.full)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 5),
          Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
