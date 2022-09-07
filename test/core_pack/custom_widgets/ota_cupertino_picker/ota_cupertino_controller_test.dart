import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_controller.dart';

void main() {
  OtaCupertinoController otaCupertinoController = OtaCupertinoController();
  group("OTA Cupertino Controller Set items", () {
    test("set Selected index in time picker", () {
      otaCupertinoController.setSelectedIndex(1);
      expect(otaCupertinoController.state.index, 1);
    });
    test("Selected hour and minutes passes to PickUp TimeOfDay", () {
      otaCupertinoController.setSelectedPickUpTimeToDay(05, 30);
      expect(otaCupertinoController.state.pickUpTime,
          const TimeOfDay(hour: 05, minute: 30));
    });
    test("Selected hour and minutes passes to DropOff TimeOfDay", () {
      otaCupertinoController.setSelectedDropOffTimeToDay(08, 00);
      expect(otaCupertinoController.state.dropOffTime,
          const TimeOfDay(hour: 08, minute: 00));
    });

    test("Onchange Hour index in time picker", () {
      otaCupertinoController.setSelectedHourIndex(10);
      expect(otaCupertinoController.state.dropOfHour, 10);
    });
    test("Onchange Minute index in time picker", () {
      otaCupertinoController.setSelectedMinutesIndex(00);
      expect(otaCupertinoController.state.dropOfMinute, 00);
    });

    test(
        "Selected index pass to List of items and fetch the selected value of hour",
        () {
      otaCupertinoController.setSelectHourIndex(7);
      expect(otaCupertinoController.state.selectedDropOfHour, 7);
    });
    test(
        "Selected index pass to List of items and fetch the selected value of minutes",
        () {
      otaCupertinoController.setSelectMinutesIndex(2);
      expect(otaCupertinoController.state.selectedDropOfMinute, 2);
    });
  });

  group("OTA Cupertino Controller get Items", () {
    test("Get selected index value for time sheet item selected", () {
      otaCupertinoController.getSelectedIndex();
      expect(otaCupertinoController.state.index, 1);
    });
    test(
        "Get selected index and fetch the list of item through this selected index in hour",
        () {
      otaCupertinoController.getSelectHourIndex();
      expect(otaCupertinoController.state.dropOfHour, 10);
    });
    test(
        "Get selected index and fetch the list of item through this selected index in minutes",
        () {
      otaCupertinoController.getSelectMinutesIndex();
      expect(otaCupertinoController.state.dropOfMinute, 00);
    });
  });
}
