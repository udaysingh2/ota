import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/repositories/hotel_dynamic_playlist_repository_impl.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/usecases/hotel_dynamic_playlist_usecase.dart';

import '../../../../mocks/fixture_reader.dart';

class HotelDynamicPlayListUsecase
    implements HotelDynamicPlaylistRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  HotelDynamicPlayListRemoteDataSource? hotelDynamicPlayListRemoteDataSource;

  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>>
      getDynamicPlayListData(
          HotelDynamicPlayListDataArgumentModelDomain argument) async {
    Map<String, dynamic> map =
        json.decode(fixture("hotel_playlist/hotel_dynamic_playlist.json"));
    HotelDynamicPlayListModelDomainData sort =
        HotelDynamicPlayListModelDomainData.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("hotel dynamic playlist Use case group", () {
    test('hotel dynamic playlist Use case', () async {
      HotelDynamicPlaylistUseCasesImpl();
      HotelDynamicPlaylistUseCases hotelDynamicPlaylistUseCase =
          HotelDynamicPlaylistUseCasesImpl(
              repository: HotelDynamicPlayListUsecase());
      hotelDynamicPlaylistUseCase.getDynamicPlayListData(
          argument: HotelDynamicPlayListDataArgumentModelDomain(
        userId: "userId",
        long: 2,
        lat: 2,
        epoch: "",
        serviceName: "Hotels",
        limit: 20,
      ));
    });
  });
}
