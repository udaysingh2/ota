import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/domain/tours/search_result/usecases/tour_search_result_use_cases.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/tour_search/results/helpers/tour_search_result_helper.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';

class TourSearchResultBloc extends Bloc<TourSearchResultViewModel> {
  bool isFromOtaSearchScreen = true;
  @override
  TourSearchResultViewModel initDefaultValue() {
    return TourSearchResultViewModel();
  }

  void initData(TourSearchResultArgumentModel? argument) {
    if (argument != null) {
      onCategorySelected(
        argument.playlistName == PlaylistType.tour.value
            ? PlaylistType.tour
            : PlaylistType.ticket,
      );
      setLocationName(argument.searchKey);
    }
  }

  void getTourSearchResultData({
    TourSearchResultArgumentModel? argument,
    required bool refreshData,
    required bool isFiltered,
    required bool isForceFetch,
    required bool refreshLoading,
  }) async {
    if (argument == null) {
      _emitFailure();
      return;
    }

    if (refreshLoading) {
      if (argument.playlistName == PlaylistType.tour.value &&
          argument.tourSearchList != null &&
          argument.tourSearchList!.isNotEmpty &&
          isFromOtaSearchScreen) {
        state.tourSearchList = argument.tourSearchList;
        state.tourFilterOption = argument.tourfilterOption;
        if (argument.ticketSearchList != null &&
            argument.ticketSearchList!.isNotEmpty) {
          state.ticketSearchList = argument.ticketSearchList;
          state.ticketFilterOption = argument.ticketfilterOption;
        }
        state.locationName = argument.searchKey;
        isFromOtaSearchScreen = false;
        state.tourSearchResultViewState = TourSearchResultViewState.success;
        emit(state);
        return;
      } else if (argument.playlistName == PlaylistType.ticket.value &&
          argument.ticketSearchList != null &&
          argument.ticketSearchList!.isNotEmpty &&
          isFromOtaSearchScreen) {
        state.ticketSearchList = argument.ticketSearchList;
        state.ticketFilterOption = argument.ticketfilterOption;
        if (argument.tourSearchList != null &&
            argument.tourSearchList!.isNotEmpty) {
          state.tourSearchList = argument.tourSearchList;
          state.tourFilterOption = argument.tourfilterOption;
        }
        state.locationName = argument.searchKey;
        isFromOtaSearchScreen = false;
        state.tourSearchResultViewState = TourSearchResultViewState.success;
        emit(state);
        return;
      } else {
        state.tourSearchResultViewState =
            TourSearchResultViewState.refreshLoading;
        emit(state);
      }
    }

    if (isForceFetch) {
      state.tourSearchResultViewState = TourSearchResultViewState.loading;
      emit(state);
    }
    if (isFiltered) {
      state.tourSearchResultViewState = TourSearchResultViewState.filterLoading;
      emit(state);
    }

    TourSearchResultUseCasesImpl searchUseCasesImpl =
        TourSearchResultUseCasesImpl();

    final domainArgument =
        TourSearchResultArgumentDomain.fromArgument(argument);
    Either<Failure, TourSearchResultModelDomain?>? result =
        await searchUseCasesImpl.getTourSearchResultData(domainArgument);
    if (result?.isRight ?? false) {
      TourSearchResultModelDomain? searchResult = result!.right;
      String? statusCode =
          searchResult?.getTourAndTicketSearchResult?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.tourSearchResultViewState = TourSearchResultViewState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.tourSearchResultViewState = TourSearchResultViewState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        List<TourSearchResultModel>? tourSearchResultModelList =
            TourSearchResultHelper.getTourSearchResultModelList(searchResult
                ?.getTourAndTicketSearchResult
                ?.data
                ?.tourAndTicketActivityList);
        state.locationName =
            searchResult?.getTourAndTicketSearchResult?.data?.location;
        TourFilterDataViewModel? filterData;
        if (searchResult!.getTourAndTicketSearchResult!.data!.filter != null) {
          filterData = TourFilterDataViewModel.mapFromDomain(
              searchResult.getTourAndTicketSearchResult!.data!.filter!);
        }
        if (argument.playlistName == PlaylistType.tour.value) {
          if (isTourSearchListNotNullEmpty) {
            if (refreshData) {
              state.tourSearchList!.clear();
            }
            state.tourSearchList!.addAll(tourSearchResultModelList);
          } else {
            state.tourSearchList = tourSearchResultModelList;
            state.tourFilterOption = filterData;
          }
        } else if (argument.playlistName == PlaylistType.ticket.value) {
          if (isTicketSearchListNotNullEmpty) {
            if (refreshData) {
              state.ticketSearchList!.clear();
            }
            state.ticketSearchList!.addAll(tourSearchResultModelList);
          } else {
            state.ticketSearchList = tourSearchResultModelList;
            state.ticketFilterOption = filterData;
          }
        }
        state.tourSearchResultViewState = TourSearchResultViewState.success;
        emit(state);
      } else {
        _emitFailure();
      }
    } else if (result?.left is InternetFailure) {
      if (argument.playlistName == PlaylistType.tour.value) {
        if (isTourSearchListNotNullEmpty) {
          state.tourSearchResultViewState =
              TourSearchResultViewState.internetFailureRefresh;
          emit(state);
          return;
        }
      } else if (argument.playlistName == PlaylistType.ticket.value) {
        if (isTicketSearchListNotNullEmpty) {
          state.tourSearchResultViewState =
              TourSearchResultViewState.internetFailureRefresh;
          emit(state);
          return;
        }
      }
      state.tourSearchResultViewState =
          TourSearchResultViewState.internetFailure;
      emit(state);
      return;
    } else {
      _emitFailure();
    }
  }

  void _emitFailure() {
    state.tourSearchResultViewState = TourSearchResultViewState.failure;
    emit(state);
  }

  bool get isTourSearchListNotNullEmpty =>
      state.tourSearchList != null && state.tourSearchList!.isNotEmpty;

  bool get isTicketSearchListNotNullEmpty =>
      state.ticketSearchList != null && state.ticketSearchList!.isNotEmpty;

  int get _tourSearchListSize =>
      state.tourSearchList != null ? state.tourSearchList!.length : 0;

  int get _ticketSearchListSize =>
      state.ticketSearchList != null ? state.ticketSearchList!.length : 0;

  void onCategorySelected(PlaylistType playlistType) {
    state.selectedCategory = playlistType;
    state.tourSearchResultViewState = TourSearchResultViewState.initial;
    emit(state);
  }

  void setLocationName(String? locationName) {
    state.locationName = locationName;
    emit(state);
  }

  bool get isTourTicketSearchListAvailable => (state.selectedCategory ==
          PlaylistType.tour
      ? state.tourSearchList != null && state.tourSearchList!.isNotEmpty
      : state.ticketSearchList != null && state.ticketSearchList!.isNotEmpty);

  List<TourSearchResultModel> get tourTicketSearchList =>
      state.selectedCategory == PlaylistType.tour
          ? state.tourSearchList!
          : state.ticketSearchList!;

  bool get isTourSelectedCategory =>
      state.selectedCategory == PlaylistType.tour;

  int get searchListSize => state.selectedCategory == PlaylistType.tour
      ? _tourSearchListSize
      : _ticketSearchListSize;

  bool get isRefreshLoading =>
      state.tourSearchResultViewState ==
      TourSearchResultViewState.refreshLoading;

  bool get isLoading =>
      state.tourSearchResultViewState == TourSearchResultViewState.loading;

  bool get isFailure =>
      state.tourSearchResultViewState == TourSearchResultViewState.failure ||
      state.tourSearchResultViewState ==
          TourSearchResultViewState.failure1899 ||
      state.tourSearchResultViewState ==
          TourSearchResultViewState.failure1999 ||
      state.tourSearchResultViewState ==
          TourSearchResultViewState.internetFailure;
}
