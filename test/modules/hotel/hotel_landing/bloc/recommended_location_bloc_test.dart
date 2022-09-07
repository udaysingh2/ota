import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/recommended_location_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';
import 'package:ota/common/network/failures.dart';

import 'mocks/recommended_location_data_null_mock.dart';
import 'mocks/recommended_location_failure_mock.dart';
import 'mocks/recommended_location_success_mock.dart';


void main() {
  RecommendedLocationBloc bloc = RecommendedLocationBloc();
  RecommendedLocationUseCasesImpl successMock =
      RecommendedLocationUseCasesImplSuccessMock();
  RecommendedLocationUseCasesImpl dataNullMock =
      RecommendedLocationUseCasesImplDataNullMock();
  RecommendedLocationUseCasesImpl failureMock =
      RecommendedLocationUseCasesImplFailedMock();

  test('For RecommendedLocationBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.recommendationsState, RecommendedLocationModelState.none);
    expect(actual.recommendedLocationList.isEmpty, true);
    expect(actual.recommendedLocationList.length, 0);
  });

  test('For RecommendedLocationBloc class ==> isRecommendationsEmpty', () {
    final actual = bloc.isRecommendationsEmpty;

    expect(actual, true);
  });

  test('For RecommendedLocationBloc class ==> isSuccess', () {
    final actual = bloc.isSuccess;

    expect(!actual, true);
  });

  group('For RecommendedLocationBloc class ==> getLandingRecommendations()',
      () {
    test('When "Failure" Mock data then', () async {
      ///For getRecommendedLocation data is NULL case
      bloc.recommendedLocationUseCases = failureMock;
      bloc.getLandingRecommendations();

      ///Check if getRecommendedLocation data is NULL
      Either<Failure, RecommendedLocationModelDomain>? resultFailed =
          (await failureMock.getRecommendedLocationData('hotel'));

      ///Check if result is "isLeft"
      expect(resultFailed?.isLeft, true);
      expect(bloc.state.recommendationsState,
          RecommendedLocationModelState.failure);
    });

    test('When "Success" Mock data then', () async {
      ///Before Bloc assignment with success mock data
      bloc.recommendedLocationUseCases = successMock;
      bloc.getLandingRecommendations();

      ///Before API call
      expect(bloc.state.recommendationsState,
          RecommendedLocationModelState.loading);

      Either<Failure, RecommendedLocationModelDomain>? result =
          (await successMock.getRecommendedLocationData('hotel'));

      ///Check if result is "isRight"
      expect(result?.isRight, true);
      expect(bloc.state.recommendationsState,
          RecommendedLocationModelState.success);
    });

    test('When "getRecommendedLocation data is NULL" Mock data then', () async {
      ///For getRecommendedLocation data is NULL case
      bloc.recommendedLocationUseCases = dataNullMock;
      bloc.getLandingRecommendations();

      ///Check if getRecommendedLocation data is NULL
      Either<Failure, RecommendedLocationModelDomain>? resultFailed =
          (await dataNullMock.getRecommendedLocationData('hotel'));

      expect(resultFailed?.isRight, true);
      expect(resultFailed?.right.getRecommendedLocation?.data == null, true);
    });
  });
}
