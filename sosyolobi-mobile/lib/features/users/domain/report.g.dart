// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateReportRequest _$CreateReportRequestFromJson(Map<String, dynamic> json) =>
    _CreateReportRequest(
      reportedUserId: json['reportedUserId'] as String?,
      reportedActivityId: json['reportedActivityId'] as String?,
      reason: json['reason'] as String,
      details: json['details'] as String?,
    );

Map<String, dynamic> _$CreateReportRequestToJson(
  _CreateReportRequest instance,
) => <String, dynamic>{
  'reportedUserId': instance.reportedUserId,
  'reportedActivityId': instance.reportedActivityId,
  'reason': instance.reason,
  'details': instance.details,
};

_ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    _ReportResponse(
      id: json['id'] as String,
      reporterUserId: json['reporterUserId'] as String,
      reportedUserId: json['reportedUserId'] as String?,
      reportedActivityId: json['reportedActivityId'] as String?,
      reason: json['reason'] as String,
      details: json['details'] as String?,
      status: const ReportStatusConverter().fromJson(
        (json['status'] as num).toInt(),
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$ReportResponseToJson(_ReportResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reporterUserId': instance.reporterUserId,
      'reportedUserId': instance.reportedUserId,
      'reportedActivityId': instance.reportedActivityId,
      'reason': instance.reason,
      'details': instance.details,
      'status': const ReportStatusConverter().toJson(instance.status),
      'createdAt': instance.createdAt.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };
