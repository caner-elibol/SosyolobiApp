import 'package:flutter/material.dart';

import '../../../../core/domain/category.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/category_icons.dart';

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({required this.categories, required this.selected, required this.onSelect, this.counts, super.key});

  final List<Category> categories;
  final String? selected;
  final ValueChanged<String?> onSelect;
  final Map<String, int>? counts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        children: [
          _Chip(
            active: selected == null,
            label: 'Tümü',
            icon: Icons.public,
            count: counts?.values.fold<int>(0, (sum, n) => sum + n),
            onTap: () => onSelect(null),
          ),
          for (final category in categories) ...[
            const SizedBox(width: 8),
            _Chip(
              active: selected == category.id,
              label: category.name,
              icon: CategoryIcons.iconFor(category.name),
              count: counts?[category.id],
              onTap: () => onSelect(selected == category.id ? null : category.id),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.active, required this.label, required this.icon, required this.onTap, this.count});

  final bool active;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.accentBright : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: active ? AppColors.accentBright : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: active ? Colors.white : AppColors.mutedForeground),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: active ? Colors.white : AppColors.mutedForeground,
              ),
            ),
            if (count != null && count! > 0) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: active ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: active ? Colors.white : AppColors.mutedForeground),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
