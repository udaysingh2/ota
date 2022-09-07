import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

class TourSearchFilterArgument {
  TourSearchServiceType serviceType;
  TourSearchFilterData? ticketModel;
  TourSearchFilterData? tourModel;
  TourFilterDataViewModel? filterData;

  TourSearchFilterArgument({
    required this.serviceType,
    this.ticketModel,
    this.tourModel,
    this.filterData,
  });
}

class TourFilterDataViewModel {
  double? minPrice;
  double? maxPrice;
  List<String>? styleList;
  TourFilterDataViewModel({
    this.maxPrice,
    this.minPrice,
    this.styleList,
  });

  factory TourFilterDataViewModel.mapFromDomain(Filter filter) =>
      TourFilterDataViewModel(
        maxPrice: filter.maxPrice,
        minPrice: filter.minPrice,
        styleList: filter.styleName,
      );
}
