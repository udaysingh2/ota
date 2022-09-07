import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/repositories/hotel_static_playlist_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelStaticPlaylistRemoteDataSourceFailureMock
    implements HotelStaticPlayListRemoteDataSource {
  @override
  Future<HotelStaticPlayListModelDomain> getHotelStaticPlayListData(
      HotelStaticPlayListArgumentModelDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HotelStaticPlayListRepository? hotelStaticPlayListRepositoryMock;
  HotelStaticPlayListRepository? hotelStaticPlayListRepositoryInternetFailure;
  HotelStaticPlayListRepository? hotelStaticPlayListRepositoryServerException;
  HotelStaticPlayListArgumentModelDomain argument =
      HotelStaticPlayListArgumentModelDomain(
          userId: "aa",
          lat: 0.0,
          long: 0.0,
          epoch: "aaa",
          source: "static",
          serviceName: "HOTEL");

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelStaticPlayListRepositoryMock = HotelStaticPlayListRepositoryImpl();

    /// Code coverage for mock class
    hotelStaticPlayListRepositoryMock = HotelStaticPlayListRepositoryImpl(
        remoteDataSource: HotelStaticPlayListRemoteDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    hotelStaticPlayListRepositoryServerException =
        HotelStaticPlayListRepositoryImpl(
            remoteDataSource: HotelStaticPlaylistRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelStaticPlayListRepositoryInternetFailure =
        HotelStaticPlayListRepositoryImpl(
            remoteDataSource: HotelStaticPlaylistRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing static playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelStaticPlayListRepositoryMock!
        .getHotelStaticPlayListData(argument);

    /// Get model from mock data.
    expect(consentResult.isLeft, true);

    /// Condition check for booking data value null
  });

  test(
      'hotel static Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelStaticPlayListRepositoryInternetFailure!
        .getHotelStaticPlayListData(argument);

    expect(consentResult.isLeft, true);
  });

  test(
      'hotel static Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelStaticPlayListRepositoryServerException!
        .getHotelStaticPlayListData(argument);

    expect(consentResult.isLeft, true);
  });
}
