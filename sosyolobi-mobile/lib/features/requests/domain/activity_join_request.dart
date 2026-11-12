import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/enum_converters.dart';
import '../../../core/domain/enums.dart';
import '../../profile/domain/profile.dart';

part 'activity_join_request.freezed.dart';
part 'activity_join_request.g.dart';

@freezed
abstract class ActivityJoinRequest with _$ActivityJoinRequest {
  const factory ActivityJoinRequest({
    required String id,
    required String activityId,
    required PublicProfile user,
    String? message,
    @ActivityRequestStatusConverter() required ActivityRequestStatus status,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _ActivityJoinRequest;

  factory ActivityJoinRequest.fromJson(Map<String, dynamic> json) => _$ActivityJoinRequestFromJson(json);
}
