import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_view_model.dart';

void main() {
  test('Filter ota view model test', () {
    FilterOtaViewModel filterOtaViewModel = FilterOtaViewModel(
      listOfSortString: [],
      maximumPrice: 100,
      rangeEndingPrice: 80,
      rangeStaringPrice: 20,
      starRating: {2},
      startingPrice: 15,
      onSearchClicked: (updatedFilterOtaArgumentData) {},
    );

    expect(filterOtaViewModel.listOfSortString, []);
    expect(filterOtaViewModel.maximumPrice, 100);
  });
  test('Filter ota FilterOtaSorting model test', () {
    List<FilterOtaSortingData> filterOtaSortingData = [
      FilterOtaSortingData(
          id: "id", isSelected: true, stringValue: "reccomends")
    ];

    expect(filterOtaSortingData.first.id, "id");
    expect(filterOtaSortingData.first.isSelected, true);
    expect(filterOtaSortingData.first.stringValue, "reccomends");
    FilterOtaSortingData.toSortedArgument(filterOtaSortingData);
  });

  test('Filter ota SortingDataArgument model test', () {
    List<SortingDataArgument> sortList = [
      SortingDataArgument(id: 'id', isSelected: true, stringValue: "reccomends")
    ];
    expect(sortList.first.id, "id");
    FilterOtaSortingData.getFromSortedArgument(sortList);
  });
}
