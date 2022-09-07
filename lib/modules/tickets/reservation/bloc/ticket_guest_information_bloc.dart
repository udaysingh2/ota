import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';

class TicketGuestInformationBloc extends Bloc<TicketGuestInformationViewModel> {
  TicketGuestInformationArgumentModel? _guestInformationArgumentModel;

  setGuestArgumentData(
      TicketGuestInformationArgumentModel guestInformationArgumentModel) {
    _guestInformationArgumentModel = guestInformationArgumentModel;
    emit(state);
  }

  @override
  initDefaultValue() {
    TicketGuestInformationViewModel guestInformationViewModel =
        TicketGuestInformationViewModel(
      guestInformationArgumentData: TicketGuestInformationData(
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

  setGuestUserData(TicketGuestInformationData guestData) {
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

    if ((_guestInformationArgumentModel?.isDateOfBirthRequired) ?? false) {
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
}
