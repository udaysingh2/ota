import 'package:flutter/cupertino.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

import '../../../../core/app_config.dart';

DateTime currentDate = DateTime.now();

class CarDatesLocationUpdateViewModel extends ChangeNotifier {
  DateTime _pickupDate = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day + AppConfig().configModel.pickUpDeltaCar,
    10,
    0,
  );

  DateTime _dropOffDate = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day + AppConfig().configModel.dropOffDeltaCar,
    10,
    0,
  );

  LocationModel? _pickupLocation;
  LocationModel? _dropOffLocation;
  DateTime get pickupDate => _pickupDate;
  DateTime get dropOffDate => _dropOffDate;
  LocationModel? get pickupLocation => _pickupLocation;
  LocationModel? get dropOffLocation => _dropOffLocation;
  int _age = AppConfig().configModel.carDriverDefaultAge;
  int get age => _age;
  int _recentAge = AppConfig().configModel.carDriverDefaultAge;
  int get recentAge => _recentAge;

  bool _isDifferentDropOff = false;
  bool get isDifferentDropOff => _isDifferentDropOff;

  bool _isRecentDifferentDropOff = false;
  bool get isRecentDifferentDropOff => _isRecentDifferentDropOff;

  bool _isFromRecentSearch = false;
  bool get isFromRecentSearch => _isFromRecentSearch;

  DateTime _recentSearchPickupDate = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day + AppConfig().configModel.pickUpDeltaCar,
    10,
    0,
  );

  DateTime _recentSearchDropOffDate = DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day + AppConfig().configModel.dropOffDeltaCar,
    10,
    0,
  );

  LocationModel? _recentSearchPickupLocation;
  LocationModel? _recentSearchDropOffLocation;
  DateTime get recentSearchPickupDate => _recentSearchPickupDate;
  DateTime get recentSearchDropOffDate => _recentSearchDropOffDate;
  LocationModel? get recentSearchPickupLocation => _recentSearchPickupLocation;
  LocationModel? get recentSearchDropOffLocation =>
      _recentSearchDropOffLocation;

  void updateCarDate(DateTime pickupDate, DateTime dropOffDate) {
    _pickupDate = pickupDate;
    _dropOffDate = dropOffDate;
    notifyListeners();
  }

  void updateCarLocation(
      {LocationModel? locationModelPickup,
      LocationModel? locationModelDropOff}) {
    _pickupLocation = locationModelPickup;
    _dropOffLocation = locationModelDropOff;
    notifyListeners();
  }

  void updateAge(int age) {
    _age = age;
    notifyListeners();
  }

  void updateIsDifferentDropOff(bool isDifferentDropOff) {
    _isDifferentDropOff = isDifferentDropOff;
    notifyListeners();
  }

  void updateIsRecentSearch(bool isRecentDifferentDropOff) {
    _isRecentDifferentDropOff = isRecentDifferentDropOff;
    notifyListeners();
  }

  void checkIfDropOffAndPickUpSame() {
    if (!_isDifferentDropOff) {
      _dropOffLocation = null;
      notifyListeners();
    }
  }

  resetValues() {
    _pickupDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + AppConfig().configModel.pickUpDeltaCar,
      10,
      0,
    );
    _dropOffLocation = null;
    _pickupLocation = null;
    _isDifferentDropOff = false;
    _dropOffDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + AppConfig().configModel.dropOffDeltaCar,
      10,
      0,
    );
    _age = AppConfig().configModel.carDriverDefaultAge;
    _recentSearchPickupDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + AppConfig().configModel.pickUpDeltaCar,
      10,
      0,
    );
    _recentSearchDropOffLocation = null;
    _recentSearchPickupLocation = null;
    _recentSearchDropOffDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day + AppConfig().configModel.dropOffDeltaCar,
      10,
      0,
    );
    _recentAge = AppConfig().configModel.carDriverDefaultAge;
    _isRecentDifferentDropOff = false;
    _isFromRecentSearch = false;
    notifyListeners();
  }

  void updateisFromRecentSearch(bool isFromRecentSearch) {
    _isFromRecentSearch = isFromRecentSearch;
    notifyListeners();
  }

  void updateRecentAge(int age) {
    _recentAge = age;
    notifyListeners();
  }

  void updateCarDateRecentSearch(DateTime pickupDate, DateTime dropOffDate) {
    _recentSearchPickupDate = pickupDate;
    _recentSearchDropOffDate = dropOffDate;
    notifyListeners();
  }

  void updateCarLocationRecentSearch(
      {LocationModel? locationModelPickup,
      LocationModel? locationModelDropOff}) {
    _recentSearchPickupLocation = locationModelPickup;
    _recentSearchDropOffLocation = locationModelDropOff;
    notifyListeners();
  }

  void updateIsRecentDifferentDropOff(bool isDifferentDropOff) {
    _isRecentDifferentDropOff = isDifferentDropOff;
    notifyListeners();
  }
}
