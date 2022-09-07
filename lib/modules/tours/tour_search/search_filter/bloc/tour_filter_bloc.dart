import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';
import 'package:ota/domain/tours/search_filter/usecases/tour_search_filter_use_cases.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/helper/tour_filter_helper.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

class TourFilterBloc extends Bloc<TourSearchFilterViewModel> {
  @override
  TourSearchFilterViewModel initDefaultValue() {
    return TourSearchFilterViewModel(
        pageState: TourSearchFilterPageState.initial);
  }

  void resetEverything(SliderController sliderController) {
    if (state.data!.selectedSortInfo != null) {
      state.data!.selectedSortInfo = state.data!.sortInfo![
          TourFilterHelper.getDefaultSelectedIndex(state.data!.sortInfo!)];
    }
    if (state.data!.minPrice != null && state.data!.maxPrice != null) {
      state.data!.rangeMinPrice = state.data!.minPrice!;
      state.data!.rangeMaxPrice = state.data!.maxPrice!;
      sliderController.updateRange(
          RangeValues(state.data!.minPrice!, state.data!.maxPrice!));
    }
    if (state.data!.styleList != null && state.data!.styleList!.isNotEmpty) {
      TourFilterHelper.resetStyleList(state.data!.styleList!);
    }
    emit(state);
  }

  void getScreenData(TourSearchFilterArgument? argumentModel) {
    if (argumentModel != null) {
      if (argumentModel.serviceType == TourSearchServiceType.tour) {
        if (argumentModel.tourModel != null) {
          emit(
            TourSearchFilterViewModel(
              pageState: TourSearchFilterPageState.success,
              data: argumentModel.tourModel,
              serviceType: argumentModel.serviceType,
            ),
          );
        } else {
          makeAnApiCallIfNoDataFound(argumentModel);
        }
      } else {
        if (argumentModel.ticketModel != null) {
          emit(
            TourSearchFilterViewModel(
              pageState: TourSearchFilterPageState.success,
              data: argumentModel.ticketModel,
              serviceType: argumentModel.serviceType,
            ),
          );
        } else {
          makeAnApiCallIfNoDataFound(argumentModel);
        }
      }
    } else {
      state.pageState = TourSearchFilterPageState.failure;
      emit(state);
      return;
    }
  }

  void makeAnApiCallIfNoDataFound(TourSearchFilterArgument? argument) async {
    if (argument == null) {
      state.pageState = TourSearchFilterPageState.failure;
      emit(state);
      return;
    }
    state.pageState = TourSearchFilterPageState.loading;
    emit(state);
    TourSearchFilterUseCases tourSearchFilterUseCases =
        TourSearchFilterUseCasesImpl();
    Either<Failure, TourSearchFilterModelDomain?>? result =
        await tourSearchFilterUseCases.getTourSearchFilterData(
            TourFilterHelper.getServiceType(argument.serviceType));
    if (result != null &&
        result.isRight &&
        result.right != null &&
        result.right!.getSortCriteria != null &&
        result.right!.getSortCriteria!.data != null) {
      processApiResponse(result.right!, argument);
    } else if (result?.left is InternetFailure) {
      state.pageState = TourSearchFilterPageState.internetFailure;
      emit(state);
      return;
    } else {
      state.pageState = TourSearchFilterPageState.failure;
      emit(state);
      return;
    }
  }

  void processApiResponse(
    TourSearchFilterModelDomain result,
    TourSearchFilterArgument argument,
  ) {
    TourSearchFilterData data = TourSearchFilterData.mapScreenData(
      argument: argument.filterData,
      filterModel: result,
    );
    emit(
      TourSearchFilterViewModel(
        data: data,
        pageState: TourSearchFilterPageState.success,
        serviceType: argument.serviceType,
      ),
    );
    return;
  }

  void onSortIndexChanged(int index) {
    state.data!.selectedSortInfo = state.data!.sortInfo!.elementAt(index);
    emit(state);
    return;
  }

  void updateSliderValue(RangeValues rangeValues) {
    state.data!.rangeMinPrice = rangeValues.start;
    state.data!.rangeMaxPrice = rangeValues.end;
  }
}
