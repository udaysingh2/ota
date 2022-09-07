import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

class HotelAddonServiceHelper {
  static List<AddonServiceViewModel>? getAddonServiceViewModelList(
      List<HotelEnhancement>? list) {
    List<AddonServiceViewModel>? addonServiceViewModelList;
    if (list == null || list.isEmpty) return addonServiceViewModelList;

    addonServiceViewModelList = List<AddonServiceViewModel>.generate(
      list.length,
      (index) => AddonServiceViewModel.fromHotelEnhancement(list[index]),
    );

    /// Ignore elements whose serviceId, serviceName & price propery has empty
    /// value and return remaining
    return addonServiceViewModelList
        .where((element) => (element.serviceId.isNotEmpty &&
            element.serviceName.isNotEmpty &&
            element.price != -1))
        .toList();
  }

  static List<AddonServiceModel> getAddonServiceModelList(
      List<AddonsModel>? list) {
    List<AddonServiceModel>? addonServiceModelList;
    if (list == null || list.isEmpty) return addonServiceModelList ?? [];

    addonServiceModelList = List<AddonServiceModel>.generate(
      list.length,
      (index) => AddonServiceModel.fromAddonsModel(list[index]),
    );
    return addonServiceModelList;
  }

  static List<DateTime> getSelectedDatesOfService(
      List<AddonServiceModel> selectedAddons, String serviceId) {
    List<DateTime> selectedDates = [];
    for (AddonServiceModel addonService in selectedAddons) {
      if (addonService.serviceId == serviceId) {
        selectedDates.add(addonService.selectedDate);
      }
    }
    return selectedDates;
  }
}
