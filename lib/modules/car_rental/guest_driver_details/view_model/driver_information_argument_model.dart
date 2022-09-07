import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class DriverInformationArgumentModel {
  SubmitDriverDetailsState submitDriverDetailsState;
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  OtaTextInputBloc? mobileNumberBloc;
  OtaTextInputBloc? flightNumberBloc;
  bool isMaterialBannerShown;
  DriverInformationArgumentData initialContactInformationArgumentData;
  Function(DriverInformationArgumentData updatedContactInformationArgumentData)
      onOkClicked;
  DriverInformationArgumentModel(
      {required this.initialContactInformationArgumentData,
      required this.onOkClicked,
      this.submitDriverDetailsState = SubmitDriverDetailsState.initial,
      this.isMaterialBannerShown = false});
}

class DriverInformationArgumentData {
  String firstName;
  String? lastName;
  int? age;
  String? phoneNumber;
  String? flightNumber;
  String? minAge;
  String? maxAge;
  DriverInformationArgumentData({
    required this.firstName,
    this.lastName,
    this.age,
    this.phoneNumber,
    this.flightNumber,
    this.minAge,
    this.maxAge,
  });
}

enum SubmitDriverDetailsState {
  initial,
  loading,
  success,
  failure,
}

enum DriverValidations { firstName, lastName, mobileNumber }
