import 'package:ota/modules/tours/tour_search/search/view_model/tour_save_search_history_argument_model.dart';

class TourSaveSearchHistoryArgumentDomain {
  String serviceType;
  String keyword;
  String countryId;
  String cityId;
  String id;
  String locationName;

  TourSaveSearchHistoryArgumentDomain({
    required this.serviceType,
    required this.keyword,
    required this.countryId,
    required this.cityId,
    required this.id,
    required this.locationName,
  });

  factory TourSaveSearchHistoryArgumentDomain.from(
      {required TourSaveSearchHistoryArgumentModel argumentModel}) {
    return TourSaveSearchHistoryArgumentDomain(
      serviceType: argumentModel.serviceType!,
      keyword: argumentModel.keyword!,
      countryId: argumentModel.countryId ?? '',
      cityId: argumentModel.cityId ?? '',
      id: argumentModel.id ?? '',
      locationName: argumentModel.locationName ?? '',
    );
  }
}
