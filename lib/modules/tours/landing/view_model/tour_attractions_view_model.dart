import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';

class TourAttractionsViewModel {
  List<TourAttractionsModel>? tourAtrractionsList;
  TourAttractionsPageState pageState;
  TourAttractionsViewModel({
    this.tourAtrractionsList,
    this.pageState = TourAttractionsPageState.initial,
  });
}

class TourAttractionsModel {
  String serviceTitle;
  String searchKey;
  String? imageUrl;
  String cityId;
  String countryId;
  TourAttractionsModel({
    required this.serviceTitle,
    required this.searchKey,
    this.imageUrl,
    required this.cityId,
    required this.countryId,
  });

  factory TourAttractionsModel.fromAttraction(LocationList attraction) {
    return TourAttractionsModel(
      serviceTitle: attraction.serviceTitle ?? '',
      searchKey: attraction.searchKey ?? '',
      imageUrl: attraction.imageUrl,
      cityId: attraction.cityId ?? '',
      countryId: attraction.countryId ?? '',
    );
  }
}

enum TourAttractionsPageState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
}
