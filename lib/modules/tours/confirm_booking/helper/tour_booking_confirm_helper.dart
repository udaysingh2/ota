import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/guest_information_argument_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _kTourString = "TOUR";
const String _kKeyForAdult = 'adult';
const String _kKeyForChild = 'child';

class TourConfirmBookingHelper {
  static ConfirmBookingArgument getTourConfirmBookingArgument({
    required TourReviewReservationViewModel reservationViewModel,
    required UserDetailViewModel userDetailViewModel,
    required bool isBookingForSomeoneElse,
    required List<GuestInformationData> guestInformationList,
    Pickup? tourPickup,
    String? additionalRequest,
  }) {
    return ConfirmBookingArgument(
      bookingUrn: reservationViewModel.bookingUrn,
      bookingType: _kTourString,
      serviceId: reservationViewModel.tourId,
      additionalNeedText: additionalRequest,
      noOfDays: reservationViewModel.tourPackage!.numberOfDays ?? "",
      isBookingForSomeoneElse: isBookingForSomeoneElse,
      totalPrice: reservationViewModel.totalPrice,
      customerInfoArgument:
          CustomerInfoData.mapFromUserDetail(userDetailViewModel),
      guestInfoList: List.generate(
          guestInformationList.length,
          (index) => GuestInfo.mapFromGuestInformationData(
              guestInformationList[index])),
      pickupArgument: tourPickup,
    );
  }

  static List<GuestInformationData> getGuestInformationList({
    required Map<String, GuestInformationData> guestDataMap,
    required bool isMapingForAll,
    required int adultCount,
    required int childCount,
  }) {
    List<GuestInformationData> guestInformationList = [];
    if (isMapingForAll) {
      for (int index = 1; index <= adultCount; index++) {
        if (guestDataMap["$_kKeyForAdult$index"] != null) {
          guestInformationList.add(guestDataMap["$_kKeyForAdult$index"]!);
        }
      }
      for (int index = 1; index <= childCount; index++) {
        if (guestDataMap["$_kKeyForChild$index"] != null) {
          guestInformationList.add(guestDataMap["$_kKeyForChild$index"]!);
        }
      }
    } else {
      guestInformationList.add(guestDataMap["${_kKeyForAdult}1"]!);
    }
    return guestInformationList;
  }

  static List<ParticipantInfoViewModel>? getParticipantInfo(
      TourConfirmBookingData data) {
    if (data.participantInfo != null) {
      List<ParticipantInfoViewModel>? participantInfoList = List.generate(
          data.participantInfo?.length ?? 0,
          (index) => ParticipantInfoViewModel.fromParticipantInfo(
              data.participantInfo![index]));
      if (participantInfoList.isEmpty) return null;
      return participantInfoList;
    } else {
      return null;
    }
  }

  static String? getCancellationHeader(
      List<TourHighlightViewModel>? highlights) {
    String? cancellationHeader;
    if (highlights != null) {
      for (TourHighlightViewModel highlight in highlights) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
        }
      }
    }
    return cancellationHeader;
  }

  static List<TourHighlightViewModel>? getHighlights(PackageDetail detail) {
    if (detail.inclusions != null && detail.inclusions!.highlights != null) {
      List<TourHighlightViewModel>? highlights = List.generate(
          detail.inclusions?.highlights?.length ?? 0,
          (index) => TourHighlightViewModel.fromHighLight(
              detail.inclusions!.highlights![index]));
      if (highlights.isEmpty) return null;
      return highlights;
    } else {
      return null;
    }
  }

  static List<String> getCancellationPolicy(BuildContext context,
      String? cancellationPolicy, String cancellationPercent) {
    List<String> cancellationPolicyList = [];
    if (cancellationPolicy != null && cancellationPolicy.isNotEmpty) {
      cancellationPolicyList.add(cancellationPolicy);
    }
    cancellationPolicyList.add(
        getTranslated(context, AppLocalizationsStrings.tourCancellationLine)
            .replaceAll('\\n', '\n')
            .trim());
    return cancellationPolicyList;
  }

  static CustomerInfoViewModel? getCustomerInfo(TourConfirmBookingData data) {
    if (data.customerInfo != null) {
      return CustomerInfoViewModel.fromCustomerInfo(data.customerInfo!);
    } else {
      return null;
    }
  }

  static List<Highlights>? generateHighlightList(
      List<TourHighlightViewModel>? tourHighlights) {
    List<Highlights> highlightList = [];
    if (tourHighlights != null && tourHighlights.isNotEmpty) {
      highlightList = List<Highlights>.generate(tourHighlights.length, (index) {
        return Highlights(
          key: tourHighlights.elementAt(index).key,
          value: tourHighlights.elementAt(index).value,
        );
      });
    }
    return highlightList;
  }

  static bool isMinAmountValidationFailed(
      {required bool isWalletEnabled,
      double? paidByWallet,
      required double onlinePayableAmount}) {
    double totalAmount = onlinePayableAmount + (paidByWallet ?? 0.0);
    if (totalAmount < AppConfig().configModel.netPriceBoundaryInBaht) {
      return true;
    } else if (isWalletEnabled && onlinePayableAmount == 0.0) {
      return false;
    } else if (onlinePayableAmount >
        AppConfig().configModel.netPriceBoundaryInBaht) {
      return false;
    } else {
      return true;
    }
  }
}
