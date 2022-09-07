import 'package:ota/core/app_config.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';

class HotelServiceViewModel {
  List<AddonServiceViewModel> addonServiceList;
  HotelServiceViewModelState addonServiceState;

  HotelServiceViewModel({
    required this.addonServiceList,
    this.addonServiceState = HotelServiceViewModelState.none,
  });
}

class AddonServiceViewModel {
  final String serviceId;
  final String serviceName;
  final String currency;
  final double price;
  final String imageUrl;
  final bool isFlight;
  final String description;
  final int? noOfAdults;

  AddonServiceViewModel({
    required this.serviceId,
    required this.serviceName,
    required this.currency,
    required this.price,
    required this.imageUrl,
    required this.isFlight,
    required this.description,
    this.noOfAdults,
  });

  factory AddonServiceViewModel.fromHotelEnhancement(
      HotelEnhancement hotelEnhancement) {
    return AddonServiceViewModel(
      serviceId: hotelEnhancement.hotelEnhancementId ?? '',
      serviceName: hotelEnhancement.hotelEnhancementName ?? '',
      currency: hotelEnhancement.currency ?? AppConfig().currency,
      price: hotelEnhancement.price != null
          ? double.tryParse(hotelEnhancement.price!) ?? -1
          : -1,
      imageUrl: hotelEnhancement.image ?? '',
      isFlight: hotelEnhancement.isFlight ?? false,
      description: hotelEnhancement.description ?? '',
    );
  }
}

enum HotelServiceViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
}
