import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/utils/image_url.dart';
import '../../../activities/domain/activity.dart';

class ActivityPreviewSheet extends StatelessWidget {
  const ActivityPreviewSheet({required this.item, required this.onGoToActivity, super.key});

  final ActivityMapItem item;
  final VoidCallback onGoToActivity;

  String _formatDistance(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    final color = CategoryIcons.colorFor(item.categoryName);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.categoryImageUrl.resolved != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sm)),
              child: Image.network(
                item.categoryImageUrl.resolved!,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const SizedBox.shrink(),
              ),
            ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(CategoryIcons.iconFor(item.categoryName), size: 15, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(Formatters.eventDate(item.eventDate), style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accentSoftBg,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  '${item.neededPeopleCount} kişi eksik',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.accentSoftFg),
                ),
              ),
              const SizedBox(width: 8),
              Text(_formatDistance(item.distanceMeters), style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onGoToActivity,
              child: const Text('Etkinliğe Git →'),
            ),
          ),
        ],
      ),
    );
  }
}
