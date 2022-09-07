import 'package:ota/domain/tours/details/models/tour_details_models.dart';

const int _kDefaultMinAdults = 1;
const int _kDefaultMinChildren = 0;
const int _kDefaultInt = 0;
const double _kDefaultDouble = 0;
const List<int> _kEmptyAgeList = [];

class TourBookingCalendarViewModel {
  TourPackageModel tourPackageModel;
  BookingCalendarState bookingCalendarState;

  TourBookingCalendarViewModel({
    required this.tourPackageModel,
    this.bookingCalendarState = BookingCalendarState.none,
  });
}

class TourPackageModel {
  String packageName;
  String adultPaxId;
  String childPaxId;
  double adultPrice;
  double childPrice;
  final int childMinAge;
  final int childMaxAge;
  int availableSeats;
  int minimumSeats;
  String timeOfDay;
  String startTime;
  int adultCount;
  int childCount;
  double totalPrice;
  List<int> childAgeList;

  TourPackageModel({
    this.packageName = '',
    this.adultPaxId = '',
    this.childPaxId = '',
    this.adultPrice = _kDefaultDouble,
    this.childPrice = _kDefaultDouble,
    this.childMinAge = _kDefaultInt,
    this.childMaxAge = _kDefaultInt,
    this.availableSeats = _kDefaultInt,
    this.minimumSeats = _kDefaultInt,
    this.timeOfDay = '',
    this.startTime = '',
    this.adultCount = _kDefaultMinAdults,
    this.childCount = _kDefaultMinChildren,
    this.totalPrice = _kDefaultDouble,
    this.childAgeList = _kEmptyAgeList,
  });

  factory TourPackageModel.fromTourPackage(Package package) {
    return TourPackageModel(
      packageName: package.name ?? '',
      adultPaxId: package.adultPaxId ?? '',
      childPaxId: package.childPaxId ?? '',
      adultPrice: package.adultPrice ?? 0,
      childPrice: package.childPrice ?? 0,
      childMinAge: package.childInfo?.minAge ?? 0,
      childMaxAge: package.childInfo?.maxAge ?? 0,
      availableSeats: package.availableSeats ?? 0,
      minimumSeats: package.minimumSeats ?? 0,
      timeOfDay: package.timeOfDay ?? '',
      startTime: package.startTime ?? '',
      totalPrice: package.adultPrice ?? 0,
      childAgeList: [],
    );
  }
}

enum BookingCalendarState {
  none,
  initial,
  success,
  noPackage,
  packageFullSold,
  failure,
  failureNetwork,
  failure1899,
  failure1999,
}
