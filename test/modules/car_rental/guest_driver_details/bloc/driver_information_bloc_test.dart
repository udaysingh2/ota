import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/modules/car_rental/guest_driver_details/bloc/driver_infromation_bloc.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view_model/driver_information_argument_model.dart';

void main() {
  DriverInformationBloc driverInformationBloc = DriverInformationBloc();
  group("Driver Information Bloc Test", () {
    test("Initial State", () {
      expect(driverInformationBloc.state.submitDriverDetailsState,
          SubmitDriverDetailsState.initial);
    });

    test("Show Material Banner State", () {
      driverInformationBloc.showMaterialBanner(true);
      expect(driverInformationBloc.state.isMaterialBannerShown, true);
    });

    test("Map from Argument method Test", () {
      driverInformationBloc.mapFromArgument(DriverInformationArgumentModel(
          initialContactInformationArgumentData:
              DriverInformationArgumentData(firstName: 'Test'),
          onOkClicked: (DriverInformationArgumentData
              updatedContactInformationArgumentData) {}));
      expect(
          driverInformationBloc
              .state.initialContactInformationArgumentData.firstName,
          "Test");
    });

    test("Check Validation method Test", () {
      driverInformationBloc.mapFromArgument(DriverInformationArgumentModel(
          initialContactInformationArgumentData:
              DriverInformationArgumentData(firstName: 'Test'),
          onOkClicked: (DriverInformationArgumentData
              updatedContactInformationArgumentData) {}));
      driverInformationBloc.checkValidation(DriverValidations.firstName);
      driverInformationBloc.checkValidation(DriverValidations.lastName);
      driverInformationBloc.checkValidation(DriverValidations.mobileNumber);
      expect(driverInformationBloc.state.firstNameBloc?.state.otaTextInputState,
          OtaTextInputState.valid);
      expect(driverInformationBloc.state.lastNameBloc?.state.otaTextInputState,
          OtaTextInputState.error);
      expect(
          driverInformationBloc.state.mobileNumberBloc?.state.otaTextInputState,
          OtaTextInputState.error);
      expect(driverInformationBloc.isFormValid, false);
    });

    test("Change Driver Age", () {
      driverInformationBloc.updateDriverAge(age: 36);
      expect(
          driverInformationBloc.state.initialContactInformationArgumentData.age,
          36);
    });

    test("onOkClicked Driver Information", () {
      driverInformationBloc.onOkClicked();
    });
  });
}
