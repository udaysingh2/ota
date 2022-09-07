import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';

class CarSearchResultArgumentModel {
  StaticFilterValue? staticSearchValue;
  LandingFilterValue? landingFilterValue;
  FilterValue? filterValue;
  bool isOtaLandingSearch;

  CarSearchResultArgumentModel({
    this.staticSearchValue,
    this.landingFilterValue,
    this.filterValue,
    this.isOtaLandingSearch = false,
  });

  CarSearchResultDomainArgumentModel toCarSearchResultDomainArgumentModel(
      DateTime pickupDate,
      DateTime dropOffDate,
      String? pickUpLocationId,
      String? dropOffLocationId,
      String sortingMode) {
    return CarSearchResultDomainArgumentModel(
      //Static Values
      userId: staticSearchValue?.userId,
      searchKey: staticSearchValue?.searchKey,
      latitude: staticSearchValue?.latitude,
      longitude: staticSearchValue?.longitude,
      searchAvailableApi: staticSearchValue?.searchAvailableApi ?? true,
      //Landing Values
      pickupLocationId: pickUpLocationId,
      returnLocationId: dropOffLocationId,
      pickupDate: Helpers.getYYYYmmddFromDateTime(pickupDate),
      returnDate: Helpers.getYYYYmmddFromDateTime(dropOffDate),
      pickupTime: Helpers.gethhmmss(pickupDate),
      returnTime: Helpers.gethhmmss(dropOffDate),
      age: landingFilterValue?.age,
      includeDriver: landingFilterValue?.includeDriver,
      //Filter Values
      sortByValue: filterValue?.sortByValue?.value,
      minPrice: filterValue?.minPrice?.toInt(),
      maxPrice: filterValue?.maxPrice?.toInt(),
      carType: filterValue?.carType?.map((e) => int.parse(e)).toList(),
      carBrand: filterValue?.carBrand?.map((e) => int.parse(e)).toList(),
      carSupplier:
          filterValue?.carSupplier != null ? filterValue!.carSupplier : null,
      promotionCodes: filterValue?.promotionCodes != null
          ? "${filterValue?.promotionCodes}"
          : null,
      sortingMode: filterValue?.sortByValue?.value ?? sortingMode,
    );
  }
}

class StaticFilterValue {
  String? userId;
  String? searchKey;
  double? latitude;
  double? longitude;
  bool? searchAvailableApi;

  StaticFilterValue({
    this.userId,
    this.searchKey,
    this.latitude,
    this.longitude,
    this.searchAvailableApi,
  });
}

class LandingFilterValue {
  String? pickupLocationId;
  String? returnLocationId;
  String? pickupLocation;
  String? returnLocation;
  int? age;
  bool? includeDriver;

  LandingFilterValue({
    this.pickupLocationId,
    this.returnLocationId,
    this.pickupLocation,
    this.returnLocation,
    this.age,
    this.includeDriver,
  });
}

class FilterValue {
  CriterionModel? sortByValue;
  double? minPrice;
  double? maxPrice;
  List<String>? carType;
  List<String>? carBrand;
  List<String>? carSupplier;
  List<String>? promotionCodes;

  FilterValue({
    this.sortByValue,
    this.minPrice,
    this.maxPrice,
    this.carType,
    this.carBrand,
    this.carSupplier,
    this.promotionCodes,
  });
}
