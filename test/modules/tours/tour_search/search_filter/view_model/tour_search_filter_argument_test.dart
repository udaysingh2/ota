import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

void main() {
  test('tour search filter argument', () {
    TourSearchFilterArgument argument = TourSearchFilterArgument(
      serviceType: TourSearchServiceType.tour,
      filterData: TourFilterDataViewModel(
        styleList: ["styleName1","styleName2"],
        minPrice: 10.00,
        maxPrice: 100.00
      )
    );
    TourSearchFilterArgument argument1 = TourSearchFilterArgument(
        serviceType: TourSearchServiceType.tickets,
        filterData: TourFilterDataViewModel.mapFromDomain(
            Filter(maxPrice: 10.00,minPrice: 100.00,styleName: ["styleName1","styleName2"])
        )
    );
    expect(argument.serviceType, TourSearchServiceType.tour);
    expect(argument1.serviceType, TourSearchServiceType.tickets);
  });
}