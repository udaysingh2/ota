import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';

const String _kFirstTicketHolderKey = '1';

class TicketTravellerController extends Bloc<TicketTravellerModel> {
  @override
  TicketTravellerModel initDefaultValue() {
    return TicketTravellerModel(
      ticketGuestInformationList: {},
    );
  }

  void updateGuestInformation(String key, TicketGuestInformationData info) {
    state.ticketGuestInformationList[key] = info;
    emit(state);
  }

  bool isWarningIconVisible({
    required String key,
    TicketRequireInfoViewModel? ticketRequireInfoViewModel,
    bool isForFinalValidation = false,
  }) {
    if (state.ticketGuestInformationList.containsKey(key)) {
      TicketGuestInformationData? info = state.ticketGuestInformationList[key];
      if (info != null) {
        if ((ticketRequireInfoViewModel?.guestName) ?? false) {
          if (info.guestFirstName.isEmpty) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.guestName) ?? false) {
          if (info.guestLastName.isEmpty) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.weight) ?? false) {
          if ((info.guestWeight ?? '').isEmpty) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.dateOfBirth) ?? false) {
          if (info.selectedDob == null) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.passportCountry) ?? false) {
          if (info.selectedPassportCountry == null) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.passportId) ?? false) {
          if ((info.guestPassportId ?? "").isEmpty) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.passportCountryIssue) ?? false) {
          if (info.selectedPassportIssuingCountry == null) {
            return true;
          }
        }

        if ((ticketRequireInfoViewModel?.passportValidDate) ?? false) {
          if (info.selectedPassportValidityDate == null) {
            return true;
          }
        }
      } else {
        if (isForFinalValidation) {
          return true;
        }
      }
    } else {
      if (isForFinalValidation) {
        return true;
      }
    }
    return false;
  }

  bool isAllTicketHoldersInfoValid({
    required int ticketCount,
    required TicketRequireInfoViewModel? ticketRequireInfoViewModel,
  }) {
    for (int index = 1; index <= ticketCount; index++) {
      bool isWarning = isWarningIconVisible(
        key: index.toString(),
        ticketRequireInfoViewModel: ticketRequireInfoViewModel,
        isForFinalValidation: true,
      );
      if (isWarning) {
        return !isWarning;
      }
    }

    return true;
  }

  setFirstGuestInfo(TicketGuestInformationData info) {
    if (state.ticketGuestInformationList.containsKey(_kFirstTicketHolderKey)) {
      state.ticketGuestInformationList[_kFirstTicketHolderKey]?.guestFirstName =
          info.guestFirstName;
      state.ticketGuestInformationList[_kFirstTicketHolderKey]?.guestLastName =
          info.guestLastName;
      state.ticketGuestInformationList[_kFirstTicketHolderKey]
          ?.guestMobileNumber = info.guestMobileNumber;
      state.ticketGuestInformationList[_kFirstTicketHolderKey]?.guestEmail =
          info.guestEmail;
    } else {
      state.ticketGuestInformationList[_kFirstTicketHolderKey] = info;
    }
    emit(state);
  }
}

class TicketTravellerModel {
  Map<String, TicketGuestInformationData> ticketGuestInformationList;

  TicketTravellerModel({
    required this.ticketGuestInformationList,
  });
}
