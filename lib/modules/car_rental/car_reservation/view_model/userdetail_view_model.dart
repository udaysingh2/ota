import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';

class CarUserDetailViewModel {
  String firstName;
  String secondName;
  String mobileNumber;
  String email;
  String driverFirstName;
  String? driverLastName;
  String driverPhoneNumber;
  int driverAge;
  int age;
  String flightNumber;
  OtaRadioButtonState? buttonState;
  CarUserDetailViewModelDataState userDetailViewModelDataState;
  CarUserDetailViewModel({
    this.firstName = "",
    this.secondName = "",
    this.mobileNumber = "",
    this.email = "",
    this.userDetailViewModelDataState = CarUserDetailViewModelDataState.initial,
    this.buttonState,
    this.driverFirstName = '',
    this.driverLastName,
    this.driverPhoneNumber = '',
    this.driverAge = 0,
    this.age = 0,
    this.flightNumber = '',
  });
}

enum CarUserDetailViewModelDataState {
  initial,
  loading,
  loaded,
  failed,
}
