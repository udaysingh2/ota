import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../repositories/hotel_mock_data_source.dart';
import '../repositories/internet_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponseHotel = MockHotelGraphQl();
  HotelDetailDataArgument argument = getHotelDetailDataArgumentMock();
  HotelDetailRepository? hotelDetailRepositoryDataRemoteSource;
  AddFavoriteArgumentModelDomain favoriteArgumentModel =
      AddFavoriteArgumentModelDomain(
    hotelId: "hotelId",
    cityId: "cityId",
    countryId: "countryId",
    hotelName: "hotelName",
    location: "location",
    hotelImage: "hotelImage",
  );
  HotelDetailRemoteDataSourceImpl.setMock(graphQlResponseHotel);
  hotelDetailRepositoryDataRemoteSource = HotelDetailRepositoryImpl(
      remoteDataSource: HotelDetailRemoteDataSourceImpl(),
      internetInfo: InternetSuccessMock());
  test("Hotel Detail Data Source", () {
    HotelDetailRemoteDataSource hotelDetailRemoteDataSource =
        HotelDetailRemoteDataSourceImpl();
    HotelDetailRemoteDataSourceImpl.setMock(graphQlResponseHotel);

    hotelDetailRemoteDataSource.getHotelDetail(argument);
    hotelDetailRemoteDataSource.checkFavouriteHotel(
        type: "Hotel", hotelId: "hotelId");
    hotelDetailRemoteDataSource.unfavouritesHotel(
        type: "Hotel", hotelId: "hotelId");
    hotelDetailRemoteDataSource.addFavouriteHotel(
        favoriteArgumentModel: favoriteArgumentModel);
  });
  test(
      'Hotel Detail Remote Data Source'
      'When calling getHotelUrlData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailRepositoryDataRemoteSource!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    expect(consentResult.isLeft, false);

    /// Consent user cases impl
    final checkFavorites =
        await hotelDetailRepositoryDataRemoteSource.checkFavouriteHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(checkFavorites.isLeft, false);

    /// Consent user cases impl
    final unFavorites =
        await hotelDetailRepositoryDataRemoteSource.unfavouritesHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(unFavorites.isLeft, false);

    /// Consent user cases impl
    final addFavorites = await hotelDetailRepositoryDataRemoteSource
        .addFavouriteHotel(favoriteArgumentModel: favoriteArgumentModel);

    expect(addFavorites.isLeft, false);
  });
}
