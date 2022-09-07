import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_room_info_view_model.dart';

import '../../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';

class YourListViewModel {
  String hotelName;
  String roomTitle;
  int nights;
  String imageUrl;
  List<RoomDetails> categoriesList;
  List<FacilityList> facilitiesList;
  String price;
  String totalPrice;
  bool isRoomAvailable;
  String cancellationPolicy;
  String bookingUrn;
  List<OtaCancellationPolicyListModel> cancellationPolicyList;
  YourListViewModelState yourListViewModelState;
  String address;
  String rating;
  List<OtaPromotionModel> specialPromotionDetailList;
  List<OtaFreeFoodPromotionModel> freeFoodPromotions;

  factory YourListViewModel() {
    return YourListViewModel._name("", "", 0, [], [], "0", "",
        YourListViewModelState.initial, true, "", "0", "", [], "", "", [], []);
  }

  YourListViewModel._name(
    this.hotelName,
    this.roomTitle,
    this.nights,
    this.categoriesList,
    this.facilitiesList,
    this.price,
    this.imageUrl,
    this.yourListViewModelState,
    this.isRoomAvailable,
    this.cancellationPolicy,
    this.totalPrice,
    this.bookingUrn,
    this.cancellationPolicyList,
    this.address,
    this.rating,
    this.specialPromotionDetailList,
    this.freeFoodPromotions,
  );
}

enum YourListViewModelState {
  initial,
  loading,
  loaded,
  failed,
  internetFailure,
}
