import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/package_detail/view_model/tour_package_detail_view_model.dart';

class TourDetailViewModel {
  TourDetailModel? data;
  TourDetailScreenPageState pageState;

  TourDetailViewModel({
    required this.pageState,
    this.data,
  });
}

class TourDetailModel {
  String? tourId;
  String? name;
  String? imageUrl;
  String? locationName;
  String? categoryName;
  TourInformation? information;
  List<TourPackage>? packages;
  List<OtaFreeFoodPromotionModel> promotionData = const [];

  ///Constructor That is used to map from the Domain level Model.
  TourDetailModel.mapFromTourDetail(Tour tourDetail,
      TourDetailArgument? argument, List<TourDetailPromotionList> list) {
    tourId = tourDetail.id;
    name = tourDetail.name;
    imageUrl = tourDetail.image;
    categoryName = tourDetail.category;
    locationName = tourDetail.location;
    information =
        TourInformation.mapFromTourInformation(tourDetail.information);
    packages = List.generate(
      tourDetail.packages?.length ?? 0,
      (index) => TourPackage.mapFromTourPackage(
          tourDetail.packages?.elementAt(index), argument),
    );

    promotionData =
        List<OtaFreeFoodPromotionModel>.generate(list.length, (index) {
      return OtaFreeFoodPromotionModel(
        deepLinkUrl: list.elementAt(index).web ?? "",
        headerIcon: list.elementAt(index).iconImage ?? "",
        headerText: list.elementAt(index).title ?? "",
        subHeaderText: list.elementAt(index).description ?? "",
        promotionCode: list.elementAt(index).promotionCode ?? "",
        line1: list.elementAt(index).line1 ?? "",
      );
    });
  }
}

enum TourDetailScreenPageState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
  internetFailure,
}

class TourInformation {
  String? description;
  String? conditions;
  String? howToUse;
  String? providerName;
  String? openTime;
  String? closeTime;

  TourInformation.mapFromTourInformation(Information? information) {
    description = information?.description;
    conditions = information?.conditions;
    howToUse = information?.howToUse;
    providerName = information?.providerName;
    openTime = information?.openTime;
    closeTime = information?.closeTime;
  }
}

class TourPackage {
  TourPackageDetail? packageDetail;
  TourPackageDetailViewModel? packageScreen;

  TourPackage({this.packageDetail, this.packageScreen});

  TourPackage.mapFromTourPackage(
      Package? packages, TourDetailArgument? argument) {
    packageDetail = TourPackageDetail.mapFromTourPackage(packages);
    packageScreen =
        TourPackageDetailViewModel.mapFromTourPackage(packages, argument);
  }
}

class TourPackageDetail {
  String? name;
  List<TourHighlight>? highlights;
  double? adultPrice;
  double? childPrice;
  String? currency;
  String? rateKey;
  String? serviceId;
  String? timeOfDay;
  String? startTime;
  String? zoneId;
  String? serviceCategory;
  int? availableSeats;
  int? minimumSeats;
  String? refCode;

  TourPackageDetail({
    this.name,
    this.highlights,
    this.adultPrice,
    this.currency,
    this.rateKey,
    this.serviceId,
    this.timeOfDay,
    this.startTime,
    this.zoneId,
    this.serviceCategory,
    this.availableSeats,
    this.minimumSeats,
    this.refCode,
  });

  TourPackageDetail.mapFromTourPackage(Package? packages) {
    name = packages?.name;
    highlights =
        TourInclusions.mapFromTourInclusions(packages?.inclusions).highlights;
    adultPrice = packages?.adultPrice;
    childPrice = packages?.childPrice;
    currency = packages?.currency;
    rateKey = packages?.rateKey;
    serviceId = packages?.serviceId;
    timeOfDay = packages?.timeOfDay;
    startTime = packages?.startTime;
    zoneId = packages?.zoneId;
    serviceCategory = packages?.serviceType;
    availableSeats = packages?.availableSeats;
    minimumSeats = packages?.minimumSeats;
    refCode = packages?.refCode;
  }
}
