part of 'admin_bloc.dart';

class AdminState extends Equatable {
   AdminState({
    this.message,
    this.country,
  });
  final String? message;
  final Country? country;
   Country selectedCountry = Country(
    phoneCode: "+91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  AdminState copyWith({
    String? message,
    Country? country
  }) {
    return AdminState(
      message: message ?? this.message,
      country: country ?? this.country,
    );
  }
  @override
  List<Object> get props => [message ?? '', country??selectedCountry,];
}

class AdminInitial extends AdminState {}

class AdminLoadingState extends AdminState {}
class AdminLoginSuccessState extends AdminState {}

class AdminErrorState extends AdminState {
  final String errorMessage;
   AdminErrorState({
    required this.errorMessage,
  });
  @override
  List<Object> get props => [
        errorMessage,
      ];
}
