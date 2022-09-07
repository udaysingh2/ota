import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';

class CarSaveSearchHistoryArgumentDomain {
  String searchKey;
  String cityId;
  String locationId;
  String countryId;

  CarSaveSearchHistoryArgumentDomain({
    required this.searchKey,
    required this.cityId,
    required this.countryId,
    required this.locationId,
  });

  factory CarSaveSearchHistoryArgumentDomain.from(
      {required CarSaveSearchHistoryViewArgumentModel argumentModel}) {
    return CarSaveSearchHistoryArgumentDomain(
      searchKey: argumentModel.searchKey!,
      cityId: argumentModel.cityId ?? '',
      countryId: argumentModel.countryId ?? '',
      locationId: argumentModel.locationId ?? '',
    );
  }
}
