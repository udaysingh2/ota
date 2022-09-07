import 'dart:convert';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/data_sources/hotel_landing_dynamic_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/repositories/hotel_landing_dynamic_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';
import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelLandingDynamicSingleDataArgument argument =
      HotelLandingDynamicSingleDataArgument(
          playlistId: "playlistId", userId: "userId");
  HotelLandingDynamicRepository? hotelLandingDynamicRepositoryException;
  HotelLandingDynamicRepository? hotelLandingDynamicRepositoryMock;
  HotelLandingDynamicRepository? hotelLandingDynamicRepositoryInternetFailure;

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelLandingDynamicRepositoryMock = HotelLandingDynamicRepositoryImpl();

    /// Code coverage for mock class
    hotelLandingDynamicRepositoryMock = HotelLandingDynamicRepositoryImpl(
        remoteDataSource: HotelLandingDynamicDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Server Exception
    hotelLandingDynamicRepositoryException = HotelLandingDynamicRepositoryImpl(
        remoteDataSource: HotelLandingDynamicDataSourceImplFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelLandingDynamicRepositoryInternetFailure =
        HotelLandingDynamicRepositoryImpl(
            remoteDataSource: HotelLandingDynamicDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock());
  });
  test(
      'Hotel Landing Dynamic Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelLandingDynamicRepositoryMock!.getPlaylist(argument);

    /// Get model from mock data.
    final HotelLandingDynamicSingleData? model = consentResult.right;

    /// Condition check for hotel value null
    expect(model?.getPlaylists != null, true);
  });

  test(
      'Hotel Landing Dynamic Repository'
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelLandingDynamicRepositoryInternetFailure!
        .getPlaylist(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'Hotel Landing Dynamic Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final playlistResult =
        await hotelLandingDynamicRepositoryException!.getPlaylist(argument);

    expect(playlistResult.isLeft, true);
  });
}

class HotelLandingDynamicDataSourceImplFailureMock
    implements HotelLandingDynamicDataSource {
  @override
  Future<HotelLandingDynamicSingleData> getPlaylist(argument) {
    throw exp.ServerException(null);
  }
}

class HotelLandingDynamicDataSourceImplSuccessMock
    implements HotelLandingDynamicDataSource {
  @override
  Future<HotelLandingDynamicSingleData> getPlaylist(argument) async {
    Map<String, dynamic> map = json.decode(fixture(
        "hotel/hotel_landing_playlist/hotel_landing_dynamic_playlist.json"));

    ///Convert into Model
    HotelLandingDynamicSingleData model =
        HotelLandingDynamicSingleData.fromMap(map);
    return model;
  }
}
