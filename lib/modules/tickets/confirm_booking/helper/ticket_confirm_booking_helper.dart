import 'package:ota/core/app_config.dart';
import 'package:ota/domain/tickets/confirm_booking/models/ticket_confirm_booking_model_domain.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart'
    as ticket_view_model;
import 'package:ota/modules/tickets/reservation/view_model/ticket_guest_information_argument_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/confirm_booking_argument.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

const String _kTicketString = "TICKET";

class TicketConfirmBookingHelper {
  static ConfirmBookingArgument getTicketConfirmBookingArgument({
    required TicketReviewReservationViewModel reservationViewModel,
    required UserDetailViewModel userDetailViewModel,
    required bool isBookingForSomeoneElse,
    required List<TicketGuestInformationData> guestInformationList,
    Pickup? tourPickup,
    String? additionalRequest,
    bool? isAdditionalGuestAvialable,
  }) {
    return ConfirmBookingArgument(
      bookingUrn: reservationViewModel.bookingUrn,
      bookingType: _kTicketString,
      serviceId: reservationViewModel.ticketId,
      additionalNeedText: additionalRequest,
      noOfDays: reservationViewModel.ticketPackage!.duration ?? "",
      isBookingForSomeoneElse: isBookingForSomeoneElse,
      totalPrice: reservationViewModel.totalPrice,
      customerInfoArgument:
          CustomerInfoData.mapFromUserDetail(userDetailViewModel),
      guestInfoList: List.generate(
          guestInformationList.length,
          (index) => GuestInfo.mapFromTicketGuestInformationData(
              guestInformationList[index])),
      pickupArgument: tourPickup,
      isAdditionalGuestAvailable: isAdditionalGuestAvialable,
    );
  }

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<TicketConfirmationPromotionList>? promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions == null || promotions.isEmpty) {
      return freeFoodPromotionList;
    }
    for (int i = 0; i < promotions.length; i++) {
      freeFoodPromotionList.add(OtaFreeFoodPromotionModel(
        headerText: promotions[i].title ?? "",
        subHeaderText: promotions[i].description ?? "",
        headerIcon: promotions[i].iconImage ?? "",
        deepLinkUrl: promotions[i].web ?? "",
        line1: promotions[i].line1 ?? "",
      ));
    }
    return freeFoodPromotionList;
  }

  static List<TicketGuestInformationData> getGuestInformationList({
    required Map<String, TicketGuestInformationData> guestDataMap,
    required bool isMapingForAll,
    required int ticketCount,
  }) {
    List<TicketGuestInformationData> guestInformationList = [];
    if (isMapingForAll) {
      for (int index = 1; index <= ticketCount; index++) {
        if (guestDataMap["$index"] != null) {
          guestInformationList.add(guestDataMap["$index"]!);
        }
      }
    } else {
      guestInformationList.add(guestDataMap["1"]!);
    }
    return guestInformationList;
  }

  static double getTotalPrice(
      double totalPrice, double? fees, double? tax, double? discount) {
    if (fees != null) totalPrice = totalPrice + fees;
    if (tax != null) totalPrice = totalPrice + tax;
    if (discount != null) totalPrice = totalPrice - discount;
    return totalPrice;
  }

  static List<ticket_view_model.TicketParticipantInfoViewModel>?
      getParticipantInfoList(List<ParticipantInfo>? participantInfo) {
    if (participantInfo != null && participantInfo.isNotEmpty) {
      List<ticket_view_model.TicketParticipantInfoViewModel> participantList =
          [];
      participantList = List.generate(
          participantInfo.length,
          (index) => ticket_view_model.TicketParticipantInfoViewModel
              .fromParticipantInfo(participantInfo.elementAt(index)));
      return participantList;
    }
    return null;
  }

  static List<ticket_view_model.TicketHighlightViewModel>?
      getTicketHighLightList(PackageDetail package) {
    if (package.inclusions != null &&
        package.inclusions!.highlights != null &&
        package.inclusions!.highlights!.isNotEmpty) {
      List<ticket_view_model.TicketHighlightViewModel> ticketHightlight = [];
      ticketHightlight = List.generate(
          package.inclusions!.highlights!.length,
          (index) =>
              ticket_view_model.TicketHighlightViewModel.mapFromTicketHighlight(
                  package.inclusions!.highlights!.elementAt(index)));
      return ticketHightlight;
    }
    return null;
  }

  static String? getCancellationHeader(
      List<ticket_view_model.TicketHighlightViewModel>? highlights) {
    String? cancellationHeader;
    if (highlights != null) {
      for (ticket_view_model.TicketHighlightViewModel highlight in highlights) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
        }
      }
    }
    return cancellationHeader;
  }

  static List<Highlights> getHighLightList(
      List<ticket_view_model.TicketHighlightViewModel>? ticketHighlight) {
    if (ticketHighlight != null && ticketHighlight.isNotEmpty) {
      List<Highlights> highlights = List.generate(
          ticketHighlight.length,
          (index) => Highlights(
              key: ticketHighlight.elementAt(index).key,
              value: ticketHighlight.elementAt(index).value));
      return highlights;
    }
    return [];
  }

  static List<TourOrTicketsType> getTourOrTicketTypeList(
      List<ticket_view_model.TicketTypeViewModel> ticketTypeList) {
    List<TourOrTicketsType> ticketArgumentList = List.generate(
      ticketTypeList.length,
      (index) => TourOrTicketsType(
        name: ticketTypeList.elementAt(index).name,
        price: ticketTypeList.elementAt(index).price,
        count: ticketTypeList.elementAt(index).noOfTickets,
      ),
    );
    return ticketArgumentList;
  }

  static ParticipantInfoViewModel getFromParticipantInfo(
      ticket_view_model.TicketParticipantInfoViewModel particpant) {
    return ParticipantInfoViewModel(
      dateOfBirth: particpant.dateOfBirth,
      expiryDate: particpant.expiryDate,
      name: particpant.name,
      passportCountry: particpant.passportCountry,
      passportCountryIssue: particpant.passportCountryIssue,
      passportNumber: particpant.passportNumber,
      surname: particpant.surname,
      weight: particpant.weight != null
          ? double.tryParse(particpant.weight!)
          : null,
      paxId: particpant.paxId,
    );
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
