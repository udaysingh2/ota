import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';

const int kMaxCapsuleLength = 18;

class TourTicketRowPlaylistViewModel {
  List<TourTicketRowPlaylistModel>? tourTicketPlaylist;
  String? playlistId;
  String? playlistName;
  TourTicketRowPlaylistViewModelState playlistState;
  TourTicketRowPlaylistViewModel({
    this.tourTicketPlaylist,
    this.playlistId,
    this.playlistName,
    this.playlistState = TourTicketRowPlaylistViewModelState.initial,
  });
}

class TourTicketRowPlaylistModel {
  String? id;
  String? cityId;
  String? countryId;
  String? name;
  String? imageUrl;
  String? location;
  String? cityName;
  String? category;
  double? price;
  String? promotionTextLine1;
  String? promotionTextLine2;
  List<TourTicketCapsulePromotion>? capsulePromotions;

  TourTicketRowPlaylistModel({
    this.id,
    this.cityId,
    this.countryId,
    this.name,
    this.imageUrl,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.location,
    this.cityName,
    this.category,
    this.price,
    this.capsulePromotions,
  });

  TourTicketRowPlaylistModel.mapFromPlaylistDomain(
      ListOfPlaylist playlistItem) {
    id = playlistItem.id;
    name = playlistItem.name;
    imageUrl = playlistItem.imageUrl;
    location = playlistItem.locationName;
    cityId = playlistItem.cityId;
    countryId = playlistItem.countryId;
    cityName = playlistItem.cityName;
    category = playlistItem.styleName;
    price = playlistItem.startPrice;
    promotionTextLine1 = playlistItem.promotionTextLine1;
    promotionTextLine2 = playlistItem.promotionTextLine2;
    capsulePromotions = (playlistItem.capsulePromotion == null)
        ? null
        : List.generate(
            playlistItem.capsulePromotion!.length,
            (index) => TourTicketCapsulePromotion.mapFromCapsulePromotion(
                playlistItem.capsulePromotion![index]));
  }
}

class TourTicketCapsulePromotion {
  final String? name;
  final String? code;
  TourTicketCapsulePromotion({
    this.name,
    this.code,
  });

  factory TourTicketCapsulePromotion.mapFromCapsulePromotion(
          CapsulePromotion capsulePromotion) =>
      TourTicketCapsulePromotion(
          name:
              Helpers.truncateString(capsulePromotion.name, kMaxCapsuleLength),
          code: capsulePromotion.code);
}

enum TourTicketRowPlaylistViewModelState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
}
