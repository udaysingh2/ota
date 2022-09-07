import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

class TourPackageDetailViewModel {
  TourDetailArgument? argument;
  String? name;
  String? exclusions;
  String? schedule;
  String? meetingPoint;
  String? cancellationPolicy;
  String? shuttle;
  double? adultPrice;
  double? childPrice;
  String? currency;
  String? refCode;
  String? serviceId;
  String? zoneId;
  String? serviceCategory;
  String? rateKey;
  int? availableSeats;
  int? minimumSeats;
  String? timeOfDay;
  String? startTime;
  String? allInclusion;
  TourChildInfo? childInfo;
  String? conditions;
  TourPackageDetailViewModel.mapFromTourPackage(
      Package? packages, this.argument) {
    name = packages?.name;
    exclusions = packages?.exclusions;
    schedule = packages?.schedule;
    meetingPoint = packages?.meetingPoint;
    cancellationPolicy = packages?.cancellationPolicy;
    shuttle = packages?.shuttle;
    adultPrice = packages?.adultPrice;
    childPrice = packages?.childPrice;
    currency = packages?.currency;
    refCode = packages?.refCode;
    serviceId = packages?.serviceId;
    zoneId = packages?.zoneId;
    serviceCategory = packages?.serviceType;
    rateKey = packages?.rateKey;
    availableSeats = packages?.availableSeats;
    minimumSeats = packages?.minimumSeats;
    timeOfDay = packages?.timeOfDay;
    startTime = packages?.startTime;
    allInclusion =
        TourInclusions.mapFromTourInclusions(packages?.inclusions).all;
    childInfo = TourChildInfo.mapFromTourChildInfo(packages?.childInfo);
    conditions = packages?.conditions;
  }
}

class TourInclusions {
  List<TourHighlight>? highlights;
  String? all;
  TourInclusions.mapFromTourInclusions(Inclusions? inclusions) {
    all = inclusions?.all;
    highlights = List.generate(
        inclusions?.highlights?.length ?? 0,
        (index) => TourHighlight.mapFromTourHighlight(
            inclusions?.highlights?.elementAt(index)));
  }
}

class TourChildInfo {
  int? minAge;
  int? maxAge;
  String? description;
  TourChildInfo.mapFromTourChildInfo(ChildInfo? childInfo) {
    maxAge = childInfo?.minAge;
    maxAge = childInfo?.maxAge;
    description = childInfo?.description;
  }
}

class TourHighlight {
  String? key;
  String? value;
  TourHighlight.mapFromTourHighlight(Highlight? highlight) {
    if (highlight?.key != null && highlight?.value != null) {
      key = highlight?.key;
      value = highlight?.value;
    }
  }
}
