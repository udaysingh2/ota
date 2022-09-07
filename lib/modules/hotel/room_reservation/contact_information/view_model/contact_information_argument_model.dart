import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class ContactInformationArgumentModel {
  SubmitCustomerDetailsState submitCustomerDetailsState;
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  bool isMaterialBannerShown;
  ContactInformationArgumentData initialContactInformationArgumentData;
  Function(ContactInformationArgumentData updatedContactInformationArgumentData)
      onOkClicked;
  ContactInformationArgumentModel(
      {required this.initialContactInformationArgumentData,
      required this.onOkClicked,
      this.submitCustomerDetailsState = SubmitCustomerDetailsState.initial,
      this.isMaterialBannerShown = false});
}

class ContactInformationArgumentData {
  String firstName;
  String? lastName;
  String email;
  String phoneNumber;
  bool contactInformationSelected;
  ContactInformationArgumentData(
      {required this.firstName,
      this.lastName,
      required this.email,
      required this.phoneNumber,
      this.contactInformationSelected = false,
      starRating});
}

enum SubmitCustomerDetailsState {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}
