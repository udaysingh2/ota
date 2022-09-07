import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';

void main() {
  test('Filter ota argument model test', () {
    FilterOtaArgumentModel filterOtaArgumentModel = FilterOtaArgumentModel(
      initialFilterOtaArgumentData: FilterOtaArgumentData(
          listOfSortString: [],
          maximumPrice: 100,
          rangeEndingPrice: 80,
          rangeStaringPrice: 20,
          starRating: {2},
          startingPrice: 15),
      onSearchClicked: (updatedFilterOtaArgumentData) {},
    );
    filterOtaArgumentModel.initialFilterOtaArgumentData!.reset();
    expect(
        filterOtaArgumentModel.initialFilterOtaArgumentData!.listOfSortString,
        null);
    expect(
        filterOtaArgumentModel.initialFilterOtaArgumentData!.maximumPrice, 100);
    filterOtaArgumentModel.initialFilterOtaArgumentData!.getSelectedSortMode();
  });
  test('Filter ota argument model test', () {
    SortingDataArgument sortingDataArgument = SortingDataArgument(
        id: 'id', isSelected: true, stringValue: "reccomends");
    expect(sortingDataArgument.id, "id");
    expect(sortingDataArgument.isSelected, true);
    expect(sortingDataArgument.stringValue, "reccomends");
    sortingDataArgument.isSelected = false;
  });
  test('Filter ota argument model test', () {
    FilterOtaArgumentData filterOtaArgumentData = FilterOtaArgumentData();
    filterOtaArgumentData.copy();
  });
}
