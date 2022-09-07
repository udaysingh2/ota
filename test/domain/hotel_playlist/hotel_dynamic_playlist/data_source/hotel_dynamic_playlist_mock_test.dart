import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/repositories/hotel_dynamic_playlist_repository_impl.dart';

import '../../../../modules/hotel/repositories/internet_success_mock.dart';
import '../repositories/hotel_dynamic_impl_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponsePlayList = MockHotelStatusGraphQl();
  HotelDynamicPlayListRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
  HotelDynamicPlaylistRepository hotelDynamicPlaylistRepository =
      HotelDynamicPlaylistRepositoryImpl(
          remoteDataSource: HotelDynamicPlayListRemoteDataSourceImpl(),
          internetInfo: InternetSuccessMock());

  test("hotel landing dynamic Data Source", () {
    HotelDynamicPlayListRemoteDataSource hotelDynamicPlayListRemoteDataSource =
        HotelDynamicPlayListRemoteDataSourceImpl();

    HotelDynamicPlayListRemoteDataSourceImpl.setMock(graphQlResponsePlayList);
    hotelDynamicPlayListRemoteDataSource.getHotelDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain(
        userId: "userId",
        long: 2,
        lat: 2,
        epoch: "",
        serviceName: "Hotels",
        limit: 20,
      ),
    );
  });
  test(
      'Hotel dynamic playlist  Repository '
      'When calling getPlaylistDta '
      'With response data', () async {
    /// Consent user cases impl
    final consentResult =
        await hotelDynamicPlaylistRepository.getDynamicPlayListData(
      HotelDynamicPlayListDataArgumentModelDomain(
        userId: "userId",
        long: 2,
        lat: 2,
        epoch: "1654591450",
        serviceName: "Hotels",
        limit: 20,
      ),
    );

    expect(consentResult.isRight, true);
  });
}
