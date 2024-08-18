import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final String? id;
  final String? adminName;
  final String? adminMobileNumber;
  final String? profilePhoto;
  final String? adminAccountCreatedAt;
  const AdminEntity({
    this.id,
    this.adminName,
    this.adminMobileNumber,
    this.profilePhoto,
    this.adminAccountCreatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      adminName,
      adminMobileNumber,
      profilePhoto,
      adminAccountCreatedAt,
    ];
  }
}
