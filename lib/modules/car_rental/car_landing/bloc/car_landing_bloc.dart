import 'package:either_dart/either.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_landing/models/clear_recent_search_domain_model.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

import '../../../../common/network/failures.dart';
import '../../../../domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';
import '../../../../domain/car_rental/car_landing/usecases/car_landing_usecases.dart';
import '../../../../domain/car_rental/car_landing/usecases/clear_recent_searches_usecase.dart';

const String _kSuccessCode = "1000";
const String _kFailureCode = "1899";

class CarLandingBloc extends Bloc<CarLandingViewModel> {
  @override
  CarLandingViewModel initDefaultValue() {
    return CarLandingViewModel(
      carRentalType: CarRentalType.carRent,
      carLandingViewModelState: CarLandingViewModelState.initial,
    );
  }

  void updateCarRentalType(CarRentalType carRentalType) {
    if (carRentalType != state.carRentalType) {
      state.carRentalType = carRentalType;
      emit(state);
    }
  }

  void updateLocationCarRentWithDriver(
      {required String location, required bool isPickupLocationUpdate}) {
    if (isPickupLocationUpdate) {
      state.pickUpLocationCarRentWithDriver = location;
    } else {
      state.dropOffLocationCarRentWithDriver = location;
    }
    emit(state);
  }

  bool enableSearchButton(CarDatesLocationUpdateViewModel? value,
      {isLanding = true}) {
    String pickUp = value?.pickupLocation?.location ?? '';
    String recentPickup = value?.recentSearchPickupLocation?.location ?? '';
    if (isLanding && value?.isFromRecentSearch == false) {
      if (pickUp.isEmpty) {
        return false;
      }
    } else if (isLanding == false && value!.isFromRecentSearch) {
      if (recentPickup.isEmpty) {
        return false;
      }
    }

    if (value!.isDifferentDropOff) {
      String dropOff = value.dropOffLocation?.location ?? '';
      String recentDropOff = value.recentSearchDropOffLocation?.location ?? '';

      if (isLanding && value.isFromRecentSearch == false) {
        if (dropOff.isEmpty) {
          return false;
        }
      } else if (isLanding == false && value.isFromRecentSearch) {
        if (recentDropOff.isEmpty) {
          return false;
        }
      }
    }

    return true;
  }

  getRecentSearches(String serviceType, String dataSearchType) async {
    state.carLandingViewModelState = CarLandingViewModelState.loading;
    emit(state);
    CarLandingUseCaseImpl carLandingUseCaseImpl = CarLandingUseCaseImpl();

    Either<Failure, LandingRecentSearchDomainModel>? result =
        await carLandingUseCaseImpl.getRecentSearches(
            serviceType, dataSearchType);

    if (result?.isRight ?? false) {
      LandingRecentSearchDomainModel data = result!.right;
      List<SearchHistory>? recentSearchesData = data.data?.searchHistory;

      if (recentSearchesData == null && recentSearchesData?.first == null) {
        state.carLandingViewModelState = CarLandingViewModelState.failure;
        emit(state);
      } else {
        List<CarRecentSearchList> recentList =
            recentSearchesData?.first.carRental?.carRecentSearchList ?? [];
        state.carRecentSearchList = _getRecentList(recentList);
        state.carLandingViewModelState = CarLandingViewModelState.success;
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        state.carLandingViewModelState =
            CarLandingViewModelState.failureNetwork;
      } else {
        state.carLandingViewModelState = CarLandingViewModelState.failure;
      }
      emit(state);
    }
  }

  List<CarRecentSearchListViewModel> _getRecentList(
      List<CarRecentSearchList> recentList) {
    return recentList
        .map((e) => CarRecentSearchListViewModel.fromCarRecentModel(e))
        .toList();
  }

  bool get isRecentSearchNotEmpty =>
      state.carRecentSearchList != null &&
      state.carRecentSearchList!.isNotEmpty;

  bool get isSuccess =>
      state.carLandingViewModelState == CarLandingViewModelState.success;

  void clearRecentSearches(String serviceType, String dataSearchType) async {
    state.carLandingViewModelState = CarLandingViewModelState.loading;
    emit(state);
    CarLandingClearUseCaseImpl carLandingUseCaseImpl =
        CarLandingClearUseCaseImpl();

    Either<Failure, ClearRecentSearchDomainModel>? data =
        await carLandingUseCaseImpl.clearRecentSearch(
            serviceType, dataSearchType);
    if (data != null && data.isRight) {
      ClearRecentSearchDomainModel result = data.right;

      if (result.status?.code == _kSuccessCode) {
        state.carLandingViewModelState = CarLandingViewModelState.clearSuccess;
        emit(state);
        return;
      } else if (result.status?.code == _kFailureCode) {
        state.carLandingViewModelState = CarLandingViewModelState.clearFailed;
        emit(state);
        return;
      }
    }
  }

  bool get isClearFailed =>
      state.carLandingViewModelState == CarLandingViewModelState.clearFailed;
}
