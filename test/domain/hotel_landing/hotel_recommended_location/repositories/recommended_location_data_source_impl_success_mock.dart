import 'dart:convert';

import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class RecommendedLocationRemoteDataSourceImplSuccessMock
    implements RecommendedLocationRemoteDataSource {
  @override
  Future<RecommendedLocationModelDomain> getRecommendedLocationData(
      String serviceType) async {
    Map<String, dynamic> map = json.decode(fixture(
        "hotel_landing/hotel_recommended_location/hotel_recommend.json"));

    ///Convert into Model
    RecommendedLocationModelDomain model =
        RecommendedLocationModelDomain.fromMap(map);
    return model;
  }
}
