import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_horizontal_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_tna_playlist_card.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

const double _kContainerWidth = 240;

class OtaTnaPlaylistWidget extends StatelessWidget {
  final List<TnaActivityList> cardList;
  final String title;
  final PlaylistType playlistType;
  final void Function()? onTitleArrowClick;

  const OtaTnaPlaylistWidget({
    Key? key,
    required this.cardList,
    required this.title,
    required this.playlistType,
    this.onTitleArrowClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize24),
      child: Column(
        children: [
          _getTitleBar(context),
          OtaHorizontalPlayListAmenities(
              length: cardList.length,
              builder: (index) {
                return _buildPlaylistCard(context, cardList[index]);
              }),
        ],
      ),
    );
  }

  Widget _buildPlaylistCard(
          BuildContext context, TnaActivityList playlistModel) =>
      SizedBox(
        width: _kContainerWidth,
        child: OtaTnaPlaylistCard(
          name: playlistModel.name,
          location: playlistModel.locationName,
          cityName: playlistModel.cityName,
          category: playlistModel.category,
          promotionTextTop: playlistModel.promotionTextLine1,
          promotionTextBottom: playlistModel.promotionTextLine2,
          imageUrl: playlistModel.imageUrl,
          playlistType: playlistType,
          capsulePromotion: playlistModel.capsulePromotion,
          onPress: () => _onPlaylistCardClick(context, playlistModel.id,
              playlistModel.cityId, playlistModel.countryId),
        ),
      );

  Widget _getTitleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize0, kSize8, kSize16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTheme.kHeading1Medium,
            ),
          ),
          OtaNextButton(onPress: onTitleArrowClick),
        ],
      ),
    );
  }

  void _onPlaylistCardClick(
      BuildContext context, String id, String cityId, String countryId) {
    if (playlistType == PlaylistType.tour) {
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
