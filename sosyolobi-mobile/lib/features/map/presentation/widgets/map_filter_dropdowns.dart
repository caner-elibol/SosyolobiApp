import 'package:flutter/material.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/colors.dart';

const radiusOptions = [
  (label: '2 km', value: 2000),
  (label: '5 km', value: 5000),
  (label: '10 km', value: 10000),
  (label: '25 km', value: 25000),
  (label: '50 km', value: 50000),
];

const genderOptions = [
  (label: 'Tümü', value: null),
  (label: 'Erkek', value: GenderPreference.male),
  (label: 'Kadın', value: GenderPreference.female),
  (label: 'Karışık', value: GenderPreference.mixed),
];

const priceOptions = [
  (label: 'Tümü', value: null),
  (label: 'Ücretsiz', value: true),
  (label: 'Ücretli', value: false),
];

class MapFilterDropdownsRow extends StatelessWidget {
  const MapFilterDropdownsRow({
    required this.radiusMeters,
    required this.onRadiusChanged,
    required this.gender,
    required this.onGenderChanged,
    required this.isFree,
    required this.onIsFreeChanged,
    super.key,
  });

  final int radiusMeters;
  final ValueChanged<int> onRadiusChanged;
  final GenderPreference? gender;
  final ValueChanged<GenderPreference?> onGenderChanged;
  final bool? isFree;
  final ValueChanged<bool?> onIsFreeChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: [
          _FilterDropdownPill<int>(
            label: 'Mesafe',
            value: radiusMeters,
            options: radiusOptions,
            onChanged: onRadiusChanged,
          ),
          const SizedBox(width: 8),
          _FilterDropdownPill<GenderPreference?>(
            label: 'Kimler',
            value: gender,
            options: genderOptions,
            onChanged: onGenderChanged,
          ),
          const SizedBox(width: 8),
          _FilterDropdownPill<bool?>(
            label: 'Ücret',
            value: isFree,
            options: priceOptions,
            onChanged: onIsFreeChanged,
          ),
        ],
      ),
    );
  }
}

class _FilterDropdownPill<T> extends StatelessWidget {
  const _FilterDropdownPill({required this.label, required this.value, required this.options, required this.onChanged});

  final String label;
  final T value;
  final List<({String label, T value})> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = options.where((o) => o.value == value).firstOrNull ?? options.first;
    return PopupMenuButton<T>(
      onSelected: onChanged,
      itemBuilder: (context) => [
        for (final o in options) PopupMenuItem(value: o.value, child: Text(o.label)),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$label ${selected.label}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more, size: 16, color: AppColors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
