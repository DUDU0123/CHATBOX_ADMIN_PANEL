import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final String? id;
  final String? adminName;
  final String? adminPassword;
  final String? adminEmailAddress;
  final String? profilePhoto;
  final String? adminAccountCreatedAt;
  const AdminEntity({
    this.id,
    this.adminName,
    this.adminPassword,
    this.adminEmailAddress,
    this.profilePhoto,
    this.adminAccountCreatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      adminName,
      adminPassword,
      adminEmailAddress,
      profilePhoto,
      adminAccountCreatedAt,
    ];
  }
}
