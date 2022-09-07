class TourSearchArgumentModel {
  List<TourAttractionModel> attractionList;

  TourSearchArgumentModel({
    required this.attractionList,
  });
}

class TourAttractionModel {
  TourAttractionModel({
    required this.serviceTitle,
    required this.searchKey,
    this.imageUrl,
    required this.cityId,
    required this.countryId,
  });

  final String serviceTitle;
  final String searchKey;
  final String? imageUrl;
  final String cityId;
  final String countryId;
}
