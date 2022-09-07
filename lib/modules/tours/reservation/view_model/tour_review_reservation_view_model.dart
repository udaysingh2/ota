import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tours/review_reservation/models/tours_review_reservation_models.dart';
import 'package:ota/modules/tours/reservation/helper/tour_reservation_helper.dart';

class TourReviewReservationViewModel {
  TourReviewReservationViewModel({
    required this.bookingUrn,
    required this.tourName,
    required this.tourId,
    required this.totalPrice,
    required this.lastPrice,
    required this.adultCount,
    this.tourImage,
    this.tourPackage,
    this.childCount,
    this.location,
    this.category,
    required this.promotionData,
  });

  final String bookingUrn;
  final String tourName;
  final String tourId;
  final double totalPrice;
  double lastPrice;
  final int adultCount;
  final String? tourImage;
  final TourPackageViewModel? tourPackage;
  final int? childCount;
  final String? location;
  final String? category;
  final List<OtaFreeFoodPromotionModel> promotionData;

  factory TourReviewReservationViewModel.fromData(
          {required Data data,
          required double lastPrice,
          required int adultCount,
          required int childCount,
          required List<TourReservationPromotionList> promotionList}) =>
      TourReviewReservationViewModel(
        bookingUrn: data.bookingUrn!,
        tourName: data.tourName!,
        tourId: data.tourDetails!.id!,
        totalPrice: TourReservationHelper.getTotalPrice(adultCount, childCount,
            TourReservationHelper.checkPackageList(data.tourDetails!)),
        lastPrice: lastPrice,
        adultCount: adultCount,
        tourImage: data.tourImage,
        tourPackage: TourReservationHelper.checkPackageList(data.tourDetails!),
        childCount: childCount,
        location: data.tourDetails?.location,
        category: data.tourDetails?.category,
        promotionData: List.generate(
          promotionList.length,
          (index) => OtaFreeFoodPromotionModel(
            deepLinkUrl: promotionList.elementAt(index).web ?? "",
            headerIcon: promotionList.elementAt(index).iconImage ?? "",
            headerText: promotionList.elementAt(index).title ?? "",
            subHeaderText: promotionList.elementAt(index).description ?? "",
            promotionCode: promotionList.elementAt(index).promotionCode ?? "",
            line1: promotionList.elementAt(index).line1 ?? "",
          ),
        ),
      );
}

class TourPackageViewModel {
  TourPackageViewModel({
    required this.packageName,
    required this.refCode,
    required this.serviceId,
    required this.rateKey,
    required this.adultPrice,
    required this.adultPaxId,
    required this.childPaxId,
    this.childPrice,
    this.highlights,
    this.cancellationHeader,
    this.cancellationPolicy,
    this.currency,
    this.availableSeats,
    this.minimumSeats,
    this.durationText,
    this.numberOfDays,
    this.zoneId,
    this.requireInfo,
    this.childInfo,
  });

  final String packageName;
  final String refCode;
  final String serviceId;
  final String rateKey;
  final double adultPrice;
  final String adultPaxId;
  final String childPaxId;
  final double? childPrice;
  final List<TourHighlight>? highlights;
  final String? cancellationHeader;
  final String? cancellationPolicy;
  final String? currency;
  final int? availableSeats;
  final int? minimumSeats;
  final String? durationText;
  final String? numberOfDays;
  final String? zoneId;
  final TourRequireInfoViewModel? requireInfo;
  final ToursChildInfo? childInfo;

  factory TourPackageViewModel.fromPackage(Package package) =>
      TourPackageViewModel(
        packageName: package.name!,
        refCode: package.refCode!,
        serviceId: package.serviceId!,
        rateKey: package.rateKey!,
        adultPrice: package.adultPrice!,
        adultPaxId: package.adultPaxId!,
        childPaxId: package.childPaxId!,
        childPrice: package.childPrice,
        highlights: TourReservationHelper.getHighlights(package),
        cancellationHeader: TourReservationHelper.getCancellationHeader(
            TourReservationHelper.getHighlights(package)),
        cancellationPolicy: package.cancellationPolicy,
        currency: package.currency,
        availableSeats: package.availableSeats,
        minimumSeats: package.minimumSeats,
        durationText: package.durationText,
        //Fixed no of days to 1 as part of OTA-4182. Should be updated once this featured is implemented.
        numberOfDays: "1",
        zoneId: package.zoneId,
        requireInfo:
            TourRequireInfoViewModel.fromRequiredInfoModel(package.requireInfo),
        childInfo: ToursChildInfo.mapFromChildInfo(package.childInfo),
      );
}

class TourHighlight {
  TourHighlight({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory TourHighlight.fromHighLight(Highlight? highlight) => TourHighlight(
        key: highlight?.key,
        value: highlight?.value,
      );
}

class ToursChildInfo {
  final int? minAge;
  final int? maxAge;

  ToursChildInfo({
    this.minAge,
    this.maxAge,
  });

  factory ToursChildInfo.mapFromChildInfo(ChildInfo? childInfo) =>
      ToursChildInfo(
        minAge: childInfo?.minAge,
        maxAge: childInfo?.maxAge,
      );
}

class TourRequireInfoViewModel {
  TourRequireInfoViewModel({
    this.weight,
    this.allName,
    this.guestName,
    this.passportId,
    this.dateOfBirth,
    this.passportCountry,
    this.passportValidDate,
    this.passportCountryIssue,
  });

  final bool? weight;
  final bool? allName;
  final bool? guestName;
  final bool? passportId;
  final bool? dateOfBirth;
  final bool? passportCountry;
  final bool? passportValidDate;
  final bool? passportCountryIssue;

  factory TourRequireInfoViewModel.fromRequiredInfoModel(
          RequireInfo? requireInfo) =>
      TourRequireInfoViewModel(
        weight: requireInfo?.weight,
        allName: requireInfo?.allName,
        guestName: requireInfo?.guestName,
        passportId: requireInfo?.passportId,
        dateOfBirth: requireInfo?.dateOfBirth,
        passportCountry: requireInfo?.passportCountry,
        passportValidDate: requireInfo?.passportValidDate,
        passportCountryIssue: requireInfo?.passportCountryIssue,
      );
}
