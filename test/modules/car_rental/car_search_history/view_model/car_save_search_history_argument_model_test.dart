import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

void main() {
  Item item = Item();
  test('car save search argument model test ...', () async {
    final paymentMethodArgumentModel =
        CarSaveSearchHistoryViewArgumentModel.from(
            item: item, serviceType: "serviceType");

    expect(paymentMethodArgumentModel.searchKey, item.keyword);
    expect(paymentMethodArgumentModel.cityId, item.cityId);
    expect(paymentMethodArgumentModel.countryId, item.countryId);
    expect(paymentMethodArgumentModel.locationId, item.locationName);
  });
}
