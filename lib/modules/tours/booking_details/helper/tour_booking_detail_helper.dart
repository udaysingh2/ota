import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/tours/booking_details/helper/date_check_helper.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_type.dart';

class TourAndTicketBookingDetailHelper {
  static String getBookingStatusText({
    required BuildContext context,
    required TourAndTicketBookingStatus bookingStatus,
    required String cancellationDate,
  }) {
    switch (bookingStatus) {
      case TourAndTicketBookingStatus.bookingCompleted:
        return getTranslated(context, AppLocalizationsStrings.completedLabel);
      case TourAndTicketBookingStatus.bookingConfirmed:
        return getTranslated(
            context, AppLocalizationsStrings.tourBookingConfirm);
      case TourAndTicketBookingStatus.bookingCancelled:
        return getTranslated(
                    context, AppLocalizationsStrings.tourBookingCancelled)
                .addTrailingSpace() +
            cancellationDate;
      case TourAndTicketBookingStatus.paymentPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityPaymentPending);
      case TourAndTicketBookingStatus.cancellationPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingCancellation);
      case TourAndTicketBookingStatus.bookingPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingConfirmation);
      case TourAndTicketBookingStatus.unsuccessfulReservation:
        return getTranslated(
            context, AppLocalizationsStrings.unsuccessfulReservation);
      case TourAndTicketBookingStatus.unsuccessfulPayment:
        return getTranslated(
            context, AppLocalizationsStrings.tourBookingUnsuccessfulPayment);
      default:
        return '';
    }
  }

  static TourAndTicketBookingStatus getBookingStatus(
      String bookingStatus, String? activityStatus, String? bookingDate) {
    switch (bookingStatus) {
      case TourBookingType.confirmed:
        if (bookingDate != null) {
          DateTime date = Helpers().parseDateTime(bookingDate);
          if (DateCheckHelper.checkIfTodayOrAfter(date)) {
            return TourAndTicketBookingStatus.bookingConfirmed;
          } else {
            return TourAndTicketBookingStatus.bookingCompleted;
          }
        } else {
          return TourAndTicketBookingStatus.bookingConfirmed;
        }
      case TourBookingType.paymentPending:
        return TourAndTicketBookingStatus.paymentPending;
      case TourBookingType.awaitingCancellation:
        return TourAndTicketBookingStatus.cancellationPending;
      case TourBookingType.pending:
        return TourAndTicketBookingStatus.bookingPending;
      case TourBookingType.rejected:
        return TourAndTicketBookingStatus.unsuccessfulReservation;
      case TourBookingType.cancelled:
        if (activityStatus != null &&
            activityStatus == TourBookingType.paymentFailed) {
          return TourAndTicketBookingStatus.unsuccessfulPayment;
        } else {
          return TourAndTicketBookingStatus.bookingCancelled;
        }
      default:
        return TourAndTicketBookingStatus.bookingPending;
    }
  }

  static TourAndTicketBookingType getBookingTypeValue(
      String bookingStatus, String? bookingDate) {
    switch (bookingStatus) {
      case TourBookingType.cancelled:
      case TourBookingType.rejected:
        return TourAndTicketBookingType.canceledBookings;
      default:
        if (bookingDate != null) {
          DateTime date = Helpers().parseDateTime(bookingDate);
          if (DateCheckHelper.checkIfTodayOrAfter(date)) {
            return TourAndTicketBookingType.ongoingBooking;
          } else {
            return TourAndTicketBookingType.completedBooking;
          }
        } else {
          return TourAndTicketBookingType.ongoingBooking;
        }
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

  static String? getNameOfParticipant(
      TourBookingDetailsParticipantsInfo? participantsInfo) {
    if (participantsInfo != null) {
      return participantsInfo.name.addTrailingSpace() +
          participantsInfo.surname;
    }
    return null;
  }

  static String getNoOfParticipants(
      BuildContext context, int adultCount, int? childCount) {
    String noOfParticipant =
        getTranslated(context, AppLocalizationsStrings.adults)
                .addTrailingSpace() +
            adultCount.toString();
    if (childCount != null && childCount > 0) {
      noOfParticipant += getTranslated(context, AppLocalizationsStrings.child)
              .addLeadingSpace() +
          childCount.toString().addLeadingSpace();
    }
    return noOfParticipant;
  }

  static bool checkCancellationEligibility(
      {required TourAndTicketBookingStatus status,
      String? confirmationDate,
      String? bookingDate,
      required String activityStatus,
      required PaymentMethodType paymentMethodType}) {
    if (bookingDate == null) {
      return false;
    }
    if (status == TourAndTicketBookingStatus.bookingConfirmed &&
        activityStatus == TourBookingType.success) {
      if (paymentMethodType == PaymentMethodType.scb) {
        return true;
      } else {
        if (confirmationDate != null) {
          DateTime confirmDate = Helpers().parseDateAndTime(confirmationDate);
          if (DateCheckHelper.checkIfTodayOrBefore(confirmDate)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  static bool isGradientStatus(TourAndTicketBookingStatus status) {
    switch (status) {
      case TourAndTicketBookingStatus.bookingCancelled:
      case TourAndTicketBookingStatus.paymentPending:
      case TourAndTicketBookingStatus.cancellationPending:
      case TourAndTicketBookingStatus.bookingPending:
      case TourAndTicketBookingStatus.unsuccessfulPayment:
      case TourAndTicketBookingStatus.unsuccessfulReservation:
        return false;
      case TourAndTicketBookingStatus.bookingCompleted:
      case TourAndTicketBookingStatus.bookingConfirmed:
        return true;
    }
  }

  static bool isContactDisabled(TourAndTicketBookingStatus status) {
    switch (status) {
      case TourAndTicketBookingStatus.bookingConfirmed:
      case TourAndTicketBookingStatus.bookingPending:
      case TourAndTicketBookingStatus.paymentPending:
      case TourAndTicketBookingStatus.cancellationPending:
        return false;
      case TourAndTicketBookingStatus.bookingCompleted:
      case TourAndTicketBookingStatus.bookingCancelled:
      case TourAndTicketBookingStatus.unsuccessfulPayment:
      case TourAndTicketBookingStatus.unsuccessfulReservation:
        return true;
    }
  }

  static int getIndex(TourAndTicketBookingType bookingType) {
    switch (bookingType) {
      case TourAndTicketBookingType.ongoingBooking:
        return 0;
      case TourAndTicketBookingType.completedBooking:
        return 1;
      case TourAndTicketBookingType.canceledBookings:
        return 2;
    }
  }
}
