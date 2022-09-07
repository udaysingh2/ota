import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';

class TicketPackageDetailViewModel {
  TicketDetailArgument? argument;
  String? name;
  String? exclusions;
  String? schedule;
  String? meetingPoint;
  String? cancellationPolicy;
  String? shuttle;
  double? totalPrice;
  String? currency;
  String? refCode;
  String? serviceId;
  String? zoneId;
  String? rateKey;
  String? allInclusion;
  TicketChildInfo? childInfo;
  String? conditions;
  String? timeOfDay;
  String? startTime;
  String? serviceType;
  int? availableSeats;
  List<TicketTypeData>? ticketTypes;

  TicketPackageDetailViewModel.mapFromTicketPackage(
      Package? packages, this.argument) {
    name = packages?.name;
    exclusions = packages?.exclusions;
    schedule = packages?.schedule;
    meetingPoint = packages?.meetingPoint;
    cancellationPolicy = packages?.cancellationPolicy;
    shuttle = packages?.shuttle;
    currency = packages?.currency;
    refCode = packages?.refCode;
    serviceId = packages?.serviceId;
    zoneId = packages?.zoneId;
    rateKey = packages?.rateKey;
    allInclusion =
        TicketInclusions.mapFromTicketInclusions(packages?.inclusions).all;
    childInfo = TicketChildInfo.mapFromTicketChildInfo(packages?.childInfo);
    conditions = packages?.conditions;
    timeOfDay = packages?.timeOfDay;
    startTime = packages?.startTime;
    serviceType = packages?.serviceType;
    availableSeats = packages?.availableSeats;
    ticketTypes = List.generate(
      packages?.ticketTypes?.length ?? 0,
      (index) => TicketTypeData.mapFromTicketType(
          packages?.ticketTypes?.elementAt(index)),
    );
    if (ticketTypes!.isNotEmpty) {
      totalPrice = ticketTypes!.first.price;
    } else {
      totalPrice = 0;
    }
  }
}

class TicketInclusions {
  List<TicketHighlight>? highlights;
  String? all;
  TicketInclusions.mapFromTicketInclusions(Inclusions? inclusions) {
    all = inclusions?.all;
    highlights = List.generate(
        inclusions?.highlights?.length ?? 0,
        (index) => TicketHighlight.mapFromTicketHighlight(
            inclusions?.highlights?.elementAt(index)));
  }
}

class TicketChildInfo {
  int? minAge;
  int? maxAge;
  String? description;
  TicketChildInfo.mapFromTicketChildInfo(ChildInfo? childInfo) {
    maxAge = childInfo?.minAge;
    maxAge = childInfo?.maxAge;
    description = childInfo?.description;
  }
}

class TicketHighlight {
  String? key;
  String? value;
  TicketHighlight.mapFromTicketHighlight(Highlight? highlight) {
    if (highlight?.key != null && highlight?.value != null) {
      key = highlight?.key;
      value = highlight?.value;
    }
  }
}
