import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

class CarSaveSearchHistoryViewArgumentModel {
  final String? searchKey;
  final String? cityId;
  final String? countryId;
  final String? locationId;

  CarSaveSearchHistoryViewArgumentModel({
    this.searchKey,
    this.cityId,
    this.countryId,
    this.locationId,
  });

  factory CarSaveSearchHistoryViewArgumentModel.from(
          {required Item item, required String serviceType}) =>
      CarSaveSearchHistoryViewArgumentModel(
        searchKey: item.locationName,
        cityId: item.cityId,
        countryId: item.countryId,
        locationId: item.id,
      );
}
