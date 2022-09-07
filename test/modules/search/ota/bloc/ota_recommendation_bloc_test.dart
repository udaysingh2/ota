import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';
import 'package:ota/domain/search/usecases/search_recommendation_use_cases.dart';
import 'package:ota/modules/search/ota/bloc/ota_recommendation_bloc.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../hotel/repositories/search_remote_datasource_impl_failure_mock.dart';
import '../../hotel/repositories/search_remote_repository_null_impl_mock.dart';
import '../../hotel/repositories/search_repository_impl_success_mock.dart';

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

  OtaRecommendationBloc searchRecommendationBloc = OtaRecommendationBloc();

  test("Ota Recommendation Bloc Test", () {
    ///default
    expect(searchRecommendationBloc.state.recommendationState,
        OtaRecommendationViewModelState.none);

    // /Case when full data available
    searchRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCases;
    searchRecommendationBloc.fetchRecommendationData();
    expect(searchRecommendationBloc.state.recommendationState,
        OtaRecommendationViewModelState.loading);
  });
  test("Ota Recommendation Bloc Null Data Test", () {
    // /Case of Failure null data
    searchRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCasesNullImpl;
    searchRecommendationBloc.fetchRecommendationData();
    expect(searchRecommendationBloc.state.recommendationState,
        OtaRecommendationViewModelState.loading);
  });

  test("Ota Recommendation Failure Data test", () {
    ///Case of Failure
    searchRecommendationBloc.recommendationUseCases =
        searchRecommendationUseCasesFailureImpl;
    searchRecommendationBloc.fetchRecommendationData();
    expect(searchRecommendationBloc.state.recommendationState,
        OtaRecommendationViewModelState.loading);
  });
}
