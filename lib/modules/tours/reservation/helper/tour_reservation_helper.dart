import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

class TourReservationHelper {
  static TourPackageViewModel? checkPackageList(TourDetails tourDetails) {
    if (tourDetails.packages == null && tourDetails.packages!.isEmpty) {
      return null;
    }
    TourPackageViewModel package =
        TourPackageViewModel.fromPackage(tourDetails.packages!.first);
    return package;
  }

  static List<TourHighlight>? getHighlights(Package package) {
    if (package.inclusions != null && package.inclusions!.highlights != null) {
      List<TourHighlight>? highlights = List.generate(
          package.inclusions?.highlights?.length ?? 0,
          (index) => TourHighlight.fromHighLight(
              package.inclusions!.highlights![index]));
      if (highlights.isEmpty) return null;
      return highlights;
    } else {
      return null;
    }
  }

  static String? getCancellationHeader(List<TourHighlight>? highlights) {
    String? cancellationHeader;
    if (highlights != null) {
      for (TourHighlight highlight in highlights) {
        if (highlight.key == kRefundType) {
          cancellationHeader = highlight.value;
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
        getTranslated(context, AppLocalizationsStrings.tourCancellationLine)
            .replaceAll('\\n', '\n')
            .trim());
    return cancellationPolicyList;
  }

  static double getTotalPrice(
      int adultCount, int childCount, TourPackageViewModel? package) {
    if (package == null) return 0;
    double adultPrice = package.adultPrice;
    double childPrice = package.childPrice ?? 0;
    double totalPrice = ((adultCount * adultPrice) + (childCount * childPrice));
    return totalPrice;
  }
}
