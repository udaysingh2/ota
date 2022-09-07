import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/repositories/hotel_static_playlist_repository_impl.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/usecases/hotel_static_playlist_usecase.dart';

import '../../../../mocks/fixture_reader.dart';

class HotelStaticPlayListUsecase implements HotelStaticPlaylistUseCasesImpl {
  InternetConnectionInfo? internetConnectionInfo;

  HotelStaticPlayListRemoteDataSource? hotelStaticPlayListRemoteDataSource;

  @override
  HotelStaticPlayListRepository? hotelStaticPlayListRepository;

  @override
  Future<Either<Failure, HotelStaticPlayListModelDomain>?>
      getHotelStaticPlayListData(
          {HotelStaticPlayListArgumentModelDomain? argument}) async {
    Map<String, dynamic> map =
        json.decode(fixture("hotel_playlist/hotel_static_playlist.json"));
    HotelStaticPlayListModelDomain sort =
        HotelStaticPlayListModelDomain.fromMap(map);
    return Right(sort);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("hotel static playlist Use case group", () {
    test('hotel static playlist Use case', () async {
      HotelStaticPlaylistUseCasesImpl();
      HotelStaticPlaylistUseCases hotelStaticPlaylistUseCases =
          HotelStaticPlaylistUseCasesImpl();
      hotelStaticPlaylistUseCases.getHotelStaticPlayListData(
          argument: HotelStaticPlayListArgumentModelDomain(
        userId: '',
        lat: 0.0,
        long: 0.0,
        epoch: '',
      ));
    });
  });
}
