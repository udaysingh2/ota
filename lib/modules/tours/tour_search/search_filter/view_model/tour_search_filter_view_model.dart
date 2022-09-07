import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search_filter/helper/tour_filter_helper.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';

class TourSearchFilterViewModel {
  TourSearchFilterPageState pageState;
  final TourSearchFilterData? data;
  final TourSearchServiceType? serviceType;

  TourSearchFilterViewModel({
    required this.pageState,
    this.data,
    this.serviceType,
  });
}

class TourSearchFilterData {
  final List<TourFilterCategoryViewModel>? sortInfo;
  final List<TourFilterCategoryViewModel>? categoryInfo;
  final double? minPrice;
  final double? maxPrice;
  double? rangeMinPrice;
  double? rangeMaxPrice;
  TourFilterCategoryViewModel? selectedSortInfo;
  final List<TourStyleViewModel>? styleList;

  TourSearchFilterData({
    this.sortInfo,
    this.categoryInfo,
    this.minPrice,
    this.maxPrice,
    this.rangeMinPrice,
    this.rangeMaxPrice,
    this.selectedSortInfo,
    this.styleList,
  });

  factory TourSearchFilterData.mapScreenData({
    required TourFilterDataViewModel? argument,
    required TourSearchFilterModelDomain filterModel,
  }) =>
      TourSearchFilterData(
          sortInfo: TourFilterHelper.getFilterViewModel(
              filterModel.getSortCriteria?.data?.sortInfo),
          categoryInfo: TourFilterHelper.getFilterViewModel(
              filterModel.getSortCriteria?.data?.criteria),
          maxPrice: argument?.maxPrice,
          rangeMaxPrice: argument?.maxPrice,
          minPrice: argument?.minPrice,
          rangeMinPrice: argument?.minPrice,
          styleList: TourFilterHelper.getStyleList(argument?.styleList),
          selectedSortInfo: TourFilterHelper.getSelectedSortInfo(
              filterModel.getSortCriteria?.data?.sortInfo));
}

class TourFilterCategoryViewModel {
  final String displayTitle;
  final int sortSeq;
  final String categoryKey;
  final String? description;

  TourFilterCategoryViewModel({
    required this.displayTitle,
    required this.sortSeq,
    required this.categoryKey,
    this.description,
  });

  factory TourFilterCategoryViewModel.mapFromCriterion(Criterion criterion) =>
      TourFilterCategoryViewModel(
        categoryKey: criterion.value!,
        displayTitle: criterion.displayTitle!,
        sortSeq: criterion.sortSeq!,
        description: criterion.description,
      );
}

class TourStyleViewModel {
  final String styleName;
  bool isSelected;

  TourStyleViewModel({
    required this.styleName,
    this.isSelected = false,
  });

  factory TourStyleViewModel.createFromString(String style) =>
      TourStyleViewModel(styleName: style);
}

enum TourSearchFilterPageState {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}

enum TourSearchServiceType { tour, tickets }
