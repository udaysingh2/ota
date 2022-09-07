import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';

class UserDetailViewModel {
  String firstName;
  String secondName;
  String mobileNumber;
  String email;
  OtaRadioButtonState? buttonState;
  UserDetailViewModelDataState userDetailViewModelDataState;
  UserDetailViewModel({
    this.firstName = "",
    this.secondName = "",
    this.mobileNumber = "",
    this.email = "",
    this.userDetailViewModelDataState = UserDetailViewModelDataState.initial,
    this.buttonState,
  });
}

enum UserDetailViewModelDataState {
  initial,
  loading,
  loaded,
  failed,
  internetFailure,
}
