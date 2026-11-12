import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class MapPreviewCard extends StatelessWidget {
  const MapPreviewCard({required this.onExpand, required this.activityCount, super.key});

  final VoidCallback onExpand;
  final int? activityCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onExpand,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.softNavy,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            const Positioned.fill(child: _MapGridPattern()),
            Center(
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(color: AppColors.accentBright, shape: BoxShape.circle),
                child: const Icon(Icons.place, color: Colors.white, size: 22),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Material(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(AppRadius.full),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.open_in_full, size: 13, color: Colors.white),
                      const SizedBox(width: 6),
                      const Text('Haritada Görüntüle', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
            if (activityCount != null)
              Positioned(
                left: 10,
                top: 10,
                child: Material(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text('$activityCount etkinlik', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.mutedForeground)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MapGridPattern extends StatelessWidget {
  const _MapGridPattern();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter());
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    const step = 24.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
