class TourDetailArgumentDomain {
  String tourId;
  String countryId;
  String cityId;
  String tourDate;
  TourDetailArgumentDomain({
    required this.tourId,
    required this.countryId,
    required this.cityId,
    required this.tourDate,
  });

  factory TourDetailArgumentDomain.from(
      String cityId, String countryId, String tourId, String date) {
    return TourDetailArgumentDomain(
      cityId: cityId,
      countryId: countryId,
      tourId: tourId,
      tourDate: date,
    );
  }
}
