import 'package:ota/common/utils/helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/helpers/hotel_addon_service_helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

class HotelServiceViewArgument {
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final String currency;
  final List<AddonServiceModel> selectedAddons;
  final Function(AddonServiceViewModel)? onUpdate;
  final int noOfAdults;

  HotelServiceViewArgument({
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.currency,
    required this.selectedAddons,
    this.onUpdate,
    required this.noOfAdults,
  });

  factory HotelServiceViewArgument.from(
    String hotelId,
    DateTime checkInDate,
    DateTime checkOutDate,
    String currency,
    int noOfAdults,
    List<AddonsModel> addonsModels,
    Function(AddonServiceViewModel)? onUpdate,
  ) {
    return HotelServiceViewArgument(
      hotelId: hotelId,
      checkInDate: Helpers.getYYYYmmddFromDateTime(checkInDate),
      checkOutDate: Helpers.getYYYYmmddFromDateTime(checkOutDate),
      currency: currency,
      selectedAddons:
          HotelAddonServiceHelper.getAddonServiceModelList(addonsModels),
      onUpdate: onUpdate,
      noOfAdults: noOfAdults,
    );
  }

  factory HotelServiceViewArgument.getDummy() {
    return HotelServiceViewArgument(
      hotelId: 'MA0711050518',
      checkInDate: '2021-10-24',
      checkOutDate: '2021-10-25',
      currency: 'TBH',
      selectedAddons: [],
      noOfAdults: 1,
    );
  }
}

class AddonServiceModel {
  final String serviceId;
  final DateTime selectedDate;

  AddonServiceModel({
    required this.serviceId,
    required this.selectedDate,
  });

  factory AddonServiceModel.fromAddonsModel(AddonsModel addonsModel) {
    return AddonServiceModel(
      serviceId: addonsModel.uniqueId,
      selectedDate: addonsModel.selectedDate ?? DateTime.now(),
    );
  }
}
