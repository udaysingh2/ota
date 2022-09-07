import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_guest_user_widget/package_guest_user_detail_model.dart';

class PackageGuestUserDetailController
    extends Bloc<PackageGuestUserDetailModel> {
  bool isReservingForSomeoneElse() {
    return state.otaRadioButtonBloc!.state.otaRadioButtonState ==
        OtaRadioButtonState.selected;
  }

  bool isValidationSuccess() {
    if (isReservingForSomeoneElse()) {
      _checkValidation();
      if (state.firstNameBloc!.state.otaTextInputState ==
              OtaTextInputState.valid &&
          state.lastNameBloc!.state.otaTextInputState ==
              OtaTextInputState.valid &&
          state.mobileNumberBloc!.state.otaTextInputState ==
              OtaTextInputState.valid) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  bool isPhoneValid() {
    String mobileNumber = state.mobileNumberController?.text ?? '';
    if (mobileNumber.trim().isEmpty ||
        mobileNumber.trim().length < 10 ||
        !(mobileNumber.trim().startsWith('0'))) {
      return false;
    } else {
      return true;
    }
  }

  bool isFirstNameValid() {
    String firstName = state.firstNameController?.text ?? "";
    return firstName.isNotEmpty && !kInvalidNameFormatter.hasMatch(firstName);
  }

  bool isLastNameValid() {
    String lastName = state.lastNameController?.text ?? "";
    return lastName.isNotEmpty && !kInvalidNameFormatter.hasMatch(lastName);
  }

  bool isValidationConfirmed() {
    if (isReservingForSomeoneElse()) {
      String firstName = state.firstNameController?.text ?? "";
      String lastName = state.lastNameController?.text ?? "";
      String mobileNumber = state.mobileNumberController?.text ?? "";
      bool isPhoneNumberValid = isPhoneValid();
      return firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          mobileNumber.isNotEmpty &&
          !kInvalidNameFormatter.hasMatch(firstName) &&
          !kInvalidNameFormatter.hasMatch(lastName) &&
          isPhoneNumberValid;
    }
    return false;
  }

  void initializeFunction({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? mobileNumberController,
  }) {
    state.firstNameController = firstNameController;
    state.lastNameController = lastNameController;
    state.mobileNumberController = mobileNumberController;
  }

  void _checkValidation() {
    if (isReservingForSomeoneElse()) {
      checkFirstNameValidation();
      checkLastNameValidation();
      checkMobileNumberValidation();
    }
  }

  void checkFirstNameValidation() {
    if (state.firstNameController!.value.text.isEmpty ||
        kInvalidNameFormatter.hasMatch(state.firstNameController!.value.text)) {
      state.firstNameBloc!.errorInputState();
    } else {
      state.firstNameBloc!.validInputState();
    }
  }

  void checkLastNameValidation() {
    if (state.lastNameController!.value.text.isEmpty ||
        kInvalidNameFormatter.hasMatch(state.lastNameController!.value.text)) {
      state.lastNameBloc!.errorInputState();
    } else {
      state.lastNameBloc!.validInputState();
    }
  }

  void checkMobileNumberValidation() {
    if (state.mobileNumberController!.value.text.isEmpty ||
        state.mobileNumberController!.value.text.trim().length < 10 ||
        !(state.mobileNumberController!.value.text.trim().startsWith('0'))) {
      state.mobileNumberBloc!.errorInputState();
    } else {
      state.mobileNumberBloc!.validInputState();
    }
  }

  void updateTextState() {
    emit(state);
  }

  @override
  PackageGuestUserDetailModel initDefaultValue() {
    PackageGuestUserDetailModel packageGuestUserDetailModel =
        PackageGuestUserDetailModel();
    packageGuestUserDetailModel.firstNameBloc = OtaTextInputBloc();
    packageGuestUserDetailModel.lastNameBloc = OtaTextInputBloc();
    packageGuestUserDetailModel.mobileNumberBloc = OtaTextInputBloc();
    packageGuestUserDetailModel.otaRadioButtonBloc = OtaRadioButtonBloc();
    return packageGuestUserDetailModel;
  }
}
