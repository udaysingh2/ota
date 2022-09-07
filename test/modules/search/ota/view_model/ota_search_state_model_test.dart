import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_state_model.dart';

void main() {
  test(
    'OTA search state model tests',
    () async {
      OtaSearchStateModel otaSearchStateModel =
          OtaSearchStateModel(pageType: PageType.hotel);

      expect(otaSearchStateModel.pageType == PageType.hotel, true);
    },
  );
}
