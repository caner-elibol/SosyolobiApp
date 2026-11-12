import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/users_actions_provider.dart';
import '../domain/report.dart';

const _statusLabels = {
  ReportStatus.pending: ('İnceleniyor', Color(0xFFB45309)),
  ReportStatus.reviewing: ('İnceleniyor', Color(0xFFB45309)),
  ReportStatus.resolved: ('Çözüldü', Color(0xFF15803D)),
  ReportStatus.dismissed: ('Reddedildi', Color(0xFF6B7280)),
};

class MyReportsScreen extends ConsumerWidget {
  const MyReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(myReportsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Raporlarım')),
      body: AsyncValueWidget<List<ReportResponse>>(
        value: reportsAsync,
        data: (reports) {
          if (reports.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.flag_outlined,
              title: 'Henüz rapor göndermediniz',
              description: 'Gönderdiğiniz şikayetler ve durumları burada görünecek.',
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(myReportsProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final report = reports[index];
                final (label, color) = _statusLabels[report.status]!;
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(AppRadius.lg)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(report.reason, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppRadius.full)),
                            child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                          ),
                        ],
                      ),
                      if (report.details != null && report.details!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(report.details!, style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground)),
                      ],
                      const SizedBox(height: 6),
                      Text(
                        report.reportedUserId != null ? 'Kullanıcı raporu · ${Formatters.shortDate(report.createdAt)}' : 'Etkinlik raporu · ${Formatters.shortDate(report.createdAt)}',
                        style: const TextStyle(fontSize: 11, color: AppColors.subtleForeground),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
