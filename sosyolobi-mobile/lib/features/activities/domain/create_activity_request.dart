import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';

part 'create_activity_request.freezed.dart';
part 'create_activity_request.g.dart';

@freezed
abstract class CreateActivityRequest with _$CreateActivityRequest {
  const factory CreateActivityRequest({
    required String categoryId,
    required String title,
    String? description,
    required DateTime eventDate,
    required int neededPeopleCount,
    double? pricePerPerson,
    @SkillLevelConverter() @Default(SkillLevel.any) SkillLevel skillLevel,
    @GenderPreferenceConverter() @Default(GenderPreference.any) GenderPreference genderPreference,
    required double latitude,
    required double longitude,
    required String addressText,
    String? addressDetailPrivate,
  }) = _CreateActivityRequest;

  factory CreateActivityRequest.fromJson(Map<String, dynamic> json) => _$CreateActivityRequestFromJson(json);
}
