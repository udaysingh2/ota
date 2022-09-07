import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';

class OtaContactInformationArgumentModel {
  OtaSubmitCustomerDetailsState submitCustomerDetailsState;
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  bool isMaterialBannerShown;
  OtaContactInformationArgumentData initialContactInformationArgumentData;
  String? fromScreen;
  Function(
      OtaContactInformationArgumentData
          updatedContactInformationArgumentData) onOkClicked;
  OtaContactInformationArgumentModel(
      {required this.initialContactInformationArgumentData,
      this.fromScreen,
      required this.onOkClicked,
      this.submitCustomerDetailsState = OtaSubmitCustomerDetailsState.initial,
      this.isMaterialBannerShown = false});
}

class OtaContactInformationArgumentData {
  String firstName;
  String? lastName;
  String email;
  String phoneNumber;
  bool contactInformationSelected;
  OtaContactInformationArgumentData(
      {required this.firstName,
      this.lastName,
      required this.email,
      required this.phoneNumber,
      this.contactInformationSelected = false,
      starRating});

  OtaUpdateCustomerDetailsArgumentDomain
      toUpdateCustomerDetailsDomainArgument() {
    return OtaUpdateCustomerDetailsArgumentDomain(
      firstName: firstName,
      lastName: lastName!,
    );
  }
}

enum OtaSubmitCustomerDetailsState {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}
