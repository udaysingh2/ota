import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';
import 'package:ota/domain/ota_search_sort/usecases/ota_filter_sort_use_cases.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_view_model.dart';

const int _kMaximumPrice = 100;
const int _kStartingPrice = 1;

class FilterOtaBloc extends Bloc<FilterOtaViewModel> {
  @override
  FilterOtaViewModel initDefaultValue() {
    return FilterOtaViewModel(
      filterOtaViewPageState: FilterOtaViewPageState.initial,
      listOfSortString: [],
      maximumPrice: _kMaximumPrice,
      startingPrice: _kStartingPrice,
      rangeEndingPrice: _kMaximumPrice,
      rangeStaringPrice: _kStartingPrice,
      starRating: {},
      promotions: [],
      selectedPromotions: [],
      selectedPromotionsCodeSet: {},
      sha: [],
      selectedSha: {},
      filterCriteriaList: [],
    );
  }

  void resetEverything(SliderController sliderController) {
    state.starRating?.clear();
    state.rangeStaringPrice = state.startingPrice;
    state.rangeEndingPrice = state.maximumPrice;
    if (state.listOfSortString != null &&
        state.listOfSortString!.isNotEmpty &&
        state.listOfSortString!.first.stringValue != null) {
      onSortIndexChanged(state.listOfSortString?.first.stringValue ?? "");
    }
    sliderController.updateRange(RangeValues(
        state.rangeStaringPrice?.toDouble() ?? _kStartingPrice.toDouble(),
        state.rangeEndingPrice?.toDouble() ?? _kMaximumPrice.toDouble()));
    state.selectedPromotions?.clear();
    state.selectedSha?.clear();
    emit(state);
  }

  void makeAnApiCallIfNoDataFound() async {
    state.filterOtaViewPageState = FilterOtaViewPageState.loading;
    emit(state);
    OtaSearchSortUseCases otaSearchSortUseCases = OtaSearchSortUseCasesImpl();
    Either<Failure, OtaFilterSort>? result =
        await otaSearchSortUseCases.getOtaSearchSortData();
    if (result?.isRight ?? false) {
      processApiResponse(result?.right);
    } else if (result?.left is InternetFailure) {
      state.filterOtaViewPageState = FilterOtaViewPageState.internetFailure;
      emit(state);
    } else {
      state.filterOtaViewPageState = FilterOtaViewPageState.failure;
      emit(state);
    }
  }

  void processApiResponse(OtaFilterSort? result) {
    OtaFilterSort? data = result;
    List<Criterion> sortInfo = data?.data?.sortInfo ?? [];
    List<Criterion> criteriaInfo = data?.data?.criteria ?? [];
    List<FilterOtaSortingData> sortingDatas = [];
    for (Criterion sort in sortInfo) {
      sortingDatas.add(FilterOtaSortingData(
          isSelected:
              sort.value == AppConfig().configModel.defaultFilterSortCriteria,
          stringValue: sort.displayTitle,
          id: sort.value));
    }
    state.filterCriteriaList = List.generate(
      criteriaInfo.length,
      (index) => FilterCriteriaViewModel.mapFromCriterion(criteriaInfo[index]),
    );
    state.listOfSortString = sortingDatas;
    state.filterOtaViewPageState = FilterOtaViewPageState.success;
    emit(state);
  }

  void mapFromArgument(FilterOtaArgumentModel filterOtaArgumentModel) {
    FilterOtaArgumentData? argData =
        filterOtaArgumentModel.initialFilterOtaArgumentData;
    List<FilterOtaSortingData> list =
        FilterOtaSortingData.getFromSortedArgument(
            argData?.listOfSortString ?? []);
    if (list.isNotEmpty) {
      state.listOfSortString = list;
    } else {
      makeAnApiCallIfNoDataFound();
    }
    state.startingPrice = argData?.startingPrice ?? state.startingPrice;
    state.maximumPrice = argData?.maximumPrice ?? state.maximumPrice;
    state.starRating = argData?.starRating ?? state.starRating;
    state.onSearchClicked = filterOtaArgumentModel.onSearchClicked;
    state.rangeStaringPrice = argData?.rangeStaringPrice ?? state.startingPrice;
    state.rangeEndingPrice = argData?.rangeEndingPrice ?? state.maximumPrice;
    state.filterCriteriaList = argData?.filterCriteriaList;
    if (state.rangeStaringPrice!.toInt() <= state.startingPrice!) {
      state.rangeStaringPrice = state.startingPrice;
    }
    if (state.rangeEndingPrice!.toInt() >= state.maximumPrice!) {
      state.rangeEndingPrice = state.maximumPrice;
    }
    state.promotions = filterOtaArgumentModel.promotions;
    state.selectedPromotions =
        argData?.selectedPromotions ?? state.selectedPromotions;
    state.selectedPromotionsCodeSet =
        _listToSet(state.selectedPromotions ?? []);
    state.sha = filterOtaArgumentModel.sha;
    state.selectedSha = argData?.selectedSha ?? state.selectedSha;
    emit(state);
  }

  Set<String> _listToSet(List<CapsulePromotions> list) {
    Set<String> set = {};
    for (int i = 0; i < list.length; i++) {
      set.add(list[i].code);
    }
    return set;
  }

  void onSearchClicked() {
    if (state.onSearchClicked == null) return;
    state.onSearchClicked!(FilterOtaArgumentData(
        starRating: state.starRating,
        startingPrice: state.startingPrice,
        maximumPrice: state.maximumPrice,
        listOfSortString:
            FilterOtaSortingData.toSortedArgument(state.listOfSortString ?? []),
        rangeEndingPrice: state.rangeEndingPrice,
        rangeStaringPrice: state.rangeStaringPrice,
        selectedPromotions: state.selectedPromotions,
        selectedSha: state.selectedSha,
        filterCriteriaList: state.filterCriteriaList));
  }

  void onSortIndexChanged(String selectedString) {
    for (int i = 0; i < (state.listOfSortString?.length ?? 0); i++) {
      if (state.listOfSortString?[i].stringValue == selectedString) {
        state.listOfSortString?[i].isSelected = true;
      } else {
        state.listOfSortString?[i].isSelected = false;
      }
    }
    emit(state);
  }

  String getSelectedSortingString() {
    if (state.listOfSortString?.isEmpty ?? true) {
      return "";
    }
    return state.listOfSortString?[getSelectedSortingIndex()].stringValue ?? "";
  }

  int getSelectedSortingIndex() {
    for (int i = 0; i < (state.listOfSortString?.length ?? 0); i++) {
      if (state.listOfSortString?[i].isSelected ?? false) {
        return i;
      }
    }
    return 0;
  }

  void updateSliderValue(RangeValues rangeValues) {
    state.rangeStaringPrice = rangeValues.start.toInt();
    state.rangeEndingPrice = rangeValues.end.toInt();
  }

  void selectStar(int index) {
    if (state.starRating?.contains(index) ?? true) {
      state.starRating?.remove(index);
    } else {
      state.starRating?.add(index);
    }
    emit(state);
  }

  void selectPromotion(CapsulePromotions promotion) {
    if (state.selectedPromotionsCodeSet?.contains(promotion.code) ?? false) {
      state.selectedPromotions?.remove(promotion);
      state.selectedPromotionsCodeSet?.remove(promotion.code);
    } else {
      state.selectedPromotions ??= [];
      state.selectedPromotions?.add(promotion);
      state.selectedPromotionsCodeSet?.add(promotion.code);
    }
    emit(state);
  }

  void selectSha(String sha) {
    if (state.selectedSha?.contains(sha) ?? false) {
      state.selectedSha?.remove(sha);
    } else {
      state.selectedSha ??= {};
      state.selectedSha?.add(sha);
    }
    emit(state);
  }
}
