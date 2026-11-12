import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/date_filters.dart';

class DateRangeFilterRow extends StatelessWidget {
  const DateRangeFilterRow({
    required this.selected,
    required this.onSelect,
    required this.weekendOnly,
    required this.onWeekendOnlyChanged,
    super.key,
  });

  final DateFilterKey selected;
  final ValueChanged<DateFilterKey> onSelect;
  final bool weekendOnly;
  final ValueChanged<bool> onWeekendOnlyChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        children: [
          for (final option in dateFilterOptions) ...[
            _Chip(label: option.label, active: selected == option.value, onTap: () => onSelect(option.value)),
            const SizedBox(width: 8),
          ],
          _Chip(
            label: 'Sadece Hafta Sonu',
            active: weekendOnly,
            icon: Icons.weekend_outlined,
            onTap: () => onWeekendOnlyChanged(!weekendOnly),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.active, required this.onTap, this.icon});

  final String label;
  final bool active;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.navy : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: active ? AppColors.navy : AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: active ? Colors.white : AppColors.mutedForeground),
              const SizedBox(width: 5),
            ],
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: active ? Colors.white : AppColors.mutedForeground)),
          ],
        ),
      ),
    );
  }
}
