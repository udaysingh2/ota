import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';

class TourBookingPackageDetailViewModel {
  String? packageName;
  TourPackageInclusions? inclusions;
  String? cancellationPolicy;
  String? durationText;
  String? exclusions;
  String? conditions;
  String? shuttle;
  String? meetingPoint;
  String? meetingPointLatitude;
  String? meetingPointLongitude;
  String? schedule;
  TourPackageChildInfo? childInfo;

  TourBookingPackageDetailViewModel.mapFromTourPackage(
      PackageDetail? packages) {
    packageName = packages?.packageName;
    inclusions =
        TourPackageInclusions.mapFromTourInclusions(packages?.inclusions);
    cancellationPolicy = packages?.cancellationPolicy;
    durationText = packages?.durationText;
    exclusions = packages?.exclusions;
    conditions = packages?.conditions;
    shuttle = packages?.shuttle;
    meetingPoint = packages?.meetingPoint;
    meetingPointLatitude = packages?.meetingPointLatitude;
    meetingPointLongitude = packages?.meetingPointLongitude;
    schedule = packages?.schedule;
    childInfo = TourPackageChildInfo.mapFromTourChildInfo(packages?.childInfo);
  }

  bool isNotEmpty() =>
      inclusions != null &&
          inclusions!.all != null &&
          inclusions!.all!.isNotEmpty ||
      exclusions != null && exclusions!.isNotEmpty ||
      conditions != null && conditions!.isNotEmpty ||
      schedule != null && schedule!.isNotEmpty ||
      meetingPoint != null && meetingPoint!.isNotEmpty ||
      shuttle != null && shuttle!.isNotEmpty ||
      cancellationPolicy != null && cancellationPolicy!.isNotEmpty;
}

class TourPackageInclusions {
  List<TourPackageHighlight>? highlights;
  String? all;

  TourPackageInclusions.mapFromTourInclusions(Inclusions? inclusions) {
    all = inclusions?.all;
    highlights = List.generate(
        inclusions?.highlights?.length ?? 0,
        (index) => TourPackageHighlight.mapFromTourHighlight(
            inclusions?.highlights?.elementAt(index)));
  }
}

class TourPackageChildInfo {
  int? minAge;
  int? maxAge;

  TourPackageChildInfo.mapFromTourChildInfo(ChildInfo? childInfo) {
    maxAge = childInfo?.minAge;
    maxAge = childInfo?.maxAge;
  }
}

class TourPackageHighlight {
  String? key;
  String? value;

  TourPackageHighlight.mapFromTourHighlight(Highlight? highlight) {
    if (highlight?.key != null && highlight?.value != null) {
      key = highlight?.key;
      value = highlight?.value;
    }
  }
}
