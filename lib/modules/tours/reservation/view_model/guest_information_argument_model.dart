import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class GuestInformationViewModel {
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  OtaTextInputBloc? guestWeightBloc;
  OtaTextInputBloc? guestDobBloc;
  OtaTextInputBloc? guestPassportCountryBloc;
  OtaTextInputBloc? guestPassportIdBloc;
  OtaTextInputBloc? guestPassportIssuingCountryBloc;
  OtaTextInputBloc? guestPassportExpirationDateBloc;

  GuestInformationData guestInformationArgumentData;

  GuestInformationViewModel({
    required this.guestInformationArgumentData,
  });
}

class GuestInformationArgumentModel {
  int guestIndex;
  bool isForAdult;
  bool? isGuestNameRequired;
  bool? isAllnameRequired;
  bool? isWeightRequired;
  bool? isDateofBirthRequired;
  bool? isPassportIdRequired;
  bool? isPassportCountryRequired;
  bool? isPassportValidDateRequired;
  bool? isPassportCountryIssueRequired;
  GuestInformationData? updateGuestInfo;

  GuestInformationArgumentModel({
    required this.guestIndex,
    required this.isForAdult,
    this.isGuestNameRequired,
    this.isAllnameRequired,
    this.isWeightRequired,
    this.isDateofBirthRequired,
    this.isPassportIdRequired,
    this.isPassportCountryRequired,
    this.isPassportValidDateRequired,
    this.isPassportCountryIssueRequired,
    this.updateGuestInfo,
  });
}

class GuestInformationData {
  String guestFirstName;
  String guestLastName;
  String? paxId;
  String? guestWeight;
  String? guestPassportId;
  DateTime? selectedDob;
  DateTime? selectedPassportValidityDate;
  String? selectedPassportCountry;
  String? selectedPassportIssuingCountry;
  String? guestMobileNumber;
  String? guestEmail;

  GuestInformationData({
    required this.guestFirstName,
    required this.guestLastName,
    this.paxId,
    this.guestWeight,
    this.guestPassportId,
    this.selectedDob,
    this.selectedPassportValidityDate,
    this.selectedPassportCountry,
    this.selectedPassportIssuingCountry,
    this.guestMobileNumber,
    this.guestEmail,
  });
}
