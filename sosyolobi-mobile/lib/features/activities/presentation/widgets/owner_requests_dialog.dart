import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/enums.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../requests/application/requests_providers.dart';
import '../../../requests/domain/activity_join_request.dart';

Future<void> showOwnerRequestsDialog(BuildContext context, {required String activityId}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _OwnerRequestsDialog(activityId: activityId),
  );
}

class _OwnerRequestsDialog extends ConsumerWidget {
  const _OwnerRequestsDialog({required this.activityId});

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(activityRequestsProvider(activityId));

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 380,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Katılım İstekleri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 14),
              Flexible(
                child: AsyncValueWidget<List<ActivityJoinRequest>>(
                  value: requestsAsync,
                  data: (requests) {
                    final pending = requests.where((r) => r.status == ActivityRequestStatus.pending).toList();
                    if (pending.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: EmptyStateWidget(
                          icon: Icons.inbox_outlined,
                          title: 'Bekleyen istek yok',
                          description: '',
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: pending.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _RequestRow(request: pending[index], activityId: activityId),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Kapat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestRow extends ConsumerWidget {
  const _RequestRow({required this.request, required this.activityId});

  final ActivityJoinRequest request;
  final String activityId;

  Future<void> _approve(WidgetRef ref, BuildContext context) async {
    await ref.read(requestActionsControllerProvider.notifier).approve(request.id, activityId: activityId);
    if (!context.mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ? 'Onaylanamadı.' : 'İstek onaylandı.')));
  }

  Future<void> _reject(WidgetRef ref, BuildContext context) async {
    await ref.read(requestActionsControllerProvider.notifier).reject(request.id, activityId: activityId);
    if (!context.mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ? 'Reddedilemedi.' : 'İstek reddedildi.')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: const Color(0xFFFFD580)),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(displayName: request.user.displayName, avatarUrl: request.user.avatarUrl, size: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.user.displayName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    if (request.user.averageRating > 0)
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 4),
                          Text(
                            '${request.user.averageRating.toStringAsFixed(1)} · ${request.user.completedActivityCount} etkinlik',
                            style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (request.message != null && request.message!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(AppRadius.sm)),
              child: Text('"${request.message}"', style: const TextStyle(fontSize: 13, color: Color(0xFF374151))),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: () => _reject(ref, context), child: const Text('Reddet')),
              const SizedBox(width: 8),
              ElevatedButton(onPressed: () => _approve(ref, context), child: const Text('Onayla')),
            ],
          ),
        ],
      ),
    );
  }
}
