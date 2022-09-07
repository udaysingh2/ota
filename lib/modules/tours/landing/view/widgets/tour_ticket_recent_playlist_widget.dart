import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_horizontal_playlist_amenities.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/landing/view_model/tour_recent_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

const double _kContainerWidth = 240;
const _kTourKey = "TOUR";

class TourTicketRecentPlaylistWidget extends StatelessWidget {
  final List<TourListPlaylistItem> cardList;
  final String title;

  const TourTicketRecentPlaylistWidget({
    Key? key,
    required this.cardList,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize27),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitleBar(context),
          OtaHorizontalPlayListAmenities(
            length: cardList.length,
            builder: (index) {
              return _buildPlaylistCard(context, cardList[index]);
            },
          )
        ],
      ),
    );
  }

  Widget _buildPlaylistCard(
          BuildContext context, TourListPlaylistItem playlistModel) =>
      SizedBox(
        width: _kContainerWidth,
        child: TourTicketPlaylistCard(
          name: playlistModel.name,
          location: playlistModel.location,
          cityName: playlistModel.locationName,
          category: playlistModel.category,
          promotionTextTop: playlistModel.promotions?.line1,
          promotionTextBottom: playlistModel.promotions?.line2,
          imageUrl: playlistModel.image,
          playlistType: playlistModel.type == _kTourKey
              ? PlaylistType.tour
              : PlaylistType.ticket,
          onPress: () => _onPlaylistCardClick(
              context,
              playlistModel.id!,
              playlistModel.cityId!,
              playlistModel.countryId!,
              playlistModel.type!),
          amentities:
              _amenitiesList(playlistModel.promotions?.capsulePromotion),
        ),
      );

  List<String>? _amenitiesList(
      List<TourRecentCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return null;
    }
    List<String> amenities = [];
    for (TourRecentCapsulePromotion capsule in capsulePromotion) {
      if (capsule.title != null) {
        amenities.add(capsule.title!);
      }
    }
    return amenities;
  }

  Widget _getTitleBar(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, kSize16),
        child: Text(title, style: AppTheme.kHeading1Medium));
  }

  void _onPlaylistCardClick(BuildContext context, String id, String cityId,
      String countryId, String type) {
    if (type == _kTourKey) {
      final tourDetailUserType =
          getLoginProvider().userType == UserType.guestUser
              ? TourDetailUserType.guestUser
              : TourDetailUserType.loggedInUser;
      final tourArgument = TourDetailArgument(
        userType: tourDetailUserType,
        tourId: id,
        cityId: cityId,
        countryId: countryId,
      );
      Navigator.pushNamed(context, AppRoutes.tourDetailScreen,
          arguments: tourArgument);
    } else {
      final ticketDetailUserType =
          getLoginProvider().userType == UserType.guestUser
              ? TicketDetailUserType.guestUser
              : TicketDetailUserType.loggedInUser;
      final ticketArgument = TicketDetailArgument(
        userType: ticketDetailUserType,
        ticketId: id,
        cityId: cityId,
        countryId: countryId,
      );
      Navigator.pushNamed(context, AppRoutes.ticketDetailScreen,
          arguments: ticketArgument);
    }
  }
}
