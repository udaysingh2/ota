import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/repositories/car_search_suggestion_repsoitory_impl.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/usecases/car_searc_suggestion_use_cases.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';

import '../../../../mocks/fixture_reader.dart';

class CarSearchSuggestionPlayListUsecase
    implements CarSearchSuggestionRepositoryImpl {
  @override
  CarSearchSuggestionRemoteDataSource? carSearchSuggestionRemoteDataSource;

  @override
  HotelDynamicPlayListRemoteDataSource? hotelDynamicPlayListRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarSearchSuggestionData>> getCarSearchSuggestionData(
      CarSearchSuggestionArgumentModelDomain argument) async {
    Map<String, dynamic> map = json
        .decode(fixture("car_search_suggestion/car_search_suggestion.json"));
    CarSearchSuggestionData sort = CarSearchSuggestionData.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("hotel dynamic playlist Use case group", () {
    test('hotel dynamic playlist Use case', () async {
      CarSearchSuggestionUseCasesImpl();
      CarSearchSuggestionUseCases carSearchSuggestionUseCases =
          CarSearchSuggestionUseCasesImpl(
              repository: CarSearchSuggestionPlayListUsecase());
      CarSearchSuggestionArgumentModelDomain argument =
          CarSearchSuggestionArgumentModelDomain(
              searchCondition: '', serviceType: '', limit: 2, searchType: []);
      carSearchSuggestionUseCases.getCarSearchSuggestionData(
          argument: argument);
    });
  });
}
