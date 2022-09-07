import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/platform_specifics_helper.dart';

void main() {
  test("PlatForm Specifics Helper Test", () async {
    await PlatformSpecificsHelper.checkForMaterialYou();
    final useMaterialYouUi = PlatformSpecificsHelper.useMaterialYouUi;
    // ignore: deprecated_member_use
    expect(useMaterialYouUi, false);
  });
}
