import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

class RecommendedLocationRemoteDataSourceImplFailureMock
    implements RecommendedLocationRemoteDataSource {
  @override
  Future<RecommendedLocationModelDomain> getRecommendedLocationData(
      String serviceType) {
    throw exp.ServerException(null);
  }
}
