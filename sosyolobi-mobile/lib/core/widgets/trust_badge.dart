import 'package:flutter/material.dart';

import '../theme/colors.dart';

class TrustBadge extends StatelessWidget {
  const TrustBadge({this.isPhoneVerified = false, this.rating, this.compact = false, super.key});

  final bool isPhoneVerified;
  final double? rating;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final fontSize = compact ? 11.0 : 12.0;
    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (isPhoneVerified)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppColors.successBg, borderRadius: BorderRadius.circular(AppRadius.full)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: compact ? 12 : 13, color: AppColors.success),
                if (!compact) ...[
                  const SizedBox(width: 3),
                  Text('Doğrulandı', style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: AppColors.success)),
                ],
              ],
            ),
          ),
        if (rating != null && rating! > 0)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: compact ? 12 : 13, color: const Color(0xFFF59E0B)),
              const SizedBox(width: 3),
              Text(rating!.toStringAsFixed(1), style: TextStyle(fontSize: compact ? 12 : 13, color: AppColors.mutedForeground)),
            ],
          ),
      ],
    );
  }
}
