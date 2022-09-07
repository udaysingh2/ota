import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';

class GuestInformationBloc extends Bloc<GuestInformationViewModel> {
  GuestInformationArgumentModel? _guestInformationArgumentModel;

  setGuestArgumentData(
      GuestInformationArgumentModel guestInformationArgumentModel) {
    _guestInformationArgumentModel = guestInformationArgumentModel;
    emit(state);
  }

  @override
  initDefaultValue() {
    GuestInformationViewModel guestInformationViewModel =
        GuestInformationViewModel(
      guestInformationArgumentData: GuestInformationData(
        guestFirstName: '',
        guestLastName: '',
      ),
    );

    guestInformationViewModel.firstNameBloc = OtaTextInputBloc();
    guestInformationViewModel.lastNameBloc = OtaTextInputBloc();
    guestInformationViewModel.guestWeightBloc = OtaTextInputBloc();
    guestInformationViewModel.guestDobBloc = OtaTextInputBloc();
    guestInformationViewModel.guestPassportCountryBloc = OtaTextInputBloc();
    guestInformationViewModel.guestPassportIdBloc = OtaTextInputBloc();
    guestInformationViewModel.guestPassportIssuingCountryBloc =
        OtaTextInputBloc();
    guestInformationViewModel.guestPassportExpirationDateBloc =
        OtaTextInputBloc();

    return guestInformationViewModel;
  }

  setGuestUserData(GuestInformationData guestData) {
    state.guestInformationArgumentData.guestFirstName =
        guestData.guestFirstName;
    state.guestInformationArgumentData.guestLastName = guestData.guestLastName;
    state.guestInformationArgumentData.guestWeight = guestData.guestWeight;
    state.guestInformationArgumentData.selectedDob = guestData.selectedDob;
    state.guestInformationArgumentData.selectedPassportCountry =
        guestData.selectedPassportCountry;
    state.guestInformationArgumentData.guestPassportId =
        guestData.guestPassportId;
    state.guestInformationArgumentData.selectedPassportIssuingCountry =
        guestData.selectedPassportIssuingCountry;
    state.guestInformationArgumentData.selectedPassportValidityDate =
        guestData.selectedPassportValidityDate;
    emit(state);
  }

  updateSelectedDateValue(
      {required DateTime selectedDate, required bool isForDOB}) {
    if (isForDOB) {
      state.guestInformationArgumentData.selectedDob = selectedDate;
    } else {
      state.guestInformationArgumentData.selectedPassportValidityDate =
          selectedDate;
    }
    emit(state);
  }

  updateSelectedCountryValue(
      {required String selectedCountry, required bool isForPassportCountry}) {
    if (isForPassportCountry) {
      state.guestInformationArgumentData.selectedPassportCountry =
          selectedCountry;
    } else {
      state.guestInformationArgumentData.selectedPassportIssuingCountry =
          selectedCountry;
    }
    emit(state);
  }

  bool isAllFieldValid() {
    if ((_guestInformationArgumentModel?.isGuestNameRequired) ?? false) {
      if (state.guestInformationArgumentData.guestFirstName.isEmpty) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isGuestNameRequired) ?? false) {
      if (state.guestInformationArgumentData.guestLastName.isEmpty) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isWeightRequired) ?? false) {
      if ((state.guestInformationArgumentData.guestWeight ?? '').isEmpty) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isDateofBirthRequired) ?? false) {
      if (state.guestInformationArgumentData.selectedDob == null) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isPassportCountryRequired) ?? false) {
      if (state.guestInformationArgumentData.selectedPassportCountry == null) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isPassportIdRequired) ?? false) {
      if ((state.guestInformationArgumentData.guestPassportId ?? "").isEmpty) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isPassportCountryIssueRequired) ??
        false) {
      if (state.guestInformationArgumentData.selectedPassportIssuingCountry ==
          null) {
        return false;
      }
    }

    if ((_guestInformationArgumentModel?.isPassportValidDateRequired) ??
        false) {
      if (state.guestInformationArgumentData.selectedPassportValidityDate ==
          null) {
        return false;
      }
    }
    return true;
  }

  bool checkValidation() {
    bool isAllFieldValid = true;

    if ((_guestInformationArgumentModel?.isGuestNameRequired) ?? false) {
      if (state.guestInformationArgumentData.guestFirstName.isEmpty) {
        state.firstNameBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.firstNameBloc!.validInputState();
      }
    }

    if ((_guestInformationArgumentModel?.isGuestNameRequired) ?? false) {
      if (state.guestInformationArgumentData.guestLastName.isEmpty) {
        state.lastNameBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.lastNameBloc!.validInputState();
      }
    }

    if ((_guestInformationArgumentModel?.isWeightRequired) ?? false) {
      if (state.guestInformationArgumentData.guestWeight?.isNotEmpty ?? false) {
        state.guestWeightBloc!.validInputState();
      } else {
        state.guestWeightBloc!.errorInputState();
        isAllFieldValid = false;
      }
    }

    if ((_guestInformationArgumentModel?.isDateofBirthRequired) ?? false) {
      if (state.guestInformationArgumentData.selectedDob == null) {
        state.guestDobBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.guestDobBloc!.validInputState();
      }
    }

    if ((_guestInformationArgumentModel?.isPassportCountryRequired) ?? false) {
      if (state.guestInformationArgumentData.selectedPassportCountry == null) {
        state.guestPassportCountryBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.guestPassportCountryBloc!.validInputState();
      }
    }

    if ((_guestInformationArgumentModel?.isPassportIdRequired) ?? false) {
      if (state.guestInformationArgumentData.guestPassportId?.isNotEmpty ??
          false) {
        state.guestPassportIdBloc!.validInputState();
      } else {
        state.guestPassportIdBloc!.errorInputState();
        isAllFieldValid = false;
      }
    }

    if ((_guestInformationArgumentModel?.isPassportCountryIssueRequired) ??
        false) {
      if (state.guestInformationArgumentData.selectedPassportIssuingCountry ==
          null) {
        state.guestPassportIssuingCountryBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.guestPassportIssuingCountryBloc!.validInputState();
      }
    }

    if ((_guestInformationArgumentModel?.isPassportValidDateRequired) ??
        false) {
      if (state.guestInformationArgumentData.selectedPassportValidityDate ==
          null) {
        state.guestPassportExpirationDateBloc!.errorInputState();
        isAllFieldValid = false;
      } else {
        state.guestPassportExpirationDateBloc!.validInputState();
      }
    }
    return isAllFieldValid;
  }
}
