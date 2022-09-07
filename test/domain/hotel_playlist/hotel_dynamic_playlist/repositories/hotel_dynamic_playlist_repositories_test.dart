import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_mock_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/repositories/hotel_dynamic_playlist_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelDynamicPlaylistRemoteDataSourceFailureMock
    implements HotelDynamicPlayListRemoteDataSource {
  @override
  Future<HotelDynamicPlayListModelDomainData> getHotelDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain argument) {
    throw exp.ServerException(null);
  }
}

void main() {
  HotelDynamicPlaylistRepository? hotelDynamicPlaylistRepositoryMock;
  HotelDynamicPlaylistRepository? hotelDynamicPlaylistRepositoryInternetFailure;
  HotelDynamicPlaylistRepository? hotelDynamicPlaylistRepositoryServerException;
  HotelDynamicPlayListDataArgumentModelDomain argument =
      HotelDynamicPlayListDataArgumentModelDomain(
    userId: "userId",
    long: 2,
    lat: 2,
    epoch: "",
    serviceName: "Hotels",
    limit: 20,
  );

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelDynamicPlaylistRepositoryMock = HotelDynamicPlaylistRepositoryImpl();

    /// Code coverage for mock class
    hotelDynamicPlaylistRepositoryMock = HotelDynamicPlaylistRepositoryImpl(
        remoteDataSource: HotelDynamicPlayListMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    hotelDynamicPlaylistRepositoryServerException =
        HotelDynamicPlaylistRepositoryImpl(
            remoteDataSource: HotelDynamicPlaylistRemoteDataSourceFailureMock(),
            internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelDynamicPlaylistRepositoryInternetFailure =
        HotelDynamicPlaylistRepositoryImpl(
            remoteDataSource: HotelDynamicPlaylistRemoteDataSourceFailureMock(),
            internetInfo: InternetFailureMock());
  });

  test(
      'Hotel landing dynamic playlist Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await hotelDynamicPlaylistRepositoryMock!
        .getDynamicPlayListData(argument);

    /// Get model from mock data.
    final HotelDynamicPlayListModelDomainData bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.getRecentViewPlaylist != null, true);
  });

  test(
      'hotel Dynamic Playlist Repository Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await hotelDynamicPlaylistRepositoryInternetFailure!
        .getDynamicPlayListData(argument);

    expect(result.isLeft, true);
  });

  test(
      'hotel Dynamic Playlist Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await hotelDynamicPlaylistRepositoryServerException!
        .getDynamicPlayListData(argument);

    expect(result.isLeft, true);
  });
}
