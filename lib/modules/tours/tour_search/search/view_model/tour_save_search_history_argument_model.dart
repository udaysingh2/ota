import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_suggestions_view_model.dart';

class TourSaveSearchHistoryArgumentModel {
  final String? serviceType;
  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? id;
  final String? locationName;

  TourSaveSearchHistoryArgumentModel({
    this.serviceType,
    this.keyword,
    this.countryId,
    this.cityId,
    this.id,
    this.locationName,
  });

  factory TourSaveSearchHistoryArgumentModel.from(
          {required Item item, required String serviceType}) =>
      TourSaveSearchHistoryArgumentModel(
        serviceType: serviceType,
        keyword: item.keyword,
        countryId: item.countryId,
        cityId: item.cityId,
        id: item.id,
        locationName: item.locationName,
      );
}
