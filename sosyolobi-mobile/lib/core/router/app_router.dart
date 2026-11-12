import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/activities/presentation/activities_list_screen.dart';
import '../../features/activities/presentation/activity_detail_screen.dart';
import '../../features/activities/presentation/create_activity_wizard.dart';
import '../../features/auth/application/auth_notifier.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/verify_screen.dart';
import '../../features/friends/presentation/friends_screen.dart';
import '../../features/map/application/current_location_provider.dart';
import '../../features/map/domain/current_location.dart';
import '../../features/map/presentation/location_gate_screen.dart';
import '../../features/map/presentation/map_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/public_profile_screen.dart';
import '../../features/users/presentation/my_reports_screen.dart';
import '../widgets/app_shell.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref) {
    ref.listen(authProvider, (previous, next) {
      if (previous?.value?.isAuthenticated != next.value?.isAuthenticated) {
        notifyListeners();
      }
    });
    ref.listen(currentLocationProvider, (previous, next) {
      if (previous?.value?.permissionState != next.value?.permissionState) {
        notifyListeners();
      }
    });
  }
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refreshListenable = _AuthRefreshListenable(ref);

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      if (!authState.hasValue) {
        return state.matchedLocation == RoutePaths.splash
            ? null
            : RoutePaths.splash;
      }

      final loggedIn = authState.value?.isAuthenticated ?? false;
      final onAuthRoute = state.matchedLocation.startsWith('/auth');
      final onSplash = state.matchedLocation == RoutePaths.splash;
      final onLocationGate = state.matchedLocation == RoutePaths.locationGate;

      if (!loggedIn && (!onAuthRoute || onSplash)) return RoutePaths.login;

      if (loggedIn) {
        final locationGranted =
            ref
                .read(currentLocationProvider)
                .value
                ?.permissionState ==
            LocationPermissionState.granted;
        if (!locationGranted)
          return onLocationGate ? null : RoutePaths.locationGate;
        if (onAuthRoute || onSplash || onLocationGate) return RoutePaths.map;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.verify,
        builder: (context, state) =>
            VerifyScreen(phoneNumber: state.extra as String? ?? ''),
      ),
      GoRoute(
        path: RoutePaths.locationGate,
        builder: (context, state) => const LocationGateScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(
            path: RoutePaths.map,
            builder: (context, state) => const MapScreen(),
          ),
          GoRoute(
            path: RoutePaths.activities,
            builder: (context, state) => const ActivitiesListScreen(),
          ),
          GoRoute(
            path: RoutePaths.activityCreate,
            builder: (context, state) => const CreateActivityWizard(),
          ),
          GoRoute(
            path: RoutePaths.activityDetailPattern,
            builder: (context, state) =>
                ActivityDetailScreen(activityId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: RoutePaths.publicProfilePattern,
            builder: (context, state) =>
                PublicProfileScreen(userId: state.pathParameters['userId']!),
          ),
          GoRoute(
            path: RoutePaths.friends,
            builder: (context, state) => const FriendsScreen(),
          ),
          GoRoute(
            path: RoutePaths.myReports,
            builder: (context, state) => const MyReportsScreen(),
          ),
        ],
      ),
    ],
  );
}
