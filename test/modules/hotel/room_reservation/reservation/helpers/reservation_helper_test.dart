import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/domain/hotel/booking_initiate/models/booking_data_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/helpers/reservation_helper.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext mockContext = MockBuildContext();

  test('For class ReservationHelper > getFacilityListHelper(null) test', () {
    final list = ReservationHelper.getFacilityListHelper(null);

    expect(list.length, 0);
  });

  test('For class ReservationHelper > getFacilityListHelper() test', () {
    final list = ReservationHelper.getFacilityListHelper([
      Facility(key: 'DOUBLE_BED_FLAG', value: 'Y'),
    ]);

    expect(list.length, 0);
  });

  group('For For class ReservationHelper > getName() group test', () {
    test('For getName() > If PAYMENT then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'PAYMENT', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If BREAKFAST then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'BREAKFAST', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If WIFI then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'WIFI', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If NON_SMOKING then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'NON_SMOKING', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If MAX_PAX_NBR then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'MAX_PAX_NBR', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DIMENSION then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'DIMENSION', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_BED_FLAG then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'DOUBLE_BED_FLAG', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If TWIN_BED_FLAG then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'TWIN_BED_FLAG', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If QUEEN_BED_FLAG then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'QUEEN_BED_FLAG', value: 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'DOUBLE_QUEEN', value: 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_TWIN then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'DOUBLE_TWIN', value: 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If QUEEN_TWIN then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'QUEEN_TWIN', value: 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN_TWIN then test', () {
      final string = ReservationHelper.getName(
          FacilityList(key: 'DOUBLE_QUEEN_TWIN', value: 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });
  });

  group('For For class ReservationHelper > getSvgIcon() group test', () {
    test('For getName() > If PAYMENT then test', () {
      expect(ReservationHelper.getSvgIcon("PAYMENT"),
          "assets/images/icons/price.svg");
      expect(
          ReservationHelper.getSvgIcon("WIFI"), "assets/images/icons/wifi.svg");
      expect(ReservationHelper.getSvgIcon("NON_SMOKING"),
          "assets/images/icons/close.svg");
      expect(ReservationHelper.getSvgIcon("MAX_PAX_NBR"),
          "assets/images/icons/users_alt.svg");
      expect(ReservationHelper.getSvgIcon("DIMENSION"),
          "assets/images/icons/uil_arrows_shrink.svg");
    });
  });
}
