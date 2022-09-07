import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/playlist/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/helpers/static_playlist_helper.dart';

class StaticPlaylistViewModel {
  Map<String, List<StaticPlaylistCardViewModel>> playlistMap;
  String selectedCategory;
  StaticPlaylistViewModelState playlistState;
  StaticPlaylistViewModel({
    required this.playlistMap,
    this.selectedCategory = '',
    this.playlistState = StaticPlaylistViewModelState.none,
  });
}

class StaticPlaylistCardViewModel {
  String hotelId;
  String hotelName;
  String? rating;
  String image;
  String reviewTitle;
  String? reviewText;
  String? score;
  String? discountValue;
  String? offerValue;
  String addressText;
  String? cityId;
  String? countryId;
  String? promotionText1;
  String? promotionText2;

  StaticPlaylistCardViewModel(
      {required this.hotelId,
      required this.hotelName,
      required this.rating,
      required this.image,
      required this.reviewTitle,
      required this.reviewText,
      required this.score,
      required this.discountValue,
      required this.offerValue,
      required this.addressText,
      this.cityId,
      this.countryId,
      this.promotionText1,
      this.promotionText2});

  factory StaticPlaylistCardViewModel.fromListElement(ListElement element) {
    return StaticPlaylistCardViewModel(
      hotelId: element.hotelId ?? '',
      hotelName: element.hotelName ?? '',
      rating: StaticPlaylistHelper.updateStarRating(element.rating ?? 0),
      image: element.image ?? '',
      reviewTitle: element.review?.description ?? '',
      reviewText: element.review != null && element.review?.numReview != null
          ? element.review!.numReview.toString()
          : null,
      score: element.review != null && element.review?.score != null
          ? element.review!.score.toString()
          : null,
      discountValue: '',
      offerValue: '',
      addressText: Helpers.getAddressString(
          element.address?.locationName, element.address?.cityName),
      cityId: element.address?.cityId ?? '',
      countryId: element.address?.countryId ?? '',
      promotionText1: element.adminPromotion?.promotionText1,
      promotionText2: element.adminPromotion?.promotionText2,
    );
  }
}

enum StaticPlaylistViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
}
