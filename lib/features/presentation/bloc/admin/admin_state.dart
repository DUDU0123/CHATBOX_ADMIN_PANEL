part of 'admin_bloc.dart';

class AdminState extends Equatable {
  AdminState({
    this.message,
    this.country,
    this.pickedFile,
    this.adminsList,
    this.currentAdminData,
    this.isAdminSignedIn = false,
    this.adminNumber,
  });
  final String? message;
  final Country? country;
  final Uint8List? pickedFile;
  final Stream<List<AdminModel>>? adminsList;
  final AdminModel? currentAdminData;
  final bool? isAdminSignedIn;
  final String? adminNumber;
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
    Country? country,
    Uint8List? pickedFile,
    String? adminNumber,
    Stream<List<AdminModel>>? adminsList,
    AdminModel? currentAdminData,
    bool? isAdminSignedIn,
  }) {
    return AdminState(
      message: message ?? this.message,
      country: country ?? this.country,
      pickedFile: pickedFile ?? this.pickedFile,
      adminsList: adminsList ?? this.adminsList,
      currentAdminData: currentAdminData ?? this.currentAdminData,
      isAdminSignedIn: isAdminSignedIn ?? this.isAdminSignedIn,
      adminNumber: adminNumber?? this.adminNumber,
    );
  }

  @override
  List<Object> get props => [
        message ?? '',
        country ?? selectedCountry,
        pickedFile ?? Uint8List(0),
        adminsList ?? [],
        currentAdminData ?? const AdminModel(),
        isAdminSignedIn ?? false,
        adminNumber??'',
      ];
}

class AdminInitial extends AdminState {}

class AdminLoadingState extends AdminState {}

class AdminLoginSuccessState extends AdminState {
  final AdminModel? adminData;
  AdminLoginSuccessState({
    this.adminData,
  });
  @override
  List<Object> get props => [
        adminData ?? const AdminModel(),
      ];
}

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
