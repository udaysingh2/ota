import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_view_model.dart';

class HotelSuccessPaymentServiceCardViewModel {
  final String? serviceText;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? largeImageUrl;
  final String? serviceBackgroundUrl;
  final String? service;
  final String? deeplinkUrl;
  HotelSuccessPaymentServiceCardViewModel({
    this.serviceText,
    this.title,
    this.description,
    this.imageUrl,
    this.largeImageUrl,
    this.serviceBackgroundUrl,
    this.service,
    this.deeplinkUrl,
  });

  OtaResrvationServiceCardViewModel toOtaResrvationServiceCardViewModel() {
    return OtaResrvationServiceCardViewModel(
      deeplinkUrl: deeplinkUrl,
      serviceText: serviceText,
      title: title,
      description: description,
      imageUrl: imageUrl,
      largeImageUrl: largeImageUrl,
      serviceBackgroundUrl: serviceBackgroundUrl,
      service: service,
    );
  }
}
