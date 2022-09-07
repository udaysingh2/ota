import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/data_soruces/hotel_detail_interest_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/repositories/hotel_detail_interest_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class _MockHotelDetailInterestDataSource
    extends HotelDetailInterestRemoteDataSource {
  @override
  Future<HotelDetailInterestData> getHotelDetailInterestData(
      HotelDetailInterestDataArgument argument) {
    Map<String, dynamic> map = json
        .decode(fixture("hotel_detail_interest/hotel_detail_interest.json"));
    return Future.value(HotelDetailInterestData.fromMap(map));
  }
}

class _MockHotelDetailInterestDataSourceException
    extends HotelDetailInterestRemoteDataSource {
  @override
  Future<HotelDetailInterestData> getHotelDetailInterestData(
      HotelDetailInterestDataArgument argument) {
    throw Future.value(Exception());
  }
}

void main() {
  group('Hotel Detail Interest Repository Test Then', () {
    test('For class HotelDetailInterestRepository Internet Success Test',
        () async {
      HotelDetailInterestRepositoryImpl();
      HotelDetailInterestRepository repository =
          HotelDetailInterestRepositoryImpl(
        internetInfo: InternetConnectionInfoMocked(),
        remoteDataSource: _MockHotelDetailInterestDataSource(),
      );

      repository.getDetailInterest(getArgs());
    });

    test('For class HotelDetailInterestRepository Failure Test', () async {
      HotelDetailInterestRepositoryImpl();
      HotelDetailInterestRepository repository =
          HotelDetailInterestRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: _MockHotelDetailInterestDataSource(),
      );

      repository.getDetailInterest(getArgs());
    });

    test('For class HotelDetailInterestRepository Exception Test', () async {
      HotelDetailInterestRepositoryImpl();

      HotelDetailInterestRepositoryImpl.setMockInternet(
          InternetConnectionInfoMocked());

      HotelDetailInterestRepository repository =
          HotelDetailInterestRepositoryImpl(
        internetInfo: InternetConnectionInfoMockedFalse(),
        remoteDataSource: _MockHotelDetailInterestDataSourceException(),
      );
      try {
        await repository.getDetailInterest(getArgs());
      } catch (error) {
        return error;
      }
    });
  });
}

HotelDetailInterestDataArgument getArgs() => HotelDetailInterestDataArgument(
      hotelId: 'hotelId',
      lat: 0.0,
      long: 0.0,
      epoch: '1122334455',
      checkInDate: '10/05/2022',
      checkOutDate: '12/05/2022',
      maxHotel: 1,
      roomCapacity: [
        RoomCapacity(
          adult: 2,
          children: 2,
          childAge1: 6,
          childAge2: 10,
        ),
      ],
    );
