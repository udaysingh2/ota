import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/helpers/hotel_addon_service_helper.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

void main() {
  List<HotelEnhancement> hotelEnhancementList = [
    HotelEnhancement(
      hotelEnhancementId: '279',
      hotelEnhancementName: 'Golf Course',
      currency: 'THB',
      price: '2100',
      image: '',
      isFlight: false,
      description:
          'Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0)',
    ),
    HotelEnhancement(
      hotelEnhancementId: '280',
      hotelEnhancementName: 'Golf Course',
      currency: 'THB',
      price: '2100',
      image: '',
      isFlight: false,
      description:
          'Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0)',
    ),
  ];

  List<AddonsModel> addonsModelList = [
    AddonsModel(
        cost: "200",
        imageUrl: '',
        quantity: "",
        isFlight: false,
        serviceName: "serviceName 1"),
    AddonsModel(
        cost: "250",
        imageUrl: '',
        quantity: "",
        isFlight: false,
        serviceName: "serviceName 2"),
  ];

  List<AddonServiceModel> addonServiceModelList = [
    AddonServiceModel(
      serviceId: '1211',
      selectedDate: DateTime.now(),
    ),
    AddonServiceModel(
      serviceId: '1213',
      selectedDate: DateTime.now(),
    ),
    AddonServiceModel(
      serviceId: '1215',
      selectedDate: DateTime.now(),
    ),
  ];

  test("Hotel addon Helper with no list", () {
    expect(HotelAddonServiceHelper.getAddonServiceViewModelList(null) == null,
        true);
  });

  test("Hotel addon Helper with empty list", () {
    expect(
        HotelAddonServiceHelper.getAddonServiceViewModelList([]) == null, true);
  });

  test("Hotel addon Helper with list", () {
    expect(
        HotelAddonServiceHelper.getAddonServiceViewModelList(
                hotelEnhancementList) !=
            null,
        true);
  });

  test("Hotel addon Helper with no AddonsModel list", () {
    expect(
        HotelAddonServiceHelper.getAddonServiceModelList(null).isEmpty, true);
  });

  test("Hotel addon Helper with empty AddonsModel list", () {
    expect(HotelAddonServiceHelper.getAddonServiceModelList([]).isEmpty, true);
  });

  test("Hotel addon Helper with AddonsModel list", () {
    expect(
        HotelAddonServiceHelper.getAddonServiceModelList(addonsModelList)
            .isNotEmpty,
        true);
  });

  test("Hotel addon Helper with getSelectedDatesOfService", () {
    expect(
        HotelAddonServiceHelper.getSelectedDatesOfService(
                addonServiceModelList, "1211")
            .isNotEmpty,
        true);
  });

  test("Hotel addon Helper with getSelectedDatesOfService no service id", () {
    expect(
        HotelAddonServiceHelper.getSelectedDatesOfService(
                addonServiceModelList, '')
            .isEmpty,
        true);
  });

  test("Hotel addon Helper with getSelectedDatesOfService", () {
    expect(
        HotelAddonServiceHelper.getSelectedDatesOfService(
                addonServiceModelList, "12")
            .isEmpty,
        true);
  });

  // static List<DateTime> getSelectedDatesOfService(
  //     List<AddonServiceModel> selectedAddons, String serviceId) {
  //   List<DateTime> selectedDates = [];
  //   for (AddonServiceModel addonService in selectedAddons) {
  //     if (addonService.serviceId == serviceId)
  //       selectedDates.add(addonService.selectedDate);
  //   }
  //   return selectedDates;
  // }
}
