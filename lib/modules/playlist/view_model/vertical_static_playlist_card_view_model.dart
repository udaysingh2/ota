import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';

class VerticalStaticPlayListCardViewModel {
  String productType;
  HotelVerticalCardViewModel? hotel;
  TourVerticalCardViewModel? tour;
  TourVerticalCardViewModel? ticket;
  CarVerticalCardViewModel? car;

  VerticalStaticPlayListCardViewModel({
    required this.productType,
    this.hotel,
    this.tour,
    this.ticket,
    this.car,
  });

  factory VerticalStaticPlayListCardViewModel.fromCardList(
      OtaStaticCardList list) {
    return VerticalStaticPlayListCardViewModel(
      productType: list.productType!,
      hotel: list.hotel != null
          ? HotelVerticalCardViewModel.fromCard(list.hotel!)
          : null,
      tour: list.tour != null
          ? TourVerticalCardViewModel.fromCard(list.tour!)
          : null,
      ticket: list.ticket != null
          ? TourVerticalCardViewModel.fromCard(list.ticket!)
          : null,
      car: list.car != null
          ? CarVerticalCardViewModel.fromCard(list.car!)
          : null,
    );
  }
}
