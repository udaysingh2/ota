import 'package:ota/domain/static_playlist/models/static_playlist_model_domain.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';

class LandingStaticPlayListCardViewModel {
  StaticPlayListModelEnum? modelEnum;
  String productType;
  HotelCardViewModel? hotel;
  TourCardViewModel? tour;
  TourCardViewModel? ticket;
  CarRentalViewModel? carRental;
  LandingStaticPlayListCardViewModel({
    this.modelEnum,
    required this.productType,
    this.hotel,
    this.tour,
    this.ticket,
    this.carRental,
  });

  factory LandingStaticPlayListCardViewModel.fromCardList(
      OtaStaticCardList list) {
    return LandingStaticPlayListCardViewModel(
      productType: list.productType!,
      modelEnum: LandingPageHelper.getViewModelTypeEnum(list.productType!),
      hotel:
          list.hotel != null ? HotelCardViewModel.fromCard(list.hotel!) : null,
      tour: list.tour != null ? TourCardViewModel.fromCard(list.tour!) : null,
      ticket:
          list.ticket != null ? TourCardViewModel.fromCard(list.ticket!) : null,
      carRental:
          list.car != null ? CarRentalViewModel.fromCard(list.car!) : null,
    );
  }
}

enum StaticPlayListModelEnum {
  hotel,
  tour,
  ticket,
  carRental,
  none,
}
