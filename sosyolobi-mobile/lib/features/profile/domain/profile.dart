import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String userId,
    required String displayName,
    String? bio,
    String? avatarUrl,
    DateTime? birthDate,
    required double averageRating,
    required int reviewCount,
    required int completedActivityCount,
    required bool isPhoneVerified,
    required DateTime createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
abstract class PublicProfile with _$PublicProfile {
  const factory PublicProfile({
    required String userId,
    required String displayName,
    String? bio,
    String? avatarUrl,
    required double averageRating,
    required int reviewCount,
    required int completedActivityCount,
  }) = _PublicProfile;

  factory PublicProfile.fromJson(Map<String, dynamic> json) => _$PublicProfileFromJson(json);
}
