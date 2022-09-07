import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_mock_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("landing dynamic playlist mock data source group", () {
    HotelDynamicPlayListRemoteDataSource hotelDynamicPlayListRemoteDataSource =
        HotelDynamicPlayListMockDataSourceImpl();
    hotelDynamicPlayListRemoteDataSource =
        HotelDynamicPlayListMockDataSourceImpl();
    HotelDynamicPlayListDataArgumentModelDomain
        hotelDynamicPlayListDataArgumentModelDomain =
        HotelDynamicPlayListDataArgumentModelDomain(
      userId: "userId",
      long: 2,
      lat: 2,
      epoch: "",
      serviceName: "Hotels",
      limit: 20,
    );

    test('Hotel landing dynamic playlist mock data source', () async {
      hotelDynamicPlayListRemoteDataSource.getHotelDynamicPlayListData(
          HotelDynamicPlayListDataArgumentModelDomain(
        userId: "userId",
        long: 2,
        lat: 2,
        epoch: "",
        serviceName: "Hotels",
        limit: 20,
      ));
    });

    test('Hotel landing dynamic playlist mock data source', () async {
      String response = HotelDynamicPlayListMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Hotel landing dynamic playlist mock data source', () async {
      String response = HotelDynamicPlayListMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
    test('Hotel landing dynamic playlist mock data source', () async {
      hotelDynamicPlayListRemoteDataSource.getHotelDynamicPlayListData(
          hotelDynamicPlayListDataArgumentModelDomain);
    });
  });
}
