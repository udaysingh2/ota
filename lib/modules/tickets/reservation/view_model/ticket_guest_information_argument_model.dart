import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class TicketGuestInformationViewModel {
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  OtaTextInputBloc? guestWeightBloc;
  OtaTextInputBloc? guestDobBloc;
  OtaTextInputBloc? guestPassportCountryBloc;
  OtaTextInputBloc? guestPassportIdBloc;
  OtaTextInputBloc? guestPassportIssuingCountryBloc;
  OtaTextInputBloc? guestPassportExpirationDateBloc;

  TicketGuestInformationData guestInformationArgumentData;

  TicketGuestInformationViewModel({
    required this.guestInformationArgumentData,
  });
}

class TicketGuestInformationArgumentModel {
  int guestIndex;
  bool? isGuestNameRequired;
  bool? isAllNameRequired;
  bool? isWeightRequired;
  bool? isDateOfBirthRequired;
  bool? isPassportIdRequired;
  bool? isPassportCountryRequired;
  bool? isPassportValidDateRequired;
  bool? isPassportCountryIssueRequired;
  TicketGuestInformationData? updateGuestInfo;

  TicketGuestInformationArgumentModel({
    required this.guestIndex,
    this.isGuestNameRequired,
    this.isAllNameRequired,
    this.isWeightRequired,
    this.isDateOfBirthRequired,
    this.isPassportIdRequired,
    this.isPassportCountryRequired,
    this.isPassportValidDateRequired,
    this.isPassportCountryIssueRequired,
    this.updateGuestInfo,
  });
}

class TicketGuestInformationData {
  String guestFirstName;
  String guestLastName;
  String? guestWeight;
  String? guestPassportId;
  DateTime? selectedDob;
  DateTime? selectedPassportValidityDate;
  String? selectedPassportCountry;
  String? selectedPassportIssuingCountry;
  String? guestMobileNumber;
  String? guestEmail;

  TicketGuestInformationData({
    required this.guestFirstName,
    required this.guestLastName,
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
