import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';

import 'suggetion_view_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

class HotelDetailInterestViewModel {
  List<SuggetionViewModel>? listOfInterest;
  HotelDetailInterestViewModelState viewState;
  HotelDetailInterestViewModel(
      {this.listOfInterest,
      this.viewState = HotelDetailInterestViewModelState.initial});
  void setSuggesionModelFromApi(HotelDetailInterestData data) {
    List<SuggetionViewModel> listOfInterest = [];
    for (HotelList hotel
        in data.data?.getHotelsYouMayLike?.data?.hotelList ?? []) {
      listOfInterest.add(SuggetionViewModel(
        imageUrl: hotel.image,
        headerText: hotel.hotelName,
        addressText: _getAddressText(
            hotel.address?.locationName, hotel.address?.cityName),
        ratingText: updateStarRating(hotel.rating ?? 0),
        reviewText: hotel.review?.numReview?.toString() ?? '',
        ratingTitle: hotel.review?.description ?? '',
        adminPromotionLine1: hotel.adminPromotion?.promotionText1 ?? '',
        adminPromotionLine2: hotel.adminPromotion?.promotionText2 ?? '',
        hotelId: hotel.hotelId,
        cityId: hotel.address?.cityId,
        countryCode: hotel.address?.countryId,
        amenitiesList: getAmenitiesList(
            hotel.capsulePromotions ?? [], hotel.infoTechPromotion ?? []),
      ));
    }
    this.listOfInterest = listOfInterest;
  }

  String _getAddressText(String? locationName, String? cityName) {
    String addressText = '';
    if (locationName != null && locationName.isNotEmpty) {
      addressText = locationName;
    }
    if (cityName != null && cityName.isNotEmpty) {
      addressText = (addressText.isNotEmpty)
          ? addressText.addTrailingComma().addTrailingSpace() + cityName
          : cityName;
    }
    return addressText;
  }

  String updateStarRating(int rating) {
    if (rating <= _kDefaultStarRating) {
      return _kDefaultStarRating.toString();
    } else if (rating >= _kMaxStarRating) {
      return _kMaxStarRating.toString();
    } else {
      return rating.toString();
    }
  }
}

List<String> getAmenitiesList(
    List<CapsulePromotion> capsulePromotion, List<String> infoTechPromotion) {
  List<String> list = [];
  for (int i = 0; i < capsulePromotion.length; i++) {
    list.add(capsulePromotion[i].name ?? '');
  }

  list.addAll(infoTechPromotion);
  return list;
}

enum HotelDetailInterestViewModelState {
  initial,
  loading,
  success,
  failure,
}
