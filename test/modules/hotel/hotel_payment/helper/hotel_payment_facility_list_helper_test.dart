import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/domain/confirm_booking/models/booking_confirmation_data_model.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/hotel_payment_facility_list_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_room_view_model.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext mockContext = MockBuildContext();

  test('For class HotelPaymentFacilityListHelper > getFacility() test', () {
    final list = HotelPaymentFacilityListHelper.getFacility([
      Facility(key: 'DOUBLE_BED_FLAG', value: 'Y'),
    ]);

    expect(list.length, 0);
  });

  group('For For class HotelPaymentFacilityListHelper > getName() group test',
      () {
    test('For getName() > If PAYMENT then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'PAYMENT', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If BREAKFAST then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'BREAKFAST', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If WIFI then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'WIFI', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If NON_SMOKING then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'NON_SMOKING', value: 'Y'),
          mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If MAX_PAX_NBR then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'MAX_PAX_NBR', value: 'Y'),
          mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DIMENSION then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'DIMENSION', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_BED_FLAG then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'DOUBLE_BED_FLAG', value: 'Y'),
          mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If TWIN_BED_FLAG then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'TWIN_BED_FLAG', value: 'Y'),
          mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If QUEEN_BED_FLAG then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'QUEEN_BED_FLAG', value: 'Y'),
          mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'DOUBLE_QUEEN', value: 'Y'),
          mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_TWIN then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'DOUBLE_TWIN', value: 'Y'),
          mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If QUEEN_TWIN then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'QUEEN_TWIN', value: 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN_TWIN then test', () {
      final string = HotelPaymentFacilityListHelper.getName(
          HotelPaymentFacilityList(key: 'DOUBLE_QUEEN_TWIN', value: 'Y'),
          mockContext);

      expect(string.isNotEmpty, true);
    });
  });

  group('For For class RoomDetailHelper > getSvgIcon() group test', () {
    test('For getName() > If PAYMENT then test', () {
      expect(HotelPaymentFacilityListHelper.getSvgIcon("PAYMENT"),
          "assets/images/icons/price.svg");
      expect(HotelPaymentFacilityListHelper.getSvgIcon("WIFI"),
          "assets/images/icons/wifi.svg");
      expect(HotelPaymentFacilityListHelper.getSvgIcon("NON_SMOKING"),
          "assets/images/icons/close.svg");
      expect(HotelPaymentFacilityListHelper.getSvgIcon("MAX_PAX_NBR"),
          "assets/images/icons/users_alt.svg");
      expect(HotelPaymentFacilityListHelper.getSvgIcon("DIMENSION"),
          "assets/images/icons/uil_arrows_shrink.svg");
    });
  });
}
