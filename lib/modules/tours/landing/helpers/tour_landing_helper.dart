import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';
import 'package:ota/modules/tours/landing/view_model/tour_attractions_view_model.dart';
import 'package:ota/modules/tours/landing/view_model/tour_recent_playlist_view_model.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_argument_model.dart';

const String _kCapsule = "CAPSULE";
const String _kOverlay = "OVERLAY";

class TourLandingHelper {
  static List<TourAttractionsModel> getTourAttractionsList(
      List<LocationList>? list) {
    List<TourAttractionsModel>? tourAttractionList;
    if (list == null || list.isEmpty) return [];

    tourAttractionList = List<TourAttractionsModel>.generate(
      list.length,
      (index) {
        return TourAttractionsModel.fromAttraction(
          list[index],
        );
      },
    );
    return tourAttractionList.toList();
  }

  static List<TourTicketRowPlaylistModel> getTourTicketPlaylist(
      List<ListOfPlaylist>? list) {
    List<TourTicketRowPlaylistModel>? tourTicketPlaylist;
    if (list == null || list.isEmpty) return [];

    tourTicketPlaylist = List<TourTicketRowPlaylistModel>.generate(
      list.length,
      (index) {
        return TourTicketRowPlaylistModel.mapFromPlaylistDomain(
          list[index],
        );
      },
    );
    return tourTicketPlaylist.toList();
  }

  static List<TourAttractionModel> getAttractionModelList(
      List<TourAttractionsModel>? list) {
    List<TourAttractionModel>? attractionList;
    if (list == null || list.isEmpty) return [];

    attractionList = List<TourAttractionModel>.generate(
      list.length,
      (index) {
        return TourAttractionModel(
          serviceTitle: list[index].serviceTitle,
          searchKey: list[index].searchKey,
          imageUrl: list[index].imageUrl,
          cityId: list[index].cityId,
          countryId: list[index].countryId,
        );
      },
    );
    return attractionList.toList();
  }

  static String getAdminPromotionLine1(List<Promotions> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line1 ?? '';
      }
    }
    return '';
  }

  static String getAdminPromotionLine2(List<Promotions> promotionList) {
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kOverlay) {
        return promotionList[i].line2 ?? '';
      }
    }
    return '';
  }

  static List<TourRecentCapsulePromotion> getCapsulePromotions(
      List<Promotions> promotionList) {
    List<TourRecentCapsulePromotion> list = [];
    for (int i = 0; i < promotionList.length; i++) {
      if (promotionList[i].promotionType == _kCapsule &&
          promotionList[i].line1 != null &&
          promotionList[i].line1!.isNotEmpty) {
        list.add(
            TourRecentCapsulePromotion.fromCapsulePromotion(promotionList[i]));
      }
    }
    return list;
  }
}
