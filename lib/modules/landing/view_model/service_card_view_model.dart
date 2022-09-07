class ServiceViewModel {
  final String serviceText;
  final String title;
  final String description;
  final String imageUrl;
  final String largeImageUrl;
  final String serviceBackgroundUrl;
  final int? sortSequence;
  final String service;
  final String deepLinkUrl;

  ServiceViewModel({
    this.serviceText = "",
    this.title = "",
    this.description = "",
    this.imageUrl = "",
    this.largeImageUrl = "",
    this.serviceBackgroundUrl = "",
    this.sortSequence,
    this.service = "",
    this.deepLinkUrl = "",
  });
}

enum ServiceViewModelService {
  insurance,
  hotel,
  tour,
  carRental,
  unknown,
}

extension ServiceViewModelServiceExtension on ServiceViewModelService {
  String inString() {
    switch (this) {
      case ServiceViewModelService.hotel:
        return "HOTEL";
      case ServiceViewModelService.tour:
        return "TOUR";
      case ServiceViewModelService.insurance:
        return "INSURANCE";
      case ServiceViewModelService.carRental:
        return "CARRENTAL";
      case ServiceViewModelService.unknown:
        return "";
    }
  }

  static ServiceViewModelService fromString(String? service) {
    if (service == null) return ServiceViewModelService.unknown;
    switch (service) {
      case "HOTEL":
        return ServiceViewModelService.hotel;
      case "TOUR":
        return ServiceViewModelService.tour;
      case "INSURANCE":
        return ServiceViewModelService.insurance;
      case "CARRENTAL":
        return ServiceViewModelService.carRental;
      default:
        return ServiceViewModelService.unknown;
    }
  }

  String placeeholderImage() {
    switch (this) {
      case ServiceViewModelService.carRental:
        return "assets/images/icons/car_service_card_placeholder.svg";
      case ServiceViewModelService.hotel:
      case ServiceViewModelService.tour:
      case ServiceViewModelService.insurance:
      case ServiceViewModelService.unknown:
        return "assets/images/icons/service_card_placeholder.svg";
    }
  }
}
