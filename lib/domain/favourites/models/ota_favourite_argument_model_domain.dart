import 'package:ota/domain/search/models/ota_search_argument.dart';

class OtaFavoritesArgumentDomainModel {
  String serviceName;
  TourDetailDomain? tourDetail;
  TicketDetailDomain? ticketDetail;
  OtaFavoritesArgumentDomainModel({
    required this.serviceName,
    this.tourDetail,
    this.ticketDetail,
  });
  Map<String, dynamic> toMap() => {
        "serviceName": serviceName.addQuote(),
        if (tourDetail != null) "tourDetail": tourDetail!.toMap(),
        if (ticketDetail != null) "ticketDetail": ticketDetail!.toMap(),
      };
}

class TourDetailDomain {
  String serviceId;
  String cityId;
  String countryId;
  String name;
  String? image;
  String? location;
  String? category;
  TourDetailDomain({
    required this.serviceId,
    required this.cityId,
    required this.countryId,
    required this.name,
    this.image,
    this.location,
    this.category,
  });
  Map<String, dynamic> toMap() => {
        "id": serviceId.addQuote(),
        "name": name.addQuote(),
        "cityId": cityId.addQuote(),
        "countryId": countryId.addQuote(),
        if (image != null) "image": image!.addQuote(),
        if (location != null) "location": location!.addQuote(),
        if (category != null) "category": category!.addQuote(),
      };
}

class TicketDetailDomain {
  String serviceId;
  String cityId;
  String countryId;
  String name;
  String? image;
  String? location;
  String? category;
  TicketDetailDomain({
    required this.serviceId,
    required this.cityId,
    required this.countryId,
    required this.name,
    this.image,
    this.location,
    this.category,
  });
  Map<String, dynamic> toMap() => {
        "id": serviceId.addQuote(),
        "name": name.addQuote(),
        "cityId": cityId.addQuote(),
        "countryId": countryId.addQuote(),
        if (image != null) "image": image!.addQuote(),
        if (location != null) "location": location!.addQuote(),
        if (category != null) "category": category!.addQuote(),
      };
}
