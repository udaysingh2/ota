import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_mock_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_recommendation_bloc.dart';

const String _kServiceTypeCar = 'CARRENTAL';

void main() {
  ///Use Case Success
  RecommendedLocationUseCases recommendedLocationUseCases =
      RecommendedLocationUseCasesImpl(
          repository: RecommendedLocationRepositoryImpl(
              remoteDataSource: RecommendedLocationMockDataSourceImpl()));

  CarRecommendedLocationBloc carRecommendedLocationBloc =
      CarRecommendedLocationBloc();

  test("Car Recommendation Bloc Test", () {
    carRecommendedLocationBloc.recommendedLocationUseCases =
        recommendedLocationUseCases;
    carRecommendedLocationBloc.getCarRecommendations(_kServiceTypeCar);

    expect(carRecommendedLocationBloc.state.recommendedLocationList, []);
    carRecommendedLocationBloc.dispose();
  });
}
