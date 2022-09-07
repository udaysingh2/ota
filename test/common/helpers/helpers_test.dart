import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/common/helpers/print_helper.dart';

class MockedBuildContext extends Mock implements BuildContext {}

void main() {
  test("Helpers test", () {
    expect(printDebug("test"), null);
    expect(printWarning("test"), null);
    expect(printError("test"), null);
  });
}
