import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class LocationPermissionCard extends StatelessWidget {
  const LocationPermissionCard({required this.onAllow, this.onDismiss, super.key});

  final VoidCallback onAllow;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(color: AppColors.accentSoftBg, shape: BoxShape.circle),
            child: const Icon(Icons.place, color: AppColors.accentSoftFg, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Konumuna İzin Ver', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text(
                  'Yakındaki etkinlikleri görmek için konumuna ihtiyaç var.',
                  style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      onPressed: onAllow,
                      child: const Text('Konumu Paylaş', style: TextStyle(fontSize: 13)),
                    ),
                    if (onDismiss != null) ...[
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: onDismiss,
                        child: const Text('Şimdi Değil', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
