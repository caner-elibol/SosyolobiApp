library;

enum ActivityStatus {
  open(1),
  full(2),
  completed(3),
  cancelled(4);

  const ActivityStatus(this.value);
  final int value;

  static ActivityStatus fromJson(int value) => ActivityStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => ActivityStatus.open,
      );
  int toJson() => value;
}

enum ActivityRequestStatus {
  pending(1),
  approved(2),
  rejected(3),
  cancelled(4);

  const ActivityRequestStatus(this.value);
  final int value;

  static ActivityRequestStatus fromJson(int value) => ActivityRequestStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => ActivityRequestStatus.pending,
      );
  int toJson() => value;
}

enum SkillLevel {
  any(0),
  beginner(1),
  intermediate(2),
  advanced(3);

  const SkillLevel(this.value);
  final int value;

  static SkillLevel fromJson(int value) => SkillLevel.values.firstWhere(
        (e) => e.value == value,
        orElse: () => SkillLevel.any,
      );
  int toJson() => value;
}

enum GenderPreference {
  any(0),
  male(1),
  female(2),
  mixed(3);

  const GenderPreference(this.value);
  final int value;

  static GenderPreference fromJson(int value) => GenderPreference.values.firstWhere(
        (e) => e.value == value,
        orElse: () => GenderPreference.any,
      );
  int toJson() => value;
}

enum ChatRoomStatus {
  open(1),
  closed(2);

  const ChatRoomStatus(this.value);
  final int value;

  static ChatRoomStatus fromJson(int value) => ChatRoomStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => ChatRoomStatus.open,
      );
  int toJson() => value;
}

enum NotificationType {
  activityRequest(1),
  requestApproved(2),
  requestRejected(3),
  activityCancelled(4),
  activityCompleted(5),
  newReview(6),
  newReport(7);

  const NotificationType(this.value);
  final int value;

  static NotificationType fromJson(int value) => NotificationType.values.firstWhere(
        (e) => e.value == value,
        orElse: () => NotificationType.activityRequest,
      );
  int toJson() => value;
}

enum FriendRequestStatus {
  pending(1),
  accepted(2),
  rejected(3),
  cancelled(4);

  const FriendRequestStatus(this.value);
  final int value;

  static FriendRequestStatus fromJson(int value) => FriendRequestStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => FriendRequestStatus.pending,
      );
  int toJson() => value;
}

enum ReportStatus {
  pending(1),
  reviewing(2),
  resolved(3),
  dismissed(4);

  const ReportStatus(this.value);
  final int value;

  static ReportStatus fromJson(int value) => ReportStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => ReportStatus.pending,
      );
  int toJson() => value;
}

enum UserStatus {
  active(1),
  suspended(2),
  deleted(3),
  banned(4);

  const UserStatus(this.value);
  final int value;

  static UserStatus fromJson(int value) => UserStatus.values.firstWhere(
        (e) => e.value == value,
        orElse: () => UserStatus.active,
      );
  int toJson() => value;
}
