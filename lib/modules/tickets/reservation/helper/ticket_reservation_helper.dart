import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/tickets/review_reservation/model/ticket_review_reservation_models.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

class TicketReservationHelper {
  static Package? getFirstPackage(TicketDetails ticketDetails) {
    if (ticketDetails.packages == null && ticketDetails.packages!.isEmpty) {
      return null;
    } else {
      return ticketDetails.packages!.first;
    }
  }

  static TicketPackageViewModel? getPackage(Package? package) {
    if (package == null) {
      return null;
    } else {
      return TicketPackageViewModel.fromPackage(package);
    }
  }

  static List<TicketHighlight>? getHighlights(Package package) {
    if (package.inclusions != null && package.inclusions!.highlights != null) {
      List<TicketHighlight>? highlights = List.generate(
          package.inclusions?.highlights?.length ?? 0,
          (index) => TicketHighlight.fromHighLight(
              package.inclusions!.highlights![index]));
      if (highlights.isEmpty) return null;
      return highlights;
    } else {
      return null;
    }
  }

  static List<OtaFreeFoodPromotionModel> generatePromotion(
      List<TicketReservationPromotionList> promotions) {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList = [];
    if (promotions.isEmpty) {
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

  static List<TicketTypeViewModel>? getTicketTypeList(Package package) {
    if (package.ticketTypes != null && package.ticketTypes!.isNotEmpty) {
      List<TicketTypeViewModel>? ticketTypeList = List.generate(
          package.ticketTypes!.length,
          (index) => TicketTypeViewModel.mapWithTicketType(
              package.ticketTypes![index]));
      if (ticketTypeList.isEmpty) return null;
      return ticketTypeList;
    } else {
      return null;
    }
  }

  static String? getCancellationHeader(List<TicketHighlight>? highlights) {
    String? cancellationHeader;
    if (highlights != null) {
      for (TicketHighlight highlight in highlights) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
          break;
        }
      }
    }
    return cancellationHeader;
  }

  static List<String> getCancellationPolicy(BuildContext context,
      String? cancellationPolicy, String cancellationPercent) {
    List<String> cancellationPolicyList = [];
    if (cancellationPolicy != null && cancellationPolicy.isNotEmpty) {
      cancellationPolicyList.add(cancellationPolicy);
    }
    cancellationPolicyList.add(
        getTranslated(context, AppLocalizationsStrings.ticketCancellationLine)
            .replaceAll('\\n', '\n')
            .trim());
    return cancellationPolicyList;
  }

  static double getTotalPrice(Package? package) {
    double totalPrice = 0;
    if (package == null || package.ticketTypes == null) return totalPrice;
    if (package.ticketTypes!.isNotEmpty) {
      for (TicketType ticketType in package.ticketTypes!) {
        totalPrice += ((ticketType.noOfTickets ?? 0) * (ticketType.price ?? 0));
      }
    }
    return totalPrice;
  }

  static int getTotalSelectedTickets(Package? package) {
    int totalSelected = 0;
    if (package == null ||
        package.ticketTypes == null ||
        package.ticketTypes!.isEmpty) return totalSelected;
    for (TicketType ticketType in package.ticketTypes!) {
      totalSelected = totalSelected + ticketType.noOfTickets!;
    }
    return totalSelected;
  }

  static TicketReviewReservationArgument? updateArgument(
      TicketReviewReservationArgument? argument,
      List<TicketTypeViewModel> ticketType) {
    if (argument != null) {
      argument.ticketReservationArgument = List.generate(
          ticketType.length,
          (index) => TicketReservationArgument.mapFromTicketTypeViewModel(
              ticketType[index]));
    }
    return argument;
  }
}
