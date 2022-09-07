import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_model_domain.dart';

class TicketBookingPackageDetailViewModel {
  String? packageName;
  TicketBookingInclusions? inclusions;
  String? cancellationPolicy;
  String? durationText;
  String? exclusions;
  String? conditions;
  String? shuttle;
  String? meetingPoint;
  String? meetingPointLatitude;
  String? meetingPointLongitude;
  String? schedule;

  TicketBookingPackageDetailViewModel.mapFromTicketPackage(
      PackageDetail? packages) {
    packageName = packages?.packageName;
    inclusions =
        TicketBookingInclusions.mapFromTicketInclusions(packages?.inclusions);
    cancellationPolicy = packages?.cancellationPolicy;
    durationText = packages?.durationText;
    exclusions = packages?.exclusions;
    conditions = packages?.conditions;
    shuttle = packages?.shuttle;
    meetingPoint = packages?.meetingPoint;
    meetingPointLatitude = packages?.meetingPointLatitude;
    meetingPointLongitude = packages?.meetingPointLongitude;
    schedule = packages?.schedule;
  }

  bool isNotEmpty() =>
      inclusions != null &&
          inclusions!.all != null &&
          inclusions!.all!.isNotEmpty ||
      exclusions != null && exclusions!.isNotEmpty ||
      conditions != null && conditions!.isNotEmpty ||
      cancellationPolicy != null && cancellationPolicy!.isNotEmpty;
}

class TicketBookingInclusions {
  List<TicketBookingHighlight>? highlights;
  String? all;

  TicketBookingInclusions.mapFromTicketInclusions(Inclusions? inclusions) {
    all = inclusions?.all;
    highlights = List.generate(
        inclusions?.highlights?.length ?? 0,
        (index) => TicketBookingHighlight.mapFromTicketHighlight(
            inclusions?.highlights?.elementAt(index)));
  }
}

class TicketBookingHighlight {
  String? key;
  String? value;

  TicketBookingHighlight.mapFromTicketHighlight(Highlight? highlight) {
    if (highlight?.key != null && highlight?.value != null) {
      key = highlight?.key;
      value = highlight?.value;
    }
  }
}
