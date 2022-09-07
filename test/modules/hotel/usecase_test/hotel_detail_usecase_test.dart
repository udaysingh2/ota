import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../repositories/hotel_detail_repository_impl_success_mock.dart';

void main() {
  HotelDetailUseCases? hotelDetailUseCases;
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
    hotelDetailUseCases = HotelDetailUseCasesImpl();

    /// Code coverage for mock class
    hotelDetailUseCases = HotelDetailUseCasesImpl(
        repository: HotelDetailRepositoryImplSuccessMock());
  });

  test(
      'Hotel analytics usecases '
      'When calling getHotelUrlData '
      'With Success response data', () async {
    /// Consent user cases impl
    final consentResult = await hotelDetailUseCases!
        .getHotelDetail(getHotelDetailDataArgumentMock());

    /// Get model from mock data.
    final HotelDetailModelDomain hotel = consentResult!.right;

    /// Condition check for hotel value null
    expect(hotel.getHotelDetails, null);

    /// Consent user cases impl
    final checkFavorites = await hotelDetailUseCases!.checkFavouriteHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(checkFavorites?.isRight, true);

    /// Consent user cases impl
    final unFavorites = await hotelDetailUseCases!.unfavouritesHotel(
      type: "type",
      hotelId: "hotelId",
    );

    expect(unFavorites?.isRight, true);

    /// Consent user cases impl
    final addFavorites = await hotelDetailUseCases!
        .addFavouriteHotel(favoriteArgumentModel: favoriteArgumentModel);

    expect(addFavorites?.isRight, true);
  });
}
