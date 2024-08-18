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
        adminModel,imageFile??File(''),
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
  List<Object> get props => [selectedCountry,];
}

class EnableUserEvent extends AdminEvent {
  final String userId;
  const EnableUserEvent({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}
class DisableUserEvent extends AdminEvent {
  final String userId;
  const DisableUserEvent({
    required this.userId,
  });
  @override
  List<Object> get props => [userId];
}
