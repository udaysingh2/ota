import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/domain/search/usecases/ota_search_use_cases.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';

class OtaSearchBloc extends Bloc<OtaSearchViewModel> {
  final OtaSearchUseCasesImpl _otaSearchUseCasesImpl = OtaSearchUseCasesImpl();
  int currentPageNumber = 0;

  @override
  OtaSearchViewModel initDefaultValue() {
    return OtaSearchViewModel(
      pageState: OtaSearchViewPageState.loading,
    );
  }

  void updatePreLoadedState() {
    emit(OtaSearchViewModel(pageState: OtaSearchViewPageState.preLoaded));
  }

  void initPreLoadedData(List<HotelListResult> preHotelList) {
    _setFirstPage();
    state.data = OtaSearchModel(hotelView: HotelView(hotelList: preHotelList));
    state.pageState = OtaSearchViewPageState.preLoaded;
    emit(state);
  }

  Future<void> getHotelSearchResult(OtaSearchViewArgument argument,
      {bool isFilterLoading = false, bool isRefresh = false}) async {
    state.pageState = isFilterLoading
        ? OtaSearchViewPageState.filterLoading
        : OtaSearchViewPageState.loading;
    if (isFilterLoading || isRefresh) {
      _setFirstPage();
      _clearHotelListData();
    } else {
      currentPageNumber++;
    }
    emit(state);
    argument.pageNumber = currentPageNumber;

    Either<Failure, OtaSearchData>? result = await _otaSearchUseCasesImpl
        .getOtaSearchData(argument.toOtaSearchArgument());
    if (result?.isRight ?? false) {
      GetOtaSearchResultData? otaSearchResultData =
          result!.right.getOtaSearchResult?.data;
      if (otaSearchResultData != null) {
        OtaSearchModel otaSearchModel =
            OtaSearchModel.mapFromSearchDetail(otaSearchResultData);
        if ((otaSearchModel.hotelView?.hotelList?.isNotEmpty ?? false)) {
          if (isHotelListEmpty) {
            state.data = otaSearchModel;
          } else {
            state.data!.hotelView!.hotelList!
                .addAll(otaSearchModel.hotelView?.hotelList ?? []);
            state.data!.lastPageFlag = otaSearchModel.lastPageFlag;
          }
          state.pageState = OtaSearchViewPageState.success;
          emit(state);
        } else if (_isFetchNextPage(otaSearchModel)) {
          currentPageNumber++;
          argument.pageNumber = currentPageNumber;
          getHotelSearchResult(argument, isFilterLoading: isFilterLoading);
        } else {
          state.pageState = OtaSearchViewPageState.empty;
          state.data?.lastPageFlag = otaSearchModel.lastPageFlag;
          emit(state);
        }
      } else {
        state.pageState = OtaSearchViewPageState.empty;
        state.data?.lastPageFlag = otaSearchResultData?.lastPageFlag;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.pageState = OtaSearchViewPageState.internetFailure;
      state.data?.lastPageFlag = true;
      emit(state);
    } else {
      state.pageState = OtaSearchViewPageState.failure;
      state.data?.lastPageFlag = true;
      emit(state);
    }
  }

  Future<void> getOtaSearchResult(OtaSearchViewArgument argument,
      {bool isFilterLoading = false}) async {
    state.pageState = isFilterLoading
        ? OtaSearchViewPageState.filterLoading
        : OtaSearchViewPageState.loading;
    emit(state);

    Either<Failure, OtaSearchData>? result = await _otaSearchUseCasesImpl
        .getOtaSearchData(argument.toOtaSearchArgument());
    if (result?.isRight ?? false) {
      OtaSearchData data = result!.right;
      GetOtaSearchResultData? searchDetailData = data.getOtaSearchResult?.data;
      if (searchDetailData != null) {
        OtaSearchModel otaSearchModel =
            OtaSearchModel.mapFromSearchDetail(searchDetailData);
        if ((otaSearchModel.hotelView?.hotelList?.isNotEmpty ?? false) ||
            (otaSearchModel.tourView?.activityList?.isNotEmpty ?? false) ||
            (otaSearchModel.ticketView?.activityList?.isNotEmpty ?? false) ||
            (otaSearchModel.carView?.carRental?.carModelList?.isNotEmpty ??
                false)) {
          emit(OtaSearchViewModel(
              pageState: OtaSearchViewPageState.success, data: otaSearchModel));
        } else {
          emit(OtaSearchViewModel(
              pageState: OtaSearchViewPageState.empty, data: otaSearchModel));
        }
      } else {
        emit(OtaSearchViewModel(pageState: OtaSearchViewPageState.empty));
      }
    } else if (result?.left is InternetFailure) {
      emit(OtaSearchViewModel(
          pageState: OtaSearchViewPageState.internetFailure));
    } else {
      emit(OtaSearchViewModel(pageState: OtaSearchViewPageState.failure));
    }
  }

  void _clearHotelListData() {
    if (state.data?.hotelView?.hotelList != null) {
      state.data!.hotelView!.hotelList!.clear();
    }
  }

  List<TourSearchResultModel> get tourActivityList => List.generate(
      state.data!.tourView?.activityList?.length ?? 0,
      (index) =>
          state.data!.tourView!.activityList![index].toTourSearchModel());

  List<TourSearchResultModel> get ticketActivityList => List.generate(
      state.data!.ticketView?.activityList?.length ?? 0,
      (index) =>
          state.data!.ticketView!.activityList![index].toTourSearchModel());

  TourFilterDataViewModel? get tourFilterModel =>
      state.data!.tourView!.activityfilter?.toTourFilterDataModel();

  TourFilterDataViewModel? get ticketFilterModel =>
      state.data!.ticketView!.activityfilter?.toTourFilterDataModel();

  bool get isSuccess => state.pageState == OtaSearchViewPageState.success;

  bool get isPreLoaded => state.pageState == OtaSearchViewPageState.preLoaded;

  bool get isLoading => state.pageState == OtaSearchViewPageState.loading;

  bool get isLoadingFilter =>
      state.pageState == OtaSearchViewPageState.filterLoading;

  bool get isHotelListEmpty =>
      state.data?.hotelView?.hotelList?.isEmpty ?? true;

  bool _isFetchNextPage(OtaSearchModel otaSearchModel) =>
      isHotelListEmpty && !(otaSearchModel.lastPageFlag ?? true);

  List<HotelListResult> get hotelListData =>
      state.data?.hotelView?.hotelList ?? [];

  void _setFirstPage() => currentPageNumber = 1;
}
