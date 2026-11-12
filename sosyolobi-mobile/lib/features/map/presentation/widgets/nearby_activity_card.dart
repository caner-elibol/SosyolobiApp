import 'package:flutter/material.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/image_url.dart';
import '../../../activities/domain/activity.dart';

class NearbyActivityCard extends StatelessWidget {
  const NearbyActivityCard({required this.item, required this.onTap, super.key});

  final ActivityMapItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(item.categoryName);
    final isFull = item.status == ActivityStatus.full;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: item.categoryImageUrl.resolved != null
                  ? Image.network(
                      item.categoryImageUrl.resolved!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => _CategoryPlaceholder(name: item.categoryName, color: color),
                    )
                  : _CategoryPlaceholder(name: item.categoryName, color: color),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CategoryBadge(name: item.categoryName, color: color),
                  const SizedBox(height: 5),
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 12, color: AppColors.accent),
                      const SizedBox(width: 5),
                      Text(Formatters.eventDate(item.eventDate), style: const TextStyle(fontSize: 12, color: AppColors.accent, fontWeight: FontWeight.w500)),
                      if (isFull)
                        const Text(' · Dolu', style: TextStyle(fontSize: 12, color: AppColors.destructive, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 12, color: AppColors.mutedForeground),
                      const SizedBox(width: 5),
                      Text(
                        Formatters.distanceMeters(item.distanceMeters).isNotEmpty ? Formatters.distanceMeters(item.distanceMeters) : 'Konum',
                        style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 14, color: AppColors.subtleForeground),
                      const SizedBox(width: 6),
                      Text(
                        '${item.neededPeopleCount} kişi aranıyor',
                        style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPlaceholder extends StatelessWidget {
  const _CategoryPlaceholder({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0.08)],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(CategoryIcons.iconFor(name), size: 34, color: color),
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
