class CarSearchResultFirebase {
  static const String carKeywordPickUp = 'car_keywordsearch_pickup';
  static const String carKeywordDropOff = 'car_keywordsearch_return';
  static const String carPickUpLocation = 'car_pickup_location';
  static const String carDropOffLocation = 'car_return_location';
  static const String carIsDifferentDropOff = 'car_pickup_return_diff_location';
  static const String carPickUpDateTime = 'car_pickup_datetime';
  static const String carReturnUpDateTime = 'car_return_datetime';
  static const String carDriverAge = 'car_driver_age';
  static const String carIsSearchSuccess = 'car_search_success';
  static const String carFilterPriceMin = 'car_filter_price_min';
  static const String carFilterPriceMax = 'car_filter_price_max';
  static const String carFilterType = 'car_filter_type';
  static const String carFilterBrand = 'car_filter_brand';
  static const String carFilterSupplier = 'car_filter_supplier';
  static const String carShow = 'car_show';
  static List<String> supplierFilterList = [];
  static List<String> brandFilterList = [];
  static List<String> carTypeFilterList = [];

  static String searchPickKey = "";
  static String searchDropKey = "";
  static String searchKey = "";
}
