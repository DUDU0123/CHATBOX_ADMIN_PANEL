import 'package:official_chatbox_admin_application/core/constants/database_constants.dart';
import 'package:official_chatbox_admin_application/features/domain/entities/admin_entity/admin_entity.dart';

class AdminModel extends AdminEntity {
  const AdminModel({
    super.id,
    super.adminEmailAddress,
    super.adminPassword,
    super.adminName,
    super.profilePhoto,
    super.adminAccountCreatedAt,
  });

  factory AdminModel.fromJson({
    required Map<String, dynamic> map,
  }) {
    return AdminModel(
      id: map[adminId],
      adminPassword: map[adminPasswordDB],
      adminEmailAddress: map[adminEmail],
      adminName: map[adminNameDB],
      profilePhoto: map[adminProfilePhoto],
      adminAccountCreatedAt: map[adminJoinedDate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      adminId: id,
      adminPasswordDB: adminPassword,
      adminEmail: adminEmailAddress,
      adminNameDB: adminName,
      adminProfilePhoto: profilePhoto,
      adminJoinedDate: adminAccountCreatedAt,
    };
  }

  AdminModel copyWith(
      {String? id,
      String? adminEmailAddress,
      String? adminName,
      String? profilePhoto,
      String? adminAccountCreatedAt,
      String? adminPassword}) {
    return AdminModel(
      id: id ?? this.id,
      adminEmailAddress: adminEmailAddress ?? this.adminEmailAddress,
      adminPassword: adminPassword ?? this.adminPassword,
      adminName: adminName ?? this.adminName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      adminAccountCreatedAt:
          adminAccountCreatedAt ?? this.adminAccountCreatedAt,
    );
  }
}
