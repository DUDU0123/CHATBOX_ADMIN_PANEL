import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/features/domain/entities/admin_entity/admin_entity.dart';

class AdminModel extends AdminEntity {
  const AdminModel({
    super.id,
    super.adminMobileNumber,
    super.adminName,
    super.profilePhoto,
    super.adminAccountCreatedAt,
  });

  factory AdminModel.fromJson({
    required Map<String, dynamic> map,
  }) {
    return AdminModel(
      id: map[adminId],
      adminMobileNumber: map[adminPhoneNumber],
      adminName: map[adminName],
      profilePhoto: map[adminProfilePhoto],
      adminAccountCreatedAt: map[adminJoinedDate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      adminId: id,
      adminPhoneNumber: adminMobileNumber,
      adminName: adminName,
      adminProfilePhoto: profilePhoto,
      adminJoinedDate: adminAccountCreatedAt,
    };
  }

  AdminModel copyWith({
    String? id,
    String? adminMobileNumber,
    String? adminName,
    String? profilePhoto,
    String? adminAccountCreatedAt,
  }) {
    return AdminModel(
      id: id ?? this.id,
      adminMobileNumber: adminMobileNumber ?? this.adminMobileNumber,
      adminName: adminName ?? this.adminName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      adminAccountCreatedAt:
          adminAccountCreatedAt ?? this.adminAccountCreatedAt,
    );
  }
}
