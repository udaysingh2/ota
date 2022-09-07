import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';

class FilterOtaViewModel {
  FilterOtaViewPageState? filterOtaViewPageState;

  FilterOtaViewModel({
    this.filterOtaViewPageState,
    this.starRating,
    this.listOfSortString,
    this.maximumPrice,
    this.startingPrice,
    this.rangeEndingPrice,
    this.rangeStaringPrice,
    this.onSearchClicked,
    this.promotions = const [],
    this.selectedPromotions,
    this.selectedPromotionsCodeSet,
    this.sha = const [],
    this.selectedSha,
    this.filterCriteriaList = const [],
  });

  List<FilterOtaSortingData>? listOfSortString;
  int? startingPrice;
  int? maximumPrice;
  int? rangeStaringPrice;
  int? rangeEndingPrice;
  Set<int>? starRating;
  List<CapsulePromotions> promotions;
  List<CapsulePromotions>? selectedPromotions;
  Set<String>? selectedPromotionsCodeSet;
  Function(FilterOtaArgumentData updatedFilterOtaArgumentData)? onSearchClicked;
  List<String> sha;
  Set<String>? selectedSha;
  List<FilterCriteriaViewModel>? filterCriteriaList;
}

class FilterCriteriaViewModel {
  final String displayTitle;
  final int sortSeq;
  final String categoryKey;

  FilterCriteriaViewModel({
    required this.displayTitle,
    required this.sortSeq,
    required this.categoryKey,
  });

  factory FilterCriteriaViewModel.mapFromCriterion(Criterion criterion) =>
      FilterCriteriaViewModel(
        categoryKey: criterion.value!,
        displayTitle: criterion.displayTitle!,
        sortSeq: criterion.sortSeq!,
      );
}

class FilterOtaSortingData {
  String? stringValue;
  String? id;
  bool? isSelected;

  FilterOtaSortingData({this.id, this.stringValue, this.isSelected = false});

  FilterOtaSortingData.fromArgument(SortingDataArgument arguments) {
    stringValue = arguments.stringValue;
    id = arguments.id;
    isSelected = arguments.isSelected;
  }

  static List<FilterOtaSortingData> getFromSortedArgument(
      List<SortingDataArgument> arguments) {
    List<FilterOtaSortingData> data = [];
    for (SortingDataArgument argument in arguments) {
      data.add(FilterOtaSortingData.fromArgument(argument));
    }
    return data;
  }

  SortingDataArgument toArgument() {
    return SortingDataArgument(
        isSelected: isSelected, stringValue: stringValue, id: id);
  }

  static List<SortingDataArgument> toSortedArgument(
      List<FilterOtaSortingData> sortedValues) {
    List<SortingDataArgument> data = [];
    for (FilterOtaSortingData sortedValue in sortedValues) {
      data.add(sortedValue.toArgument());
    }
    return data;
  }
}

class OtaCriteriaKey {
  static String sha = "criteria_sha";
  static String price = "criteria_price";
  static String star = "criteria_star";
  static String review = "criteria_review";
  static String promotion = "criteria_rbh_pro";
}

enum FilterOtaViewPageState {
  initial,
  loading,
  success,
  failure,
  internetFailure,
}
