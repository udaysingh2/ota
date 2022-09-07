import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';
import 'package:ota/domain/car_rental/car_search_result/usecases/car_search_result_use_cases.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';

import '../../car_landing/view_model/car_landing_view_model.dart';

const int _kSearchResultLimit = 20;

class CarSearchResultBloc extends Bloc<CarSearchResultViewModel> {
  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  updatePageNumber(int number) {
    _pageNumber = number;
  }

  @override
  CarSearchResultViewModel initDefaultValue() {
    return CarSearchResultViewModel(
      pageState: CarSearchResultPageState.initial,
      carSearchResult: CarSearchResultModel(
        carModelList: [],
      ),
    );
  }

  Future<void> getCarSearchResult(
      CarSearchResultArgumentModel argument,
      DateTime pickupDate,
      DateTime dropOffDate,
      LocationModel? pickupLocation,
      LocationModel? dropLocation,
      String kDataSearchType,
      String sortingMode,
      {bool isFilterLoading = false,
      bool isSearchSave = false}) async {
    if (state.pageState == CarSearchResultPageState.loading ||
        state.pageState == CarSearchResultPageState.filterLoading ||
        _pageNumber == -1) {
      return;
    }
    state.pageState = isFilterLoading
        ? CarSearchResultPageState.filterLoading
        : CarSearchResultPageState.loading;
    emit(state);

    CarSearchResultUseCasesImpl carSearchResultUseCasesImpl =
        CarSearchResultUseCasesImpl();
    Either<Failure, CarSearchResultDomainModel>? result =
        await carSearchResultUseCasesImpl.getCarSearchResultData(
            argument: argument.toCarSearchResultDomainArgumentModel(
                pickupDate,
                dropOffDate,
                pickupLocation?.locationId,
                dropLocation?.locationId,
                sortingMode),
            pageNumber: _pageNumber,
            pageSize: _kSearchResultLimit,
            pickupLocation: pickupLocation,
            dropLocation: dropLocation,
            dataSearchType: kDataSearchType,
            isSearchSave: isSearchSave);
    if (_pageNumber == 1) {
      state.carSearchResult?.carModelList?.clear();
    }
    if (result?.isRight ?? false) {
      CarSearchResultDomainModel carSearchResultDomainModel = result!.right;
      CarRental? carRental = carSearchResultDomainModel.data?.carRental;

      if (carRental == null) {
        state.pageState = CarSearchResultPageState.failure;
      } else {
        List<CarModelList> carModelList = carRental.carModelList ?? [];
        AvailableFilterModel? availableFilter = carRental.availableFilter;

        if (_pageNumber == 1 &&
            availableFilter != null &&
            state.carSearchResult?.availableFilterViewModel == null) {
          state.carSearchResult?.availableFilterViewModel =
              AvailableFilterViewModel.fromAvailableFilterModel(
                  availableFilter);
        }

        if (carModelList.length < _kSearchResultLimit) {
          _pageNumber = -1;
        } else {
          _pageNumber++;
        }

        state.carSearchResult?.carModelList?.addAll(carModelList
            .map((list) => CarSearchDetailModel.fromCarModelList(list))
            .toList());
        state.isInternetFailurePopUpShown = false;
        state.pageState = CarSearchResultPageState.success;
      }
    } else {
      if (result?.left is InternetFailure) {
        state.pageState = CarSearchResultPageState.failureNetwork;
      } else {
        state.pageState = CarSearchResultPageState.failure;
      }
    }
    emit(state);
  }

  setInternetFailurePopUpShown() {
    state.isInternetFailurePopUpShown = true;
    emit(state);
  }
}
