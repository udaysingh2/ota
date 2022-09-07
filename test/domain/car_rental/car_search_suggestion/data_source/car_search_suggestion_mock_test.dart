import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/car_search_suggestion_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList =
      MockCarSearchSuggestionStatusGraphQl();
  CarSearchSuggestionArgumentModelDomain argument =
      CarSearchSuggestionArgumentModelDomain(
          searchCondition: '', serviceType: '', limit: 2, searchType: []);
  CarSearchSuggestionRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  CarSearchSuggestionRepository carSearchSuggestionRepository =
      CarSearchSuggestionRepositoryImpl(
          remoteDataSource: CarSearchSuggestionRemoteDataSourceImpl(),
          internetInfo: InternetSuccessMock());

  test("car search suggestion Data Source", () {
    CarSearchSuggestionRemoteDataSource carSearchSuggestionRemoteDataSource =
        CarSearchSuggestionRemoteDataSourceImpl();

    CarSearchSuggestionRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
    carSearchSuggestionRemoteDataSource.getCarSearchSuggestionData(argument);
  });
  test(
      'car search suggestion  Repository '
      'When calling get car search suggestion data '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult = await carSearchSuggestionRepository
        .getCarSearchSuggestionData(argument);

    expect(consentResult.isRight, true);
  });
}
