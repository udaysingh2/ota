import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_model.dart';

void main() {
  test("OTA cupertino model test", () {
    OtaCupertinoModel otaCupertinoModel = OtaCupertinoModel(
        index: 0,
        dropOfHour: 10,
        dropOfMinute: 00,
        selectedDropOfHour: 11,
        selectedDropOfMinute: 15,
        pickUpHour: 10,
        pickUpMinute: 00,
        selectedPickUpHour: 12,
        selectedPickUpMinute: 30,
        pickUpTime: const TimeOfDay(hour: 10, minute: 00),
        dropOffTime: const TimeOfDay(hour: 10, minute: 00));

    expect(otaCupertinoModel.index, 0);
    expect(otaCupertinoModel.dropOfHour, 10);
    expect(otaCupertinoModel.dropOfMinute, 00);
    expect(otaCupertinoModel.selectedDropOfHour, 11);
    expect(otaCupertinoModel.selectedDropOfMinute, 15);
    expect(otaCupertinoModel.pickUpHour, 10);
    expect(otaCupertinoModel.pickUpMinute, 00);
    expect(otaCupertinoModel.selectedPickUpHour, 12);
    expect(otaCupertinoModel.selectedPickUpMinute, 30);
    expect(otaCupertinoModel.pickUpTime, const TimeOfDay(hour: 10, minute: 00));
    expect(
        otaCupertinoModel.dropOffTime, const TimeOfDay(hour: 10, minute: 00));
  });
}
