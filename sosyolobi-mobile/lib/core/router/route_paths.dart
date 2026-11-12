abstract final class RoutePaths {
  static const splash = '/splash';

  static const login = '/auth/login';
  static const verify = '/auth/verify';

  static const locationGate = '/onboarding/location';

  static const map = '/app/map';
  static const activities = '/app/activities';
  static const activityCreate = '/app/activities/create';
  static String activityDetail(String id) => '/app/activities/$id';
  static const activityDetailPattern = '/app/activities/:id';

  static const profile = '/app/profile';
  static String publicProfile(String userId) => '/app/profile/$userId';
  static const publicProfilePattern = '/app/profile/:userId';

  static const friends = '/app/friends';
  static const myReports = '/app/reports';
}
