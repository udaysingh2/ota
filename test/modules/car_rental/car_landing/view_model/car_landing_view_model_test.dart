import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

void main() {
  CarRecentSearchList recentSearchList = CarRecentSearchList(
    age: 25,
    pickupLocationId: "",
    pickupLocationName: "",
    returnLocationId: "",
    returnLocationName: "",
    pickupTime: "",
    returnTime: "",
    pickupDate: "",
    returnDate: "",
  );

  test('Car View model Test', () async {
    CarLandingViewModel carLandingViewModel = CarLandingViewModel(
      carRentalType: CarRentalType.carRent,
      carLandingViewModelState: CarLandingViewModelState.success,
    );
    expect(carLandingViewModel.carRentalType, CarRentalType.carRent);
    expect(carLandingViewModel.carLandingViewModelState,
        CarLandingViewModelState.success);
  });

  test('Car Location model Test', () async {
    LocationModel locationModel = LocationModel(
      locationId: "",
      location: "",
    );
    expect(locationModel.locationId, "");
    expect(locationModel.location, "");
  });

  test('Car Recent Search List View Model test', () async {
    CarRecentSearchListViewModel carRecentSearchListViewModel =
        CarRecentSearchListViewModel.fromCarRecentModel(recentSearchList);
    expect(carRecentSearchListViewModel.age, recentSearchList.age);
    expect(carRecentSearchListViewModel.pickupLocationId,
        recentSearchList.pickupLocationId);
    expect(carRecentSearchListViewModel.pickupLocationName,
        recentSearchList.pickupLocationName);
    expect(carRecentSearchListViewModel.returnLocationId,
        recentSearchList.returnLocationId);
    expect(carRecentSearchListViewModel.returnLocationName,
        recentSearchList.returnLocationName);
    expect(
        carRecentSearchListViewModel.pickupTime, recentSearchList.pickupTime);
    expect(
        carRecentSearchListViewModel.returnTime, recentSearchList.returnTime);
    expect(
        carRecentSearchListViewModel.pickupDate, recentSearchList.pickupDate);
    expect(
        carRecentSearchListViewModel.returnDate, recentSearchList.returnDate);
  });
}
