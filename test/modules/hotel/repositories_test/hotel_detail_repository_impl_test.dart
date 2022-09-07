import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/repositories/hotel_detail_repository_impl.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../repositories/hotel_detail_remote_datasource_impl_mock.dart';
import '../repositories/hotel_detail_remote_datasource_impl_server_mock.dart';
import '../repositories/hotel_mock_data_source.dart';
import '../repositories/internet_failure_mock.dart';
import '../repositories/internet_success_mock.dart';

void main() {
  GraphQlResponse graphQlResponseHotel = MockHotelGraphQl();
  HotelDetailRepository? hotelDetailRepository;
  HotelDetailRepository? hotelDetailRepositoryInternetFailure;
  HotelDetailRepository? hotelDetailRepositoryServerException;
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

  setUpAll(() async {
    /// Code coverage for default implementation.
    hotelDetailRepository = HotelDetailRepositoryImpl();

    /// Code coverage for mock class
    hotelDetailRepository = HotelDetailRepositoryImpl(
        remoteDataSource: HotelDetailRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetSuccessMock());

    /// Code coverage for Remote Data Source
    HotelDetailRemoteDataSourceImpl.setMock(graphQlResponseHotel);
    hotelDetailRepositoryDataRemoteSource = HotelDetailRepositoryImpl(
        remoteDataSource: HotelDetailRemoteDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    /// Code coverage for mock class
    hotelDetailRepositoryServerException = HotelDetailRepositoryImpl(
        remoteDataSource: HotelDetailRemoteDataSourceImplFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    hotelDetailRepositoryInternetFailure = HotelDetailRepositoryImpl(
        remoteDataSource: HotelDetailRemoteDataSourceImplSuccessMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'Hotel analytics Repository '
      'When calling getHotelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailRepository!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    /// Get model from mock data.
    final HotelDetailModelDomain hotel = consentResult.right;

    /// Condition check for hotel value null
    expect(hotel.getHotelDetails, null);

    /// Consent user cases impl
    final checkFavorites = await hotelDetailRepository!.checkFavouriteHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(checkFavorites.isRight, true);

    /// Consent user cases impl
    final unFavorites = await hotelDetailRepository!.unfavouritesHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(unFavorites.isRight, true);

    /// Consent user cases impl
    final addFavorites = await hotelDetailRepository!
        .addFavouriteHotel(favoriteArgumentModel: favoriteArgumentModel);

    expect(addFavorites.isRight, true);
  });
  test(
      'Hotel analytics Repository '
      'When calling getHotelUrlData '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailRepositoryInternetFailure!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    expect(consentResult.isLeft, true);

    /// Consent user cases impl
    final checkFavorites =
        await hotelDetailRepositoryInternetFailure!.checkFavouriteHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(checkFavorites.isLeft, true);

    /// Consent user cases impl
    final unFavorites =
        await hotelDetailRepositoryInternetFailure!.unfavouritesHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(unFavorites.isLeft, true);

    /// Consent user cases impl
    final addFavorites = await hotelDetailRepositoryInternetFailure!
        .addFavouriteHotel(favoriteArgumentModel: favoriteArgumentModel);

    expect(addFavorites.isLeft, true);
  });

  test(
      'Hotel analytics Repository '
      'When calling getHotelUrlData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailRepositoryServerException!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    expect(consentResult.isLeft, true);

    /// Consent user cases impl
    final checkFavorites =
        await hotelDetailRepositoryServerException!.checkFavouriteHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(checkFavorites.isLeft, true);

    /// Consent user cases impl
    final unFavorites =
        await hotelDetailRepositoryServerException!.unfavouritesHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(unFavorites.isLeft, true);

    /// Consent user cases impl
    final addFavorites = await hotelDetailRepositoryServerException!
        .addFavouriteHotel(favoriteArgumentModel: favoriteArgumentModel);

    expect(addFavorites.isLeft, true);
  });
  test(
      'Hotel Detail Remote Data Source'
      'When calling getHotelUrlData '
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailRepositoryDataRemoteSource!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    expect(consentResult.isLeft, false);
  });
}
