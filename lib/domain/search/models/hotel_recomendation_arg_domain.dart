import 'package:ota/domain/search/models/search_service_type.dart';

class HotelRecommendationArgDomain {
  final double latitude;
  final double longitude;
  final SearchServiceType searchServiceType;
  final int offset;
  final int limit;

  HotelRecommendationArgDomain({
    required this.latitude,
    required this.longitude,
    required this.searchServiceType,
    required this.offset,
    required this.limit,
  });

  factory HotelRecommendationArgDomain.fromHotelSuggestion(
      double latitude, double longitude, int offset, int limit) {
    return HotelRecommendationArgDomain(
      latitude: latitude,
      longitude: longitude,
      searchServiceType: SearchServiceType.hotel,
      offset: offset,
      limit: limit,
    );
  }
}
