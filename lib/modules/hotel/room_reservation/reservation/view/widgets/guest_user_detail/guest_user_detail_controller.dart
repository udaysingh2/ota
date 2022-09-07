import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_model.dart';

class GuestUserDetailController extends Bloc<GuestUserDetailModel> {
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
              OtaTextInputState.valid) {
        return true;
        ////Use this for Api call
      }
    }
    return false;
  }

  bool isValidationConfirmed() {
    if (isReservingForSomeoneElse()) {
      String firstName = state.firstNameController?.text ?? "";
      String lastName = state.lastNameController?.text ?? "";
      return firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          !kInvalidNameFormatter.hasMatch(firstName) &&
          !kInvalidNameFormatter.hasMatch(lastName);
    }
    return false;
  }

  void initializeFunction({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
  }) {
    state.firstNameController = firstNameController;
    state.lastNameController = lastNameController;
  }

  void _checkValidation() {
    if (isReservingForSomeoneElse()) {
      checkFirstNameValidation();
      checkLastNameValidation();
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

  void updateTextState() {
    emit(state);
  }

  @override
  GuestUserDetailModel initDefaultValue() {
    GuestUserDetailModel guestUserDetailModel = GuestUserDetailModel();
    guestUserDetailModel.firstNameBloc = OtaTextInputBloc();
    guestUserDetailModel.lastNameBloc = OtaTextInputBloc();
    guestUserDetailModel.mobileNumberBloc = OtaTextInputBloc();
    guestUserDetailModel.flightNumberBloc = OtaTextInputBloc();
    guestUserDetailModel.otaRadioButtonBloc = OtaRadioButtonBloc();
    return guestUserDetailModel;
  }
}
