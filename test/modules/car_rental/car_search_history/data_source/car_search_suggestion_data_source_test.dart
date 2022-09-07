import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';

void main() {
  test("Car Search Suggestion Mock Data Source", () async {
    CarSearchSuggestionMockDataSourceImpl
        carSearchSuggestionMockDataSourceImpl =
        CarSearchSuggestionMockDataSourceImpl();
    CarSearchSuggestionData suggestionData =
        await carSearchSuggestionMockDataSourceImpl.getCarSearchSuggestionData(
            CarSearchSuggestionArgumentModelDomain(
                searchCondition: '',
                searchType: [],
                limit: 0,
                serviceType: ''));
    expect(suggestionData.toMap(),
        json.decode(CarSearchSuggestionMockDataSourceImpl.getMockData()));
  });

  // test("Car Search Suggestion Remote Data Source",() async {
  //   CarSearchSuggestionRemoteDataSourceImpl carSearchSuggestionMockDataSourceImpl = CarSearchSuggestionRemoteDataSourceImpl();
  //   CarSearchSuggestionRemoteDataSourceImpl.setMock(null);
  //   try {
  //      await carSearchSuggestionMockDataSourceImpl
  //         .getCarSearchSuggestionData(CarSearchSuggestionArgumentModelDomain(
  //         searchCondition: '', searchType: [], limit: 0, serviceType: ''));
  //   }catch(e){
  //     expect(ServerException(null).runtimeType,e.runtimeType);
  //   }
  // });
}
