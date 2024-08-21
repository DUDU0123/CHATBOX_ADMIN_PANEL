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
  final String phoneNumber;
  final BuildContext context;
  const AdminSignInEvent({
    required this.phoneNumber,
    required this.context,
  });
  @override
  List<Object> get props => [
        phoneNumber,
        context,
      ];
}

class CountrySelectedEvent extends AdminEvent {
  final Country selectedCountry;
  const CountrySelectedEvent({
    required this.selectedCountry,
  });
  @override
  List<Object> get props => [
        selectedCountry,
      ];
}

class ImagePickEvent extends AdminEvent {}

class GetAllAdminsEvent extends AdminEvent {}

class GetCurrentAdminData extends AdminEvent {
  final String phoneNumber;
  const GetCurrentAdminData({
    required this.phoneNumber,
  });
  @override
  List<Object> get props => [
        phoneNumber,
      ];
}

class CheckIfAdminSignedInEvent extends AdminEvent {
  @override
  List<Object> get props => [];
}

class GetCurrentAdminNumberEvent extends AdminEvent {
  final String number;
  const GetCurrentAdminNumberEvent({
    required this.number,
  });
  @override
  List<Object> get props => [
        number,
      ];
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
