import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';

class MockedBuildContext extends Mock implements BuildContext {}

void main() {
  test("facility helper", () {
    expect(FacilityHelper.getAssetName("SPA"), "assets/images/icons/spa.svg");
    String text = FacilityHelper.getLocalizedText("SPA", MockedBuildContext());
    bool key = FacilityHelper.keyExist(text);
    expect(text, '');
    expect(key, false);
  });
}
