part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class AddAdminEvent extends AdminEvent {
  final AdminModel adminModel;
  final Uint8List? imageFile;
  const AddAdminEvent({
    required this.adminModel,
    this.imageFile,
  });
  @override
  List<Object> get props => [
        adminModel,
        imageFile ?? Uint8List(0),
      ];
}

class AdminSignInEvent extends AdminEvent {
  final String email;
  final String password;
  final BuildContext context;
  const AdminSignInEvent({
    required this.email,
    required this.password,
    required this.context,
  });
  @override
  List<Object> get props => [
        email,password,
        context,
      ];
}

class ImagePickEvent extends AdminEvent {}

class GetAllAdminsEvent extends AdminEvent {}

class GetCurrentAdminData extends AdminEvent {
  final String email;
  const GetCurrentAdminData({
    required this.email,
  });
  @override
  List<Object> get props => [
        email,
      ];
}

class CheckIfAdminSignedInEvent extends AdminEvent {
  @override
  List<Object> get props => [];
}
class UpdateAdminEvent extends AdminEvent {
  final AdminModel updatedAdminModel;
  final Uint8List? imageFile;
  const UpdateAdminEvent({
    required this.updatedAdminModel,
    this.imageFile,
  });
  @override
  List<Object> get props => [
        updatedAdminModel,
        imageFile ?? Uint8List(0),
      ];
}

class DeleteAdminEvent extends AdminEvent {
  final String adminId;
  const DeleteAdminEvent({
    required this.adminId,
  });
  @override
  List<Object> get props => [
        adminId,
      ];
}
