import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/domain/contact_information/use_cases/update_customer_use_cases.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view_model/driver_information_argument_model.dart';

class DriverInformationBloc extends Bloc<DriverInformationArgumentModel> {
  UpdateCustomerUseCases contactUseCases = UpdateCustomerUseCasesImpl();

  @override
  DriverInformationArgumentModel initDefaultValue() {
    DriverInformationArgumentModel driverInformationArgumentModel =
        DriverInformationArgumentModel(
            initialContactInformationArgumentData:
                DriverInformationArgumentData(
                    firstName: '',
                    lastName: '',
                    age: 0,
                    phoneNumber: '',
                    flightNumber: ''),
            onOkClicked: (DriverInformationArgumentData
                updatedDriverInformationArgumentData) {});
    driverInformationArgumentModel.firstNameBloc = OtaTextInputBloc();
    driverInformationArgumentModel.lastNameBloc = OtaTextInputBloc();
    driverInformationArgumentModel.mobileNumberBloc = OtaTextInputBloc();
    driverInformationArgumentModel.flightNumberBloc = OtaTextInputBloc();
    return driverInformationArgumentModel;
  }

  void onOkClicked() {
    state.onOkClicked(DriverInformationArgumentData(
      age: state.initialContactInformationArgumentData.age,
      firstName: state.initialContactInformationArgumentData.firstName,
      lastName: state.initialContactInformationArgumentData.lastName,
      phoneNumber: state.initialContactInformationArgumentData.phoneNumber,
      flightNumber: state.initialContactInformationArgumentData.flightNumber,
    ));
  }

  void showMaterialBanner(bool showBanner) {
    state.isMaterialBannerShown = showBanner;
    emit(state);
  }

  bool get isFormValid {
    String firstName = state.initialContactInformationArgumentData.firstName;
    String lastName =
        state.initialContactInformationArgumentData.lastName ?? '';
    String mobileNumber =
        state.initialContactInformationArgumentData.phoneNumber ?? '';
    int? age = state.initialContactInformationArgumentData.age;
    if (firstName.isEmpty || kInvalidNameFormatter.hasMatch(firstName)) {
      return false;
    } else if (lastName.isEmpty || kInvalidNameFormatter.hasMatch(lastName)) {
      return false;
    } else if (mobileNumber.isEmpty ||
        mobileNumber.length != 10 ||
        !mobileNumber.startsWith('0') ||
        age == null ||
        age == 0) {
      return false;
    }

    return true;
  }

  void checkValidation(DriverValidations driverValidations) {
    String firstName = state.initialContactInformationArgumentData.firstName;
    String lastName =
        state.initialContactInformationArgumentData.lastName ?? '';
    String mobileNumber =
        state.initialContactInformationArgumentData.phoneNumber ?? '';

    switch (driverValidations) {
      case DriverValidations.firstName:
        if (firstName.isEmpty || kInvalidNameFormatter.hasMatch(firstName)) {
          state.firstNameBloc!.errorInputState();
        } else {
          state.firstNameBloc!.validInputState();
        }
        break;
      case DriverValidations.lastName:
        if (lastName.isEmpty || kInvalidNameFormatter.hasMatch(lastName)) {
          state.lastNameBloc!.errorInputState();
        } else {
          state.lastNameBloc!.validInputState();
        }
        break;
      case DriverValidations.mobileNumber:
        if (mobileNumber.isEmpty ||
            mobileNumber.length != 10 ||
            !mobileNumber.startsWith('0')) {
          state.mobileNumberBloc!.errorInputState();
        } else {
          state.mobileNumberBloc!.validInputState();
        }
        break;
    }
  }

  void updateTextState() {
    emit(state);
  }

  void mapFromArgument(
      DriverInformationArgumentModel driverInformationArgumentModel) {
    DriverInformationArgumentData? argData =
        driverInformationArgumentModel.initialContactInformationArgumentData;
    state.initialContactInformationArgumentData.firstName = argData.firstName;
    state.initialContactInformationArgumentData.lastName =
        argData.lastName ?? '';
    state.initialContactInformationArgumentData.age = argData.age;
    state.onOkClicked = driverInformationArgumentModel.onOkClicked;
    state.initialContactInformationArgumentData.phoneNumber =
        argData.phoneNumber;
    state.initialContactInformationArgumentData.flightNumber =
        argData.flightNumber;
    state.initialContactInformationArgumentData.minAge = argData.minAge;
    state.initialContactInformationArgumentData.maxAge = argData.maxAge;
    emit(state);
  }

  void updateDriverAge({required age}) {
    state.initialContactInformationArgumentData.age = age;
    emit(state);
  }

  ///TODO: Need to remove this after testing.
  // Future<void> submitApiCall(
  //     ContactInformationArgumentData contactInformationArgumentData) async {
  //   state.submitCustomerDetailsState = SubmitCustomerDetailsState.loading;
  //   emit(state);
  //   Either<Failure, UpdateCustomerData>? customerData = await contactUseCases
  //       .updateCustomerData(contactInformationArgumentData);
  //   if (customerData?.isRight ?? true) {
  //     if (customerData?.right.updateCustomerDetails?.status?.code ==
  //         _kSuccessCode) {
  //       state.submitCustomerDetailsState = SubmitCustomerDetailsState.success;
  //     } else {
  //       state.submitCustomerDetailsState = SubmitCustomerDetailsState.failure;
  //     }
  //     emit(state);
  //     return;
  //   } else {
  //     state.submitCustomerDetailsState = SubmitCustomerDetailsState.failure;
  //   }
  //   emit(state);
  // }
}
