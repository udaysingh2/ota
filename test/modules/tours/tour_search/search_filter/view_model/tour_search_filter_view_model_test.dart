import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

void main() {
  test('tour search filter argument', () {
    TourSearchFilterViewModel argument = TourSearchFilterViewModel(
        pageState: TourSearchFilterPageState.loading,
      serviceType: TourSearchServiceType.tour,
      data: TourSearchFilterData(
        minPrice: 10.00,
        maxPrice: 100.00,
        styleList: [],
          categoryInfo: [TourFilterCategoryViewModel.mapFromCriterion(Criterion(
            value: "criteria_style",
            description: "Can select more than 1 item.",
            displayTitle: "Ticket Style",
            sortSeq: 1
          )
          )],
        rangeMaxPrice: 100.00,
        rangeMinPrice: 10.00,
      )
    );
    TourSearchFilterViewModel argument1 = TourSearchFilterViewModel(
        pageState: TourSearchFilterPageState.loading,
        serviceType: TourSearchServiceType.tickets,
        data: TourSearchFilterData.mapScreenData(
          argument: TourFilterDataViewModel(
          styleList: ["styleName1","styleName2"],
            maxPrice: 100.00,
            minPrice: 10.00
          ),
          filterModel: TourSearchFilterModelDomain(
           getSortCriteria: GetSortCriteria(
             data: Data(
               criteria: [],
               sortInfo: []
             )
           )
          )
        )
    );
    expect(argument.pageState, TourSearchFilterPageState.loading);
    expect(argument1.serviceType, TourSearchServiceType.tickets);
  });
}