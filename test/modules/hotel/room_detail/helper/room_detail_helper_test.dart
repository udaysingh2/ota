import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/modules/hotel/room_detail/helper/room_detail_helper.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext mockContext = MockBuildContext();

  test('For class RoomDetailHelper > generateCancellationPolicy() test', () {
    final list = RoomDetailHelper.generateCancellationPolicy(
      getList(),
    );

    expect(list?.isNotEmpty, true);
  });

  test('For class RoomDetailHelper > generateRoomCategory() test', () {
    final list = RoomDetailHelper.generateRoomCategory(
      [
        RoomCategory(
            roomType: 'roomType',
            noOfRooms: 2,
            roomName: 'Deluxe',
            noOfRoomsAndName: 'Double bed'),
      ],
    );

    expect(list?.isNotEmpty, true);
  });

  test('For class RoomDetailHelper > generateFacilityList() test', () {
    final list = RoomDetailHelper.generateFacilityList([
      Facility(key: 'DOUBLE_BED_FLAG', value: 'Y'),
    ]);

    expect(list.length, 0);
  });

  group('For For class RoomDetailHelper > getName() group test', () {
    test('For getName() > If PAYMENT then test', () {
      final string =
          RoomDetailHelper.getName(FacilityModel('PAYMENT', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If BREAKFAST then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('BREAKFAST', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If WIFI then test', () {
      final string =
          RoomDetailHelper.getName(FacilityModel('WIFI', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If NON_SMOKING then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('NON_SMOKING', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If MAX_PAX_NBR then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('MAX_PAX_NBR', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DIMENSION then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('DIMENSION', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('DOUBLE_BED_FLAG', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If TWIN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('TWIN_BED_FLAG', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If QUEEN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('QUEEN_BED_FLAG', 'Y'), mockContext);

      expect(string.isEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('DOUBLE_QUEEN_BED_FLAG', 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_TWIN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('DOUBLE_TWIN_BED_FLAG', 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If QUEEN_TWIN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('QUEEN_TWIN_BED_FLAG', 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });

    test('For getName() > If DOUBLE_QUEEN_TWIN_BED_FLAG then test', () {
      final string = RoomDetailHelper.getName(
          FacilityModel('DOUBLE_QUEEN_TWIN_BED_FLAG', 'Y'), mockContext);

      expect(string.isNotEmpty, true);
    });
  });

  group('For For class RoomDetailHelper > getSvgIcon() group test', () {
    test('For getName() > If PAYMENT then test', () {
      expect(RoomDetailHelper.getSvgIcon("PAYMENT"),
          "assets/images/icons/price.svg");
      expect(
          RoomDetailHelper.getSvgIcon("WIFI"), "assets/images/icons/wifi.svg");
      expect(RoomDetailHelper.getSvgIcon("NON_SMOKING"),
          "assets/images/icons/close.svg");
      expect(RoomDetailHelper.getSvgIcon("MAX_PAX_NBR"),
          "assets/images/icons/users_alt.svg");
      expect(RoomDetailHelper.getSvgIcon("DIMENSION"),
          "assets/images/icons/uil_arrows_shrink.svg");
    });
  });
}

List<CancellationPolicy>? getList() => [
      CancellationPolicy(
        days: 1,
        cancellationDaysDescription: 'cancellationDaysDescription',
        cancellationChargeDescription: 'cancellationChargeDescription',
        cancellationStatus: 'cancellationStatus',
      ),
    ];
