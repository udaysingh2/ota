import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/room_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/primary_view_model.dart';

// import 'package:ota/modules/hotel/hotel_detail/view_model/review_view_model.dart';

import 'argument_model.dart';

const int _kDefaultStarRating = 1;
const int _kMaxStarRating = 5;

class HotelDetailViewModel {
  HotelDetailModel? data;
  HotelDetailViewPageState pageState;
  HotelDetailViewModel({
    required this.pageState,
    this.data,
  });
}

class HotelDetailModel {
  String? id;
  HotelDetailHeartButtonType? hotelDetailHeartButtonType;
  String? coverImageUrl;
  String? name;
  int? starRating;
  String? shortAddress;
  double? overAllRating;
  String? ratingMessage;
  String? checkInDate;
  String? checkOutDate;
  int? roomCount;
  int? guestCount;
  List<PrimaryViewModel>? roomList;
  Map<String, dynamic>? facilityList;
  Map<String, dynamic>? facilityMain;
  String? address;
  bool? isFacilityShown;
  bool? freeFoodDelivery;
  List<OtaFreeFoodPromotionModel> freeFoodPromotions = const [];
  // List<ReviewViewModel>? reviewList;
  // List<SuggetionViewModel>? suggesionList;
  HotelDetailModel({
    required this.id,
    this.starRating,
    this.name,
    this.address,
    this.checkInDate,
    this.checkOutDate,
    this.coverImageUrl,
    this.facilityList,
    this.facilityMain,
    this.guestCount,
    this.overAllRating,
    this.ratingMessage,
    // this.reviewList,
    this.roomCount,
    this.roomList,
    // this.suggesionList,
    this.shortAddress,
    this.isFacilityShown = false,
    this.freeFoodDelivery = false,
    required this.freeFoodPromotions,
  });

  ///Constructor That is used to map from the Domain level Model.
  HotelDetailModel.mapFromHotelDetail(
      Data hotelDetail, HotelDetailArgument? argument) {
    id = hotelDetail.id;
    hotelDetailHeartButtonType = hotelDetail.isFavourite == 1
        ? HotelDetailHeartButtonType.selected
        : HotelDetailHeartButtonType.unselected;
    coverImageUrl =
        "${hotelDetail.images?.baseUri}${hotelDetail.images?.cover}";
    checkInDate = argument?.checkInDate ?? "";
    checkOutDate = argument?.checkOutDate ?? "";
    roomCount = argument?.rooms.length ?? 1;
    guestCount = argument?.guestCount;
    shortAddress = hotelDetail.location;
    name = hotelDetail.name;
    ratingMessage = hotelDetail.ratingText;
    overAllRating = hotelDetail.ratingCount;
    // double.tryParse((hotelDetail.ratingCount) ?? "0");
    if (hotelDetail.rating != null) {
      starRating = int.tryParse(hotelDetail.rating!);
    }
    roomList = RoomHelper.generatePrimary(hotelDetail.rooms, data: hotelDetail);
    facilityMain = {
      for (var element in hotelDetail.facilities?.main ?? [])
        (element as ListElement).key!: (element).value
    };
    final List<ListElement> list = hotelDetail.facilities?.list ?? [];
    facilityList = {for (var element in list) (element).key!: (element).value};
    address = hotelDetail.address;
    isFacilityShown = facilitydata(facilityMain);
    freeFoodDelivery = hotelDetail.freefoodDelivery;
    freeFoodPromotions = RoomHelper.generatePromotion(hotelDetail.promotions);

    // this.reviewList = getReviewList();
    // this.suggesionList = getSuggestionList();
  }
}

int updateStarRating(int rating) {
  if (rating <= _kDefaultStarRating) {
    return _kDefaultStarRating;
  } else if (rating >= _kMaxStarRating) {
    return _kMaxStarRating;
  } else {
    return rating;
  }
}

// facilitiesDetails.list!.forEach((element) {
//     facilityList.putIfAbsent(element.key!, () => element.value);
//   });

facilitydata(Map<String, dynamic>? facilityMain) {
  if (facilityMain != null) {
    for (String value in facilityMain.values) {
      if (ShowFacilityExtension.fromString(value) == ShowFacility.shown) {
        return true;
      }
    }
  }
  return false;
}

// List<SuggetionViewModel> getSuggestionList() {
//   return [
//     SuggetionViewModel(
//       imageUrl: '',
//       addressText: 'เดินทางคนเดียว',
//       discount: '',
//       headerText: 'Monjai hotel Monjai',
//       offerPercent: '9',
//       ratingText: '4.6',
//       ratingTitle: 'Superb',
//       reviewText: '20 super',
//       adminPromotionLine1: 'admin ',
//       adminPromotionLine2: 'promotion',
//     ),
//     SuggetionViewModel(
//       imageUrl: '',
//       addressText: 'เดินทางคนเดียว',
//       discount: '50',
//       headerText: 'Monjai hotel Monjai',
//       offerPercent: '',
//       ratingText: '4.6',
//       ratingTitle: 'Superb',
//       reviewText: '20 super',
//     ),
//     SuggetionViewModel(
//       imageUrl: '',
//       addressText: 'เดินทางคนเดียว',
//       discount: '50',
//       headerText: 'Monjai hotel Monjai',
//       offerPercent: '9',
//       ratingText: '4.6',
//       ratingTitle: 'Superb',
//       reviewText: '20 super',
//       adminPromotionLine1: 'admin ',
//       adminPromotionLine2: 'promotion',
//     ),
//     SuggetionViewModel(
//       imageUrl: '',
//       addressText: 'เดินทางคนเดียว',
//       discount: '',
//       headerText: 'Monjai hotel Monjai',
//       offerPercent: '',
//       ratingText: '4.6',
//       ratingTitle: 'Superb',
//       reviewText: '20 super',
//     ),
//   ];
// }

// List<ReviewViewModel> getReviewList() {
//   return [
//     ReviewViewModel(
//       rating: 10,
//       profileName: "Wichapon M.",
//       comment: "ห้องพักบรรยากาศดีมากครับ 😍",
//       date: "22 พ.ค. 64",
//       profileCitizen: "🇹🇭ไทย",
//       profileDate: "มิถุนายน 2564",
//       profileRoomType: "Superior",
//       profileTravelType: "เดินทางคนเดียว",
//     ),
//     ReviewViewModel(
//       rating: 8,
//       profileName: "Wichapon M.",
//       comment: "ห้องพักบรรยากาศดีมากครับ 😍",
//       date: "22 พ.ค. 64",
//       profileCitizen: "🇹🇭ไทย",
//       profileDate: "มิถุนายน 2564",
//       profileRoomType: "Superior",
//       profileTravelType: "เดินทางคนเดียว",
//     ),
//     ReviewViewModel(
//       rating: 9,
//       profileName: "Wichapon M.",
//       comment: "ห้องพักบรรยากาศดีมากครับ 😍",
//       date: "22 พ.ค. 64",
//       profileCitizen: "🇹🇭ไทย",
//       profileDate: "มิถุนายน 2564",
//       profileRoomType: "Superior",
//       profileTravelType: "เดินทางคนเดียว",
//     )
//   ];
// }

enum HotelDetailViewPageState {
  initial,
  loading,
  success,
  failure,
  noRoomData,
  internetFailure,
}

enum HotelDetailHeartButtonType {
  disabled,
  selected,
  unselected,
}

enum ShowFacility { shown, notshown }

extension ShowFacilityExtension on ShowFacility {
  static ShowFacility fromString(String facility) {
    switch (facility) {
      case "0":
        return ShowFacility.notshown;
      case "1":
        return ShowFacility.shown;
      default:
        return ShowFacility.notshown;
    }
  }

  String getString() {
    switch (this) {
      case ShowFacility.shown:
        return "1";
      case ShowFacility.notshown:
        return "0";
    }
  }
}
