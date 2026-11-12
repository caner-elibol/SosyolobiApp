import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_notifier.dart';
import '../router/route_paths.dart';

class UserLink extends ConsumerWidget {
  const UserLink({required this.userId, required this.child, super.key});

  final String userId;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(authProvider).value?.userId;
    final isSelf = currentUserId != null && currentUserId == userId;

    return InkWell(
      onTap: () => context.push(isSelf ? RoutePaths.profile : RoutePaths.publicProfile(userId)),
      borderRadius: BorderRadius.circular(8),
      child: child,
    );
  }
}
