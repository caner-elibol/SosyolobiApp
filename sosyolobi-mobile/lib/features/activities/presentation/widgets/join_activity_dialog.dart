import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

Future<bool> showJoinActivityDialog(
  BuildContext context, {
  required String title,
  required String categoryName,
  required Color categoryColor,
  required IconData categoryIcon,
  required String dateLabel,
  required String addressText,
  required String priceLabel,
  required String spotsLabel,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => _JoinActivityDialog(
      title: title,
      categoryName: categoryName,
      categoryColor: categoryColor,
      categoryIcon: categoryIcon,
      dateLabel: dateLabel,
      addressText: addressText,
      priceLabel: priceLabel,
      spotsLabel: spotsLabel,
    ),
  );
  return confirmed ?? false;
}

class _JoinActivityDialog extends StatelessWidget {
  const _JoinActivityDialog({
    required this.title,
    required this.categoryName,
    required this.categoryColor,
    required this.categoryIcon,
    required this.dateLabel,
    required this.addressText,
    required this.priceLabel,
    required this.spotsLabel,
  });

  final String title;
  final String categoryName;
  final Color categoryColor;
  final IconData categoryIcon;
  final String dateLabel;
  final String addressText;
  final String priceLabel;
  final String spotsLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Etkinliğe katılmak istiyor musunuz?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Onayladığınızda etkinlik sahibine bir katılım isteği gönderilir.',
            style: TextStyle(fontSize: 13, color: AppColors.mutedForeground),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(categoryIcon, size: 16, color: categoryColor),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            categoryName,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: categoryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _SummaryRow(icon: Icons.calendar_today, label: dateLabel),
                const SizedBox(height: 6),
                _SummaryRow(icon: Icons.place_outlined, label: addressText),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, size: 13, color: AppColors.mutedForeground),
                    const SizedBox(width: 6),
                    Text(priceLabel, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
                    const SizedBox(width: 12),
                    const Icon(Icons.people_outline, size: 13, color: AppColors.mutedForeground),
                    const SizedBox(width: 6),
                    Text(spotsLabel, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Vazgeç'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Onaylıyorum'),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 13, color: AppColors.mutedForeground),
        const SizedBox(width: 6),
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
        ),
      ],
    );
  }
}
