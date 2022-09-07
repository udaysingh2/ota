import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/tickets/details/helper/ticket_detail_helper.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/package_details/view_model/ticket_package_detail_view_model.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

class TicketDetailViewModel {
  TicketDetailModel? data;
  TicketDetailScreenPageState pageState;
  TicketDetailViewModel({
    required this.pageState,
    this.data,
  });
}

class TicketDetailModel {
  String? ticketId;
  String? name;
  String? imageUrl;
  String? locationName;
  String? categoryName;
  TicketInformation? information;
  List<TicketPackage>? packages;
  List<OtaFreeFoodPromotionModel> promotionData = [];

  ///Constructor That is used to map from the Domain level Model.
  TicketDetailModel.mapFromTicketDetail(Ticket ticketDetail,
      TicketDetailArgument? argument, List<TicketDetailPromotionList> list) {
    ticketId = ticketDetail.id;
    name = ticketDetail.name;
    imageUrl = ticketDetail.image;
    categoryName = ticketDetail.category;
    locationName = ticketDetail.location;
    information =
        TicketInformation.mapFromTicketInformation(ticketDetail.information);
    packages = List.generate(
      ticketDetail.packages?.length ?? 0,
      (index) => TicketPackage.mapFromTicketPackage(
          ticketDetail.packages?.elementAt(index), argument),
    );
    promotionData = TicketDetailHelper.generatePromotion(list);
  }
}

enum TicketDetailScreenPageState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
  internetFailure,
}

class TicketInformation {
  String? description;
  String? conditions;
  String? howToUse;
  String? providerName;
  String? openTime;
  String? closeTime;
  TicketInformation.mapFromTicketInformation(Information? information) {
    description = information?.description;
    conditions = information?.conditions;
    howToUse = information?.howToUse;
    providerName = information?.providerName;
    openTime = information?.openTime;
    closeTime = information?.closeTime;
  }
}

class TicketPackage {
  TicketPackageDetail? packageDetail;
  TicketPackageDetailViewModel? packageScreen;

  TicketPackage({this.packageDetail, this.packageScreen});

  TicketPackage.mapFromTicketPackage(
      Package? packages, TicketDetailArgument? argument) {
    packageDetail = TicketPackageDetail.mapFromTicketPackage(packages);
    packageScreen =
        TicketPackageDetailViewModel.mapFromTicketPackage(packages, argument);
  }
}

class TicketPackageDetail {
  String? name;
  List<TicketHighlight>? highlights;
  double? totalPrice;
  List<TicketTypeData>? ticketTypes;
  String? currency;
  String? rateKey;
  String? refCode;
  String? serviceId;
  String? zoneId;
  String? timeOfDay;
  String? startTime;
  String? serviceType;
  int? availableSeats;

  TicketPackageDetail({
    this.name,
    this.highlights,
    this.totalPrice,
    this.currency,
    this.ticketTypes,
    this.rateKey,
    this.refCode,
    this.serviceId,
    this.zoneId,
    this.timeOfDay,
    this.startTime,
    this.serviceType,
    this.availableSeats,
  });

  TicketPackageDetail.mapFromTicketPackage(Package? packages) {
    name = packages?.name;
    highlights = TicketInclusions.mapFromTicketInclusions(packages?.inclusions)
        .highlights;
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
    currency = packages?.currency;
    rateKey = packages?.rateKey;
    refCode = packages?.refCode;
    serviceId = packages?.serviceId;
    zoneId = packages?.zoneId;
    timeOfDay = packages?.timeOfDay;
    startTime = packages?.startTime;
    serviceType = packages?.serviceType;
    availableSeats = packages?.availableSeats;
  }
}

class TicketTypeData {
  String? paxId;
  String? name;
  double? price;
  int? minimum;
  int? available;
  TicketTypeData({
    this.paxId,
    this.name,
    this.price,
    this.minimum,
    this.available,
  });
  TicketTypeData.mapFromTicketType(TicketType? ticketType) {
    paxId = ticketType?.paxId;
    name = ticketType?.name;
    price = ticketType?.price;
    minimum = ticketType?.minimum;
    available = ticketType?.available;
  }
}
