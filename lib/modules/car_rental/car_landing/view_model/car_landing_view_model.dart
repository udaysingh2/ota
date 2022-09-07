import '../../../../domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart';

class CarLandingViewModel {
  CarRentalType carRentalType;
  String? pickUpLocationCarRentWithDriver;
  String? dropOffLocationCarRentWithDriver;
  CarLandingViewModelState carLandingViewModelState;
  List<CarRecentSearchListViewModel>? carRecentSearchList;

  CarLandingViewModel(
      {required this.carRentalType,
      this.dropOffLocationCarRentWithDriver,
      this.pickUpLocationCarRentWithDriver,
      required this.carLandingViewModelState,
      this.carRecentSearchList});
}

class LocationModel {
  String? locationId;
  String? location;

  LocationModel({
    this.locationId,
    this.location,
  });
}

enum CarRentalType {
  carRent,
  carRentWithDriver,
}

enum CarLandingViewModelState {
  initial,
  loading,
  success,
  failure,
  failureNetwork,
  clearSuccess,
  clearFailed
}

class CarRecentSearchListViewModel {
  CarRecentSearchListViewModel(
      {this.age,
      this.pickupLocationId,
      this.pickupLocationName,
      this.returnLocationName,
      this.pickupTime,
      this.returnTime,
      this.returnLocationId,
      this.pickupDate,
      this.returnDate});

  final int? age;
  final String? pickupLocationId;
  final String? pickupLocationName;
  final String? returnLocationName;
  final String? returnLocationId;
  final String? pickupTime;
  final String? returnTime;
  final String? pickupDate;
  final String? returnDate;

  factory CarRecentSearchListViewModel.fromCarRecentModel(
      CarRecentSearchList recentSearchList) {
    return CarRecentSearchListViewModel(
        age: recentSearchList.age ?? 0,
        pickupLocationId: recentSearchList.pickupLocationId,
        pickupLocationName: recentSearchList.pickupLocationName,
        returnLocationName: recentSearchList.returnLocationName,
        pickupTime: recentSearchList.pickupTime,
        returnTime: recentSearchList.returnTime,
        returnLocationId: recentSearchList.returnLocationId,
        pickupDate: recentSearchList.pickupDate,
        returnDate: recentSearchList.returnDate);
  }
}
