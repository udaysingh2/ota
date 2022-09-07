import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_horizontal_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_playlist_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';

const double _kContainerWidth = 240;
const int _kTravelId = 3;
const String _kTravelName = 'tour';
const String _kTour = 'Tour';
const String _kTicket = 'Ticket';
const String _kPlaylistSection = 'T&A_Landing';

class TourTicketPlaylistWidget extends StatelessWidget {
  final List<TourTicketRowPlaylistModel> cardList;
  final String title;
  final PlaylistType playlistType;
  final void Function()? onTitleArrowClick;

  const TourTicketPlaylistWidget({
    Key? key,
    required this.cardList,
    required this.title,
    required this.playlistType,
    this.onTitleArrowClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize16),
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
          BuildContext context, TourTicketRowPlaylistModel playlistModel) =>
      SizedBox(
        width: _kContainerWidth,
        child: TourTicketPlaylistCard(
          name: playlistModel.name,
          location: playlistModel.location,
          cityName: playlistModel.cityName,
          category: playlistModel.category,
          promotionTextTop: playlistModel.promotionTextLine1,
          promotionTextBottom: playlistModel.promotionTextLine2,
          imageUrl: playlistModel.imageUrl,
          price: playlistModel.price,
          playlistType: playlistType,
          onPress: () {
            _getFirebaseData(playlistModel, FirebaseEvent.activityPlaylist);
            _onPlaylistCardClick(context, playlistModel.id!,
                playlistModel.cityId!, playlistModel.countryId!);
            FirebaseHelper.stopCapturingEvent(FirebaseEvent.activityPlaylist);
          },
          amentities: _amenitiesList(playlistModel.capsulePromotions),
        ),
      );

  List<String>? _amenitiesList(
      List<TourTicketCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return null;
    }
    List<String> amenities = [];
    for (TourTicketCapsulePromotion capsule in capsulePromotion) {
      if (capsule.name != null) {
        amenities.add(capsule.name!);
      }
    }
    return amenities;
  }

  Widget _getTitleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, kSize16),
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTheme.kHeading1Medium)),
          OtaNextButton(onPress: onTitleArrowClick),
        ],
      ),
    );
  }

  String _getAllIdSequence() {
    return List<String>.generate(
      cardList.length,
      (int index) => cardList[index].id.toString(),
    ).toString();
  }

  void _getFirebaseData(TourTicketRowPlaylistModel cardList, String eventName) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.playlistSection,
        value: _kPlaylistSection);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.activityId,
        value: cardList.id);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.activityName,
        value: cardList.name);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.activityService,
        value: playlistType == PlaylistType.tour ? _kTour : _kTicket);
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.travelId,
        value: _kTravelId);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.travelName,
        value: _kTravelName);
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: ActivityPlaylistParameters.allIdSequence,
        value: _getAllIdSequence());
    FirebaseHelper.addUserLocation(eventName: eventName);
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
