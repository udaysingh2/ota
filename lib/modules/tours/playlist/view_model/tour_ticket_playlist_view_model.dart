import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';

class TourTicketPlaylistViewModel {
  List<TourTicketPlaylistModel>? tourTicketPlaylist;
  String? playlistId;
  String? playlistName;
  TourTicketPlaylistScreenPageState pageState;
  TourTicketPlaylistViewModel({
    this.tourTicketPlaylist,
    this.playlistId,
    this.playlistName,
    required this.pageState,
  });
}

class TourTicketPlaylistModel {
  String? id;
  String? name;
  String? imageUrl;
  String? locationName;
  String? cityId;
  String? countryId;
  String? cityName;
  String? category;
  double? startPrice;
  String? promotionTextLine1;
  String? promotionTextLine2;
  List<TourTicketCapsulePromotion>? capsulePromotions;

  TourTicketPlaylistModel({
    this.id,
    this.name,
    this.imageUrl,
    this.locationName,
    this.cityId,
    this.countryId,
    this.cityName,
    this.category,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotions,
  });

  /// Constructor That is used to map from the Domain level Model.
  TourTicketPlaylistModel.mapFromListOfPlaylist(ListOfPlaylist lostofPlaylist) {
    id = lostofPlaylist.id;
    name = lostofPlaylist.name;
    imageUrl = lostofPlaylist.imageUrl;
    locationName = lostofPlaylist.locationName;
    cityId = lostofPlaylist.cityId;
    countryId = lostofPlaylist.countryId;
    cityName = lostofPlaylist.cityName;
    category = lostofPlaylist.styleName;
    startPrice = lostofPlaylist.startPrice;
    promotionTextLine1 = lostofPlaylist.promotionTextLine1;
    promotionTextLine2 = lostofPlaylist.promotionTextLine2;
    capsulePromotions = (lostofPlaylist.capsulePromotion == null)
        ? null
        : List.generate(
            lostofPlaylist.capsulePromotion!.length,
            (index) => TourTicketCapsulePromotion.mapFromCapsulePromotion(
              lostofPlaylist.capsulePromotion![index],
            ),
          );
  }

  TourTicketPlaylistModel.fromTourTicketRowPlaylist(
      TourTicketRowPlaylistModel tourTicketRowPlaylist) {
    id = tourTicketRowPlaylist.id;
    name = tourTicketRowPlaylist.name;
    imageUrl = tourTicketRowPlaylist.imageUrl;
    locationName = tourTicketRowPlaylist.location;
    cityId = tourTicketRowPlaylist.cityId;
    countryId = tourTicketRowPlaylist.countryId;
    cityName = tourTicketRowPlaylist.cityName;
    category = tourTicketRowPlaylist.category;
    startPrice = tourTicketRowPlaylist.price;
    promotionTextLine1 = tourTicketRowPlaylist.promotionTextLine1;
    promotionTextLine2 = tourTicketRowPlaylist.promotionTextLine2;
    capsulePromotions = tourTicketRowPlaylist.capsulePromotions;
  }
}

enum TourTicketPlaylistScreenPageState {
  initial,
  loading,
  success,
  failure,
  failure1899,
  failure1999,
  internetFailure,
}
