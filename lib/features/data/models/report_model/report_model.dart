import 'package:official_chatbox_admin_application/features/domain/entities/report_entity/report_entity.dart';

class ReportModel extends ReportEntity{
 const ReportModel({
    super.docId,
    super.reportedUserId,
  });
  // fromJson factory method
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      docId: json['docId'] as String?,
      reportedUserId: json['reportedUserId'] as String?,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'reportedUserId': reportedUserId,
    };
  }

  // copyWith method
  ReportModel copyWith({
    String? docId,
    String? reportedUserId,
  }) {
    return ReportModel(
      docId: docId ?? this.docId,
      reportedUserId: reportedUserId ?? this.reportedUserId,
    );
  }
}