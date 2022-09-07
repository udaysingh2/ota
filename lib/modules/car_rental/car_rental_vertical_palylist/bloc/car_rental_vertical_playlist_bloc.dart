import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';
import 'package:ota/domain/search/usecases/ota_search_use_cases.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';

const _kPageSize = 20;

class CarRentalVerticalPlaylistBloc extends Bloc<CarVerticalListViewModel> {
  final OtaSearchUseCasesImpl _otaSearchUseCasesImpl = OtaSearchUseCasesImpl();
  int _currentPageNumber = 2;

  @override
  CarVerticalListViewModel initDefaultValue() {
    return CarVerticalListViewModel(
      pageState: CarVerticalListPageState.preLoaded,
    );
  }

  bool isNewDataRequired(int index) {
    if ((_currentPageNumber - 1) * _kPageSize == (index + 1)) {
      return true;
    } else {
      return false;
    }
  }

  mapCarDataFromArgument(CarVerticalArgumentViewModel? argumentViewModel) {
    if (argumentViewModel != null) {
      state.pageState = CarVerticalListPageState.success;
      state.carRentalVerticalData =
          CarRentalVerticalData.fromCarRentalModel(argumentViewModel.carModel);
      emit(state);
    }
  }

  Future<void> getCarDataWithOffset(OtaSearchViewArgument argument) async {
    OtaSearchViewArgument? otaSearchViewArgument = argument;
    otaSearchViewArgument.pageSize = _kPageSize.toString();
    otaSearchViewArgument.pageNumber = _currentPageNumber;
    otaSearchViewArgument.hotelData = null;
    otaSearchViewArgument.tourAndTicketViewData = null;
    otaSearchViewArgument.flightData = null;

    Either<Failure, OtaSearchData>? result = await _otaSearchUseCasesImpl
        .getOtaSearchData(argument.toOtaSearchArgument());
    if (result?.isRight ?? false) {
      OtaSearchData data = result!.right;
      GetOtaSearchResultData? searchDetailData = data.getOtaSearchResult?.data;
      if (searchDetailData != null) {
        _currentPageNumber += 1;
        CarRentalVerticalData carData =
            CarRentalVerticalData.fromCarRentalModel(searchDetailData.car);
        (state.carRentalVerticalData?.carModelList ?? [])
            .addAll(carData.carModelList ?? []);
        state.pageState = CarVerticalListPageState.success;
        state.isInternetFailurePopUpShown = false;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.pageState = CarVerticalListPageState.internetFailure;
      emit(state);
    }
  }

  bool get isSuccess => state.pageState == CarVerticalListPageState.success;

  bool get isPreLoaded => state.pageState == CarVerticalListPageState.preLoaded;

  setPopUpShown() {
    state.isInternetFailurePopUpShown = true;
    emit(state);
  }
}
