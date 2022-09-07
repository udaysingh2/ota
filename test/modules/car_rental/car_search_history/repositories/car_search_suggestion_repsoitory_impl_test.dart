import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';

void main() {
  test("Car Search Suggestion Repo Test With Internet Info and Remote Data Source", () {
    CarSearchSuggestionRepositoryImpl carSearchSuggestionRepositoryImpl =
        CarSearchSuggestionRepositoryImpl(internetInfo: InternetConnectionInfoImpl(),remoteDataSource: CarSearchSuggestionRemoteDataSourceImpl());
    carSearchSuggestionRepositoryImpl
        .getCarSearchSuggestionData(CarSearchSuggestionArgumentModelDomain(
            searchCondition: "", serviceType: "", searchType: [], limit: 10))
        .then((value){
          expect(value.isLeft,true);
    });
  });

  test("Car Search Suggestion Repo Test Without Internet Info and Remote Data Source", () {
    CarSearchSuggestionRepositoryImpl carSearchSuggestionRepositoryImpl =
    CarSearchSuggestionRepositoryImpl();
    carSearchSuggestionRepositoryImpl
        .getCarSearchSuggestionData(CarSearchSuggestionArgumentModelDomain(
        searchCondition: "", serviceType: "", searchType: [], limit: 10))
        .then((value){
      expect(value.isLeft,true);
    });
  });

  test("Car Search Suggestion Repo Test With No Remote Data Source", () {
    CarSearchSuggestionRepositoryImpl carSearchSuggestionRepositoryImpl =
    CarSearchSuggestionRepositoryImpl(remoteDataSource: CarSearchSuggestionRemoteDataSourceImpl());
    mockDynamicPlaylistPageData();
    carSearchSuggestionRepositoryImpl.
    getCarSearchSuggestionData(CarSearchSuggestionArgumentModelDomain(
        searchCondition: "", serviceType: "", searchType: [], limit: 10))
        .then((value){
      expect(value.isLeft,true);
      expect(value.left,InternetFailure());
    });
  });
}
