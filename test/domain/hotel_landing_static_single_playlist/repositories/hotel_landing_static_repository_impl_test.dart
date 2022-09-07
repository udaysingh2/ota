import 'dart:convert';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/data_sources/hotel_landing_static_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/repositories/hotel_landing_static_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';
import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelLandingStaticSingleDataArgument argument =
      HotelLandingStaticSingleDataArgument(
          playlistId: "playlistId", userId: "userId");
  HotelLandingStaticRepository? hotelLandingStaticRepositoryException;
  HotelLandingStaticRepository? hotelLandingStaticRepositoryMock;
  HotelLandingStaticRepository? hotelLandingStaticRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelLandingStaticRepositoryMock = HotelLandingStaticRepositoryImpl();

    /// Code coverage for mock class
    hotelLandingStaticRepositoryMock = HotelLandingStaticRepositoryImpl(
        remoteDataSource: HotelLandingStaticDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    hotelLandingStaticRepositoryException = HotelLandingStaticRepositoryImpl(
        remoteDataSource: HotelLandingStaticDataSourceImplFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelLandingStaticRepositoryInternetFailure =
        HotelLandingStaticRepositoryImpl(
            remoteDataSource: HotelLandingStaticDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock());
  });
  test(
      'Hotel Landing Static Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelLandingStaticRepositoryMock!.getPlaylist(argument);

    /// Get model from mock data.
    final HotelLandingStaticSingleData? model = consentResult.right;

    /// Condition check for hotel value null
    expect(model?.getPlaylists != null, true);
  });

  test(
      'Hotel Landing Static Repository'
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelLandingStaticRepositoryInternetFailure!
        .getPlaylist(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'Hotel Landing Static Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final playlistResult =
        await hotelLandingStaticRepositoryException!.getPlaylist(argument);

    expect(playlistResult.isLeft, true);
  });
}

class HotelLandingStaticDataSourceImplFailureMock
    implements HotelLandingStaticDataSource {
  @override
  Future<HotelLandingStaticSingleData> getPlaylist(argument) {
    throw exp.ServerException(null);
  }
}

class HotelLandingStaticDataSourceImplSuccessMock
    implements HotelLandingStaticDataSource {
  @override
  Future<HotelLandingStaticSingleData> getPlaylist(argument) async {
    Map<String, dynamic> map = json.decode(fixture(
        "hotel/hotel_landing_playlist/hotel_landing_static_playlist.json"));

    ///Convert into Model
    HotelLandingStaticSingleData model =
        HotelLandingStaticSingleData.fromMap(map);
    return model;
  }
}
