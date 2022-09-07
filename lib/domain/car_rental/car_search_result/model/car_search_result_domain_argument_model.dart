class CarSearchResultDomainArgumentModel {
  String? userId;
  String? searchKey;
  double? latitude;
  double? longitude;
  String? sortingMode;
  bool? searchAvailableApi;
  String? pickupLocationId;
  String? returnLocationId;
  String? pickupDate;
  String? returnDate;
  String? pickupTime;
  String? returnTime;
  int? age;
  bool? includeDriver;
  String? sortByValue;
  int? minPrice;
  int? maxPrice;
  List<int>? carType;
  List<int>? carBrand;
  List<String>? carSupplier;
  String? promotionCodes;

  CarSearchResultDomainArgumentModel({
    this.userId,
    this.searchKey,
    this.latitude,
    this.longitude,
    this.sortingMode,
    this.searchAvailableApi,
    this.pickupLocationId,
    this.returnLocationId,
    this.pickupDate,
    this.returnDate,
    this.pickupTime,
    this.returnTime,
    this.age,
    this.includeDriver,
    this.sortByValue,
    this.minPrice,
    this.maxPrice,
    this.carType,
    this.carBrand,
    this.carSupplier,
    this.promotionCodes,
  });

  List? toMap() {
    if (carSupplier != null) {
      List<String> array = [];
      array.addAll(carSupplier!.map((e) => e.toString().addQuote()));
      return array;
    }
    return null;
  }
}

extension StringQuote on String {
  String addQuote() {
    return '"${this}"';
  }
}
