import 'package:ota/domain/favourites/models/ota_favourite_argument_model_domain.dart';

class OtaFavoritesArgumentModel {
  String serviceName;
  TourDetail? tourDetail;
  TicketDetail? ticketDetail;
  OtaFavoritesArgumentModel({
    required this.serviceName,
    this.tourDetail,
    this.ticketDetail,
  });

  OtaFavoritesArgumentDomainModel toFavoritesArgumentDomainModel() {
    return OtaFavoritesArgumentDomainModel(
        serviceName: serviceName,
        tourDetail: tourDetail?.toTourDetailDomain(),
        ticketDetail: ticketDetail?.toTicketDetailDomain());
  }
}

class TourDetail {
  String serviceId;
  String cityId;
  String countryId;
  String name;
  String? image;
  String? location;
  String? category;
  TourDetail({
    required this.serviceId,
    required this.cityId,
    required this.countryId,
    required this.name,
     this.image,
     this.location,
     this.category,
  });
  TourDetailDomain toTourDetailDomain() {
    return TourDetailDomain(
        serviceId: serviceId,
        name: name,
        image: image,
        cityId: cityId,
        countryId: countryId,
        location: location,
        category: category);
  }
}

class TicketDetail {
  String serviceId;
  String cityId;
  String countryId;
  String name;
  String? image;
  String? location;
  String? category;
  TicketDetail({
    required this.serviceId,
    required this.cityId,
    required this.countryId,
    required this.name,
    this.image,
    this.location,
    this.category,
  });
  TicketDetailDomain toTicketDetailDomain() {
    return TicketDetailDomain(
        serviceId: serviceId,
        name: name,
        image: image,
        cityId: cityId,
        countryId: countryId,
        location: location,
        category: category);
  }
}
