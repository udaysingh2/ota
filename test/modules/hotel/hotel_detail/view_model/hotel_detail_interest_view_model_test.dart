import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_interest_view_model.dart';

void main() {
  test('For constructor HotelDetailInterestViewModel test', () {
    HotelDetailInterestViewModel viewModel = HotelDetailInterestViewModel(
      listOfInterest: [],
      viewState: HotelDetailInterestViewModelState.initial,
    );

    expect(viewModel.viewState, HotelDetailInterestViewModelState.initial);
    expect(viewModel.listOfInterest?.isEmpty, true);
  });

  test(
      'For class HotelDetailInterestViewModel => setSuggesionModelFromApi() test',
      () {
    HotelDetailInterestViewModel viewModel = HotelDetailInterestViewModel();

    viewModel.setSuggesionModelFromApi(getArgs());

    expect(viewModel.listOfInterest?.isNotEmpty, true);
  });
}

HotelDetailInterestData getArgs() => HotelDetailInterestData(
      data: HotelDetailInterestDataData(
        getHotelsYouMayLike: GetHotelsYouMayLike(
            data: GetHotelsYouMayLikeData(hotelList: [
          HotelList(
            hotelId: 'hotelId',
            rating: 5,
            pricePerNight: 1000.0,
            image: 'image',
            hotelName: 'hotelName',
            totalPrice: 1500.0,
            review: Review(),
            address: Address(),
            capsulePromotions: [
              CapsulePromotion(
                name: 'Free',
                code: '111',
              ),
            ],
            infoTechPromotion: [],
            adminPromotion: AdminPromotion(),
          )
        ])),
      ),
    );
