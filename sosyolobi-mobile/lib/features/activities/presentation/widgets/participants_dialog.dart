import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/user_avatar.dart';
import '../../../profile/domain/profile.dart';
import '../../../users/presentation/widgets/participant_actions_menu.dart';

Future<void> showParticipantsDialog(
  BuildContext context, {
  required List<PublicProfile> participants,
  String? currentUserId,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _ParticipantsDialog(
      participants: participants,
      currentUserId: currentUserId,
    ),
  );
}

class _ParticipantsDialog extends StatelessWidget {
  const _ParticipantsDialog({required this.participants, this.currentUserId});

  final List<PublicProfile> participants;
  final String? currentUserId;

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Katılımcılar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '${participants.length} kişi',
                    style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: participants.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final p = participants[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  UserAvatar(displayName: p.displayName, avatarUrl: p.avatarUrl, size: 32),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      p.displayName,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (currentUserId != null && currentUserId != p.userId)
                              ParticipantActionsMenu(
                                userId: p.userId,
                                displayName: p.displayName,
                                onBeforeNavigateToProfile: () =>
                                    Navigator.of(context).pop(),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
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
