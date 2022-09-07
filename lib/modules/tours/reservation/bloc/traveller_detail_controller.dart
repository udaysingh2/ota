import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _kAdultKey = 'adult';
const String _kChildKey = 'child';
const String _kAdultfirstIndexKey = 'adult1';

class TravellerController extends Bloc<TravellerModel> {
  @override
  TravellerModel initDefaultValue() {
    return TravellerModel(
      guestInformationList: {},
    );
  }

  void updateGuestInformation(String key, GuestInformationData info) {
    state.guestInformationList[key] = info;
    emit(state);
  }

  bool isWarningIconVisible({
    required String key,
    TourRequireInfoViewModel? tourRequireInfoViewModel,
    bool isForFinalValidation = false,
  }) {
    if (state.guestInformationList.containsKey(key)) {
      GuestInformationData? info = state.guestInformationList[key];
      if (info != null) {
        if ((tourRequireInfoViewModel?.guestName) ?? false) {
          if (info.guestFirstName.isEmpty) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.guestName) ?? false) {
          if (info.guestLastName.isEmpty) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.weight) ?? false) {
          if ((info.guestWeight ?? '').isEmpty) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.dateOfBirth) ?? false) {
          if (info.selectedDob == null) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.passportCountry) ?? false) {
          if (info.selectedPassportCountry == null) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.passportId) ?? false) {
          if ((info.guestPassportId ?? "").isEmpty) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.passportCountryIssue) ?? false) {
          if (info.selectedPassportIssuingCountry == null) {
            return true;
          }
        }

        if ((tourRequireInfoViewModel?.passportValidDate) ?? false) {
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

  bool isAllAdultTravellersInfoValid({
    required int adultCount,
    required TourRequireInfoViewModel? tourRequireInfoViewModel,
  }) {
    for (int index = 1; index <= adultCount; index++) {
      bool isWarning = isWarningIconVisible(
        key: _kAdultKey + index.toString(),
        tourRequireInfoViewModel: tourRequireInfoViewModel,
        isForFinalValidation: true,
      );
      if (isWarning) {
        return !isWarning;
      }
    }

    return true;
  }

  bool isAllChildTravellersInfoValid({
    required int childCount,
    required TourRequireInfoViewModel? tourRequireInfoViewModel,
  }) {
    for (int index = 1; index <= childCount; index++) {
      bool isWarning = isWarningIconVisible(
        key: _kChildKey + index.toString(),
        tourRequireInfoViewModel: tourRequireInfoViewModel,
        isForFinalValidation: true,
      );
      if (isWarning) {
        return !isWarning;
      }
    }
    return true;
  }

  setFirstGuestInfo(GuestInformationData info) {
    if (state.guestInformationList.containsKey(_kAdultfirstIndexKey)) {
      state.guestInformationList[_kAdultfirstIndexKey]?.guestFirstName =
          info.guestFirstName;
      state.guestInformationList[_kAdultfirstIndexKey]?.guestLastName =
          info.guestLastName;
      state.guestInformationList[_kAdultfirstIndexKey]?.guestMobileNumber =
          info.guestMobileNumber;
      state.guestInformationList[_kAdultfirstIndexKey]?.guestEmail =
          info.guestEmail;
    } else {
      state.guestInformationList[_kAdultfirstIndexKey] = info;
    }
    emit(state);
  }
}

class TravellerModel {
  Map<String, GuestInformationData> guestInformationList;

  TravellerModel({
    required this.guestInformationList,
  });
}
