import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarSearchSuggestionRemoteDataSourceFailureMock
    implements CarSearchSuggestionRemoteDataSource {
  @override
  Future<CarSearchSuggestionData> getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarSearchSuggestionRepository? carSearchSuggestionRepositoryMock;
  CarSearchSuggestionRepository? carSearchSuggestionRepositoryInternetFailure;
  CarSearchSuggestionRepository? carSearchSuggestionRepositoryServerException;
  CarSearchSuggestionArgumentModelDomain argument =
      CarSearchSuggestionArgumentModelDomain(
          searchCondition: '', serviceType: '', limit: 2, searchType: []);

  setUpAll(() async {
    /// Code coverage for default implementation.
    carSearchSuggestionRepositoryMock = CarSearchSuggestionRepositoryImpl();

    /// Code coverage for mock class
    carSearchSuggestionRepositoryMock = CarSearchSuggestionRepositoryImpl(
        remoteDataSource: CarSearchSuggestionMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carSearchSuggestionRepositoryServerException =
        CarSearchSuggestionRepositoryImpl(
            remoteDataSource: CarSearchSuggestionRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carSearchSuggestionRepositoryInternetFailure =
        CarSearchSuggestionRepositoryImpl(
            remoteDataSource: CarSearchSuggestionRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing dynamic playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carSearchSuggestionRepositoryMock!
        .getCarSearchSuggestionData(argument);

    /// Get model from mock data.
    final CarSearchSuggestionData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.getDataScienceAutoCompleteSearch != null, true);
  });

  test(
      'hotel Dynamic Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carSearchSuggestionRepositoryInternetFailure!
        .getCarSearchSuggestionData(argument);

    expect(result.isLeft, true);
  });

  test(
      'hotel Dynamic Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carSearchSuggestionRepositoryServerException!
        .getCarSearchSuggestionData(argument);

    expect(result.isLeft, true);
  });
}
