import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/repositories/car_search_history_repository.dart';
import 'package:ota/domain/car_rental/car_search_history/usecases/car_search_history_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_history/bloc/car_search_history_bloc.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_search_history_view_model.dart';

import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  test("Car search history bloc test ", () {
    final CarSearchHistoryBloc carSearchHistoryBloc = CarSearchHistoryBloc();
    carSearchHistoryBloc.fetchCarSearchHistoryData();
    expect(carSearchHistoryBloc.isSearchHistoryEmpty, true);
  });

  test("Car search history bloc test with view model", () {
    CarSearchHistoryViewModel model =
        CarSearchHistoryViewModel(searchHistoryList: [
      CarRentalSearchHistoryModel(
          cityId: "cityId",
          countryId: "countryId",
          createdDate: "createdDate",
          keyword: "keyword",
          placeId: "placeId")
    ]);
    final CarSearchHistoryBloc carSearchHistoryBloc = CarSearchHistoryBloc();

    CarSearchHistoryUseCasesImpl searchHistoryUseCases =
        CarSearchHistoryUseCasesImpl(
      repository: CarSearchHistoryRepositoryImpl(
        remoteDataSource: CarSearchHistoryMockDataSourceImpl(),
        internetInfo: InternetFailureMock(),
      ),
    );
    carSearchHistoryBloc.searchHistoryUseCases = searchHistoryUseCases;
    carSearchHistoryBloc.fetchCarSearchHistoryData();
    carSearchHistoryBloc.emit(model);
  });

  test("Car search history bloc ..", () {
    final CarSearchHistoryBloc carSearchHistoryBloc = CarSearchHistoryBloc();
    CarSearchHistoryUseCasesImpl searchUseCases = CarSearchHistoryUseCasesImpl(
      repository: CarSearchHistoryRepositoryImpl(
        remoteDataSource: CarSearchHistoryRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(
                result: jsonDecode(
                    fixture("car_search_history/car_search_history.json")))),
        internetInfo: InternetSuccessMock(),
      ),
    );
    carSearchHistoryBloc.searchHistoryUseCases = searchUseCases;

    carSearchHistoryBloc.dispose();
  });
}
