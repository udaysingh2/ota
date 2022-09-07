import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/queries/queries_preference_popup.dart';

void main() {
  test('OTA Queries Filter Sort ...', () async {
    String str = QueriesPreferencePopup.getPopUpState("id", "type", "endDate");
    expect(str.isEmpty, false);
  });
}
