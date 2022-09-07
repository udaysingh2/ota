import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';
import 'package:ota/domain/search/usecases/search_recommendation_use_cases.dart';
import 'package:ota/modules/search/hotel/bloc/hotel_recommendation_bloc.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../repositories/search_remote_datasource_impl_failure_mock.dart';
import '../repositories/search_remote_repository_null_impl_mock.dart';
import '../repositories/search_repository_impl_success_mock.dart';

void main() {
  ///Use Case Success
  SearchRecommendationUseCases searchRecommendationUseCases =
      SearchRecommendationUseCasesImpl(
          repository: SearchRepositoryImplSuccessMock());

  ///Use Case Success with null data
  SearchRecommendationUseCases searchRecommendationUseCasesNullImpl =
      SearchRecommendationUseCasesImpl(
          repository: SearchRepositoryImplNullDataMock());

  ///Failure Usecase
  SearchRecommendationUseCases searchRecommendationUseCasesFailureImpl =
      SearchRecommendationUseCasesImpl(
          repository: SearchRepositoryImpl(
              remoteDataSource: SearchRemoteDataSourceFailureMock(),
              internetInfo: InternetFailureMock()));

  HotelRecommendationBloc hotelRecommendationBloc = HotelRecommendationBloc();

  test("Hotel Recommendation Bloc Test", () {
    ///default
    expect(hotelRecommendationBloc.state.recommendationState,
        HotelRecommendationViewModelState.none);

    // /Case when full data available
    hotelRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCases;
    hotelRecommendationBloc.fetchRecommendationData();
    expect(hotelRecommendationBloc.state.recommendationState,
        HotelRecommendationViewModelState.loading);
  });
  test("Hotel Recommendation Bloc Null Data Test", () {
    // /Case of Failure null data
    hotelRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCasesNullImpl;
    hotelRecommendationBloc.fetchRecommendationData();
    expect(hotelRecommendationBloc.state.recommendationState,
        HotelRecommendationViewModelState.loading);
  });

  test("Hotel Recommendation Failure Data test", () {
    ///Case of Failure
    hotelRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCasesFailureImpl;
    hotelRecommendationBloc.fetchRecommendationData();
    expect(hotelRecommendationBloc.state.recommendationState,
        HotelRecommendationViewModelState.loading);
  });
}
