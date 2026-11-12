import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';
import '../../profile/domain/profile.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
abstract class Activity with _$Activity {
  const factory Activity({
    required String id,
    required String createdByUserId,
    required String createdByDisplayName,
    String? createdByAvatarUrl,
    required String categoryId,
    required String categoryName,
    String? categoryImageUrl,
    required String title,
    String? description,
    required DateTime eventDate,
    required int neededPeopleCount,
    required int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() required SkillLevel skillLevel,
    @GenderPreferenceConverter() required GenderPreference genderPreference,
    @ActivityStatusConverter() required ActivityStatus status,
    required double latitude,
    required double longitude,
    required String addressText,
    double? distanceMeters,
    required DateTime createdAt,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

@freezed
abstract class ActivityDetail with _$ActivityDetail {
  const factory ActivityDetail({
    required String id,
    required String createdByUserId,
    required String createdByDisplayName,
    String? createdByAvatarUrl,
    required String categoryId,
    required String categoryName,
    String? categoryImageUrl,
    required String title,
    String? description,
    required DateTime eventDate,
    required int neededPeopleCount,
    required int currentPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() required SkillLevel skillLevel,
    @GenderPreferenceConverter() required GenderPreference genderPreference,
    @ActivityStatusConverter() required ActivityStatus status,
    required double latitude,
    required double longitude,
    required String addressText,
    double? distanceMeters,
    required DateTime createdAt,
    String? addressDetailPrivate,
    required List<PublicProfile> participants,
    @ActivityRequestStatusConverter() ActivityRequestStatus? myRequestStatus,
  }) = _ActivityDetail;

  factory ActivityDetail.fromJson(Map<String, dynamic> json) =>
      _$ActivityDetailFromJson(json);
}

extension ActivityDetailSummary on ActivityDetail {
  Activity toActivity() => Activity(
    id: id,
    createdByUserId: createdByUserId,
    createdByDisplayName: createdByDisplayName,
    createdByAvatarUrl: createdByAvatarUrl,
    categoryId: categoryId,
    categoryName: categoryName,
    categoryImageUrl: categoryImageUrl,
    title: title,
    description: description,
    eventDate: eventDate,
    neededPeopleCount: neededPeopleCount,
    currentPeopleCount: currentPeopleCount,
    pricePerPerson: pricePerPerson,
    skillLevel: skillLevel,
    genderPreference: genderPreference,
    status: status,
    latitude: latitude,
    longitude: longitude,
    addressText: addressText,
    distanceMeters: distanceMeters,
    createdAt: createdAt,
  );
}

@freezed
abstract class ActivityMapItem with _$ActivityMapItem {
  const factory ActivityMapItem({
    required String id,
    required String title,
    required String categoryName,
    String? categoryImageUrl,
    @ActivityStatusConverter() required ActivityStatus status,
    required double latitude,
    required double longitude,
    required DateTime eventDate,
    required int neededPeopleCount,
    double? pricePerPerson,
    required double distanceMeters,
  }) = _ActivityMapItem;

  factory ActivityMapItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityMapItemFromJson(json);
}
