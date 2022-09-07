import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

class TourFilterHelper {
  static List<String> getListOfDisplayTitle(
      List<TourFilterCategoryViewModel> categoryList) {
    List<String> displayTitleList = [];
    if (categoryList.isNotEmpty) {
      for (TourFilterCategoryViewModel filterCategory in categoryList) {
        displayTitleList.add(filterCategory.displayTitle);
      }
    }
    return displayTitleList;
  }

  static TourFilterCategoryViewModel? getSelectedSortInfo(
      List<Criterion>? criteriaList) {
    List<TourFilterCategoryViewModel>? sortList =
        getFilterViewModel(criteriaList);
    if (sortList == null || sortList.isEmpty) return null;
    TourFilterCategoryViewModel selectedSortInfo =
        sortList[getDefaultSelectedIndex(sortList)];
    return selectedSortInfo;
  }

  static String getServiceType(TourSearchServiceType serviceType) {
    Map<TourSearchServiceType, String> map = {
      TourSearchServiceType.tour: "ACTIVITY",
      TourSearchServiceType.tickets: "TICKET",
    };
    if (map[serviceType] != null) {
      return map[serviceType]!;
    } else {
      return "ACTIVITY";
    }
  }

  static List<TourFilterCategoryViewModel>? getFilterViewModel(
      List<Criterion>? criteriaList) {
    if (criteriaList == null || criteriaList.isEmpty) return null;
    List<TourFilterCategoryViewModel> filterList = List.generate(
        criteriaList.length,
        (index) => TourFilterCategoryViewModel.mapFromCriterion(
            criteriaList.elementAt(index)));
    return filterList;
  }

  static List<TourStyleViewModel>? getStyleList(List<String>? styleList) {
    if (styleList == null || styleList.isEmpty) return null;
    List<TourStyleViewModel> styleViewModelList = List.generate(
        styleList.length,
        (index) => TourStyleViewModel(styleName: styleList.elementAt(index)));
    return styleViewModelList;
  }

  static int getDefaultSelectedIndex(
      List<TourFilterCategoryViewModel> sortList) {
    int defaultIndex = 0;
    for (int index = 0; index < sortList.length; index++) {
      if (sortList[index].categoryKey == TourFilterHelperConst.rbhSuggest) {
        defaultIndex = index;
        break;
      }
    }
    return defaultIndex;
  }

  static int getSelectedIndex(TourFilterCategoryViewModel sortCategory,
      List<TourFilterCategoryViewModel> sortList) {
    int defaultIndex = 0;
    for (int index = 0; index < sortList.length; index++) {
      if (sortList[index].categoryKey == sortCategory.categoryKey) {
        defaultIndex = index;
        break;
      }
    }
    return defaultIndex;
  }

  static void resetStyleList(List<TourStyleViewModel> styleList) {
    for (TourStyleViewModel style in styleList) {
      style.isSelected = false;
    }
    return;
  }

  static List<String>? getSelectedStyleList(
      List<TourStyleViewModel>? styleList) {
    List<String>? appliedStyleList = [];
    if (styleList != null && styleList.isNotEmpty) {
      for (TourStyleViewModel style in styleList) {
        if (style.isSelected) appliedStyleList.add(style.styleName);
      }
    }
    return appliedStyleList.isNotEmpty ? appliedStyleList : null;
  }

  static List<String> getSortInfoTitle(
      List<TourFilterCategoryViewModel>? labelList) {
    List<String>? displayTitleList = [];
    if (labelList != null && labelList.isNotEmpty) {
      for (TourFilterCategoryViewModel label in labelList) {
        displayTitleList.add(label.displayTitle);
      }
    }
    return displayTitleList;
  }

  static int getIndex(List<String> labelList, String? chosenOption) {
    if (chosenOption == null || chosenOption.isEmpty || labelList.isEmpty) {
      return 0;
    } else {
      for (int index = 0; index < labelList.length; index++) {
        if (chosenOption == labelList[index]) {
          return index;
        }
      }
      return 0;
    }
  }
}

class TourFilterHelperConst {
  static const String rbhSuggest = "rbh_suggest";
  static const String criteriaPrice = "criteria_price";
  static const String criteriaStyle = "criteria_style";
}
