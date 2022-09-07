import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_controller.dart';

void main() {
  TextEditingController firstNameController =
      TextEditingController(text: "unit");
  TextEditingController lastNameController =
      TextEditingController(text: "test");
  TextEditingController mobileNumberController =
      TextEditingController(text: "0987654321");
  OtaRadioButtonBloc radioButtonBloc = OtaRadioButtonBloc();
  test("Package Guest User Detail Controller Test correct validation", () {
    PackageGuestUserDetailController controller =
        PackageGuestUserDetailController();
    controller.initializeFunction(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      mobileNumberController: mobileNumberController,
    );
    radioButtonBloc.state.otaRadioButtonState = OtaRadioButtonState.selected;
    radioButtonBloc.emit(radioButtonBloc.state);
    controller.state.otaRadioButtonBloc = radioButtonBloc;
    bool validation = controller.isValidationSuccess();
    expect(validation, true);
  });
  test("Package Guest User Detail Controller Test incorrect validation", () {
    PackageGuestUserDetailController controller =
        PackageGuestUserDetailController();
    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    controller.initializeFunction(
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      mobileNumberController: mobileNumberController,
    );
    radioButtonBloc.state.otaRadioButtonState = OtaRadioButtonState.selected;
    radioButtonBloc.emit(radioButtonBloc.state);
    controller.state.otaRadioButtonBloc = radioButtonBloc;
    bool validation = controller.isValidationSuccess();
    expect(validation, false);
  });
}
