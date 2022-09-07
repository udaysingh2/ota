import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/models/hotel_landing_dynamic_data_model.dart'
    as dynamic_model;
import 'package:ota/domain/hotel/hotel_landing_static_single_playlist/models/hotel_landing_static_data_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

class PlaylistViewModel {
  List<PlaylistCardViewModel> playlist;
  String selectedCategory;
  PlaylistViewModelState playlistState;
  int offset;

  PlaylistViewModel({
    required this.playlist,
    this.selectedCategory = '',
    this.offset = 1,
    this.playlistState = PlaylistViewModelState.none,
  });
}

class PlaylistCardViewModel {
  String hotelId;
  String hotelName;
  String rating;
  String image;
  String reviewTitle;
  String reviewText;
  String score;
  String discountValue;
  String offerValue;
  String addressText;
  String cityId;
  String countryId;
  String promotionText1;
  String promotionText2;
  String locationName;
  List<String> aminities;
  factory PlaylistCardViewModel.fromStaticPlayList(StaticCardList item) {
    return PlaylistCardViewModel(
        addressText: item.locationName ?? "",
        cityId: item.cityId ?? "",
        countryId: item.countryId ?? "",
        discountValue: "",
        hotelId: item.id ?? "",
        hotelName: item.name ?? "",
        image: item.imageUrl ?? "",
        offerValue: "",
        promotionText1: item.promotionTextLine1 ?? "",
        promotionText2: item.promotionTextLine2 ?? "",
        rating: updateStarRating(item.rating ?? 0).toString(),
        reviewText: item.review?.numReview.toString() ?? "",
        reviewTitle: item.review?.description ?? "",
        locationName: item.locationName ?? "",
        aminities:
            List<String>.generate(item.capsulePromotion?.length ?? 0, (index) {
          return item.capsulePromotion?.elementAt(index).name ?? "";
        }),
        score: item.review?.score?.toString() ?? "0");
  }

  static String updateStarRating(int rating) {
    if (rating <= _kDefaultStarRating) {
      return _kDefaultStarRating.toString();
    } else if (rating >= _kMaxStarRating) {
      return _kMaxStarRating.toString();
    } else {
      return rating.toString();
    }
  }

  static List<String> getAmenitiesList(
      List<dynamic_model.CapsulePromotion> capsulePromotion,
      List<dynamic_model.InfoPromotion> infopromotion) {
    List<String> list = [];
    list = List<String>.generate(capsulePromotion.length, (index) {
      return capsulePromotion.elementAt(index).name ?? "";
    });
    List<String> infopromotionList =
        List<String>.generate(infopromotion.length, (index) {
      return infopromotion.elementAt(index).promotionText ?? "";
    });
    list.addAll(infopromotionList);
    return list;
  }

  factory PlaylistCardViewModel.fromDynamicPlayList(
      dynamic_model.DynamicCardList item) {
    return PlaylistCardViewModel(
        addressText: item.locationName ?? "",
        cityId: item.cityId ?? "",
        countryId: item.countryId ?? "",
        discountValue: "",
        hotelId: item.id ?? "",
        hotelName: item.name ?? "",
        image: item.imageUrl ?? "",
        offerValue: "",
        promotionText1: item.promotionTextLine1 ?? "",
        promotionText2: item.promotionTextLine2 ?? "",
        rating: updateStarRating(item.rating ?? 0).toString(),
        reviewText: item.review?.numReview.toString() ?? "",
        reviewTitle: item.review?.description ?? "",
        locationName: item.locationName ?? "",
        aminities: getAmenitiesList(
            item.capsulePromotion ?? [], item.infopromotion ?? []),
        score: item.review?.score?.toString() ?? "0");
  }
  factory PlaylistCardViewModel.getTestData() {
    return PlaylistCardViewModel(
        addressText: "AddressText",
        cityId: "cityId",
        countryId: "countryId",
        discountValue: "2",
        hotelId: "hotelId",
        hotelName: "hotelName",
        image: "image",
        offerValue: "2",
        promotionText1: "p1",
        promotionText2: "p2",
        rating: "4",
        reviewText: "review",
        reviewTitle: "revtitle",
        locationName: "locationName",
        aminities: ["amini1", "amini2"],
        score: "5");
  }
  PlaylistCardViewModel(
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
      required this.cityId,
      required this.countryId,
      required this.aminities,
      required this.locationName,
      required this.promotionText1,
      required this.promotionText2});
}

enum PlaylistViewModelState {
  none,
  loading,
  success,
  failure,
  internetFailure,
}
