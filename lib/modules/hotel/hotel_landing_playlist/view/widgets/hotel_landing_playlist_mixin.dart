import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_playlist_view_all_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_static_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_detail_error_widget.dart';

const double _kAppBarHeight = 89;
const double _kRemainingPixels = 50.0;

abstract class HotelLandingPlaylist {
  late HotelLandingPlaylistBloc hotelLandingPlaylistBloc =
      getHotelLandingPlaylistBloc();
  late BuildContext buildContext = getBuildContext();
  final ScrollController scrollController = ScrollController();
  HotelLandingPlaylistBloc getHotelLandingPlaylistBloc();
  BuildContext getBuildContext();
  Widget builder(BuildContext context, String title) {
    return Scaffold(
      appBar: OtaAppBar(
        title: title,
      ),
      body: Column(
        children: [
          _buildScreens(),
        ],
      ),
    );
  }

  Widget _buildScreens() {
    return Expanded(
      child: BlocBuilder(
          bloc: hotelLandingPlaylistBloc,
          builder: () {
            switch (hotelLandingPlaylistBloc.state.playlistState) {
              case PlaylistViewModelState.none:
                return showCircularProgressIndicator();
              case PlaylistViewModelState.loading:
                return showCircularProgressIndicator();
              case PlaylistViewModelState.success:
                return _buildListView(buildContext);
              case PlaylistViewModelState.failure:
              case PlaylistViewModelState.internetFailure:
                return _buildPullDownErrorWidget(buildContext);
            }
          }),
    );
  }

  Widget showCircularProgressIndicator() {
    if (hotelLandingPlaylistBloc.state.playlist.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return _buildListView(buildContext);
    }
  }

  Widget _buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: hotelLandingPlaylistBloc.state.playlist.length + 1,
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize24),
      itemBuilder: (context, index) {
        if (index < hotelLandingPlaylistBloc.state.playlist.length) {
          return _buildOtaSuggestionCard(
              hotelLandingPlaylistBloc.state.playlist.elementAt(index));
        }
        return BlocBuilder(
            bloc: hotelLandingPlaylistBloc,
            builder: () {
              return _buildFooterLoader();
            });
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: kSize24);
      },
    );
  }

  Widget _buildOtaSuggestionCard(PlaylistCardViewModel cardViewModel) {
    return (cardViewModel.hotelName.isEmpty || cardViewModel.hotelId.isEmpty)
        ? const SizedBox.shrink()
        : OtaSuggestionCardHorizontalAmenities(
            isInHorizontalScroll: false,
            headerText: cardViewModel.hotelName,
            ratingText: cardViewModel.rating,
            addressText: cardViewModel.locationName,
            ratingTitle: cardViewModel.reviewTitle,
            reviewText: cardViewModel.reviewText,
            offerPercent: cardViewModel.offerValue,
            score: cardViewModel.score,
            discount: cardViewModel.discountValue,
            imageUrl: cardViewModel.image,
            adminPromotionLine1: cardViewModel.promotionText1,
            adminPromotionLine2: cardViewModel.promotionText2,
            amenitiesList: cardViewModel.aminities,
            onPress: () {
              _getHotelFirebase(cardViewModel.hotelId, cardViewModel.hotelName,
                  cardViewModel.image);
              FirebaseHelper.stopCapturingEvent(
                  FirebaseEvent.hotelPlaylistViewAll);
              openHotelDetailScreen(cardViewModel);
            });
  }

  void openHotelDetailScreen(PlaylistCardViewModel cardViewModel) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      cardViewModel.hotelId,
      cardViewModel.cityId,
      cardViewModel.countryId,
      getLoginProvider().userType.getHotelDetailType(),
    );
    Navigator.pushNamed(buildContext, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  void onRefresh();
  Widget _buildPullDownErrorWidget(BuildContext context) {
    return RoomDetailErrorWidget(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async {
        onRefresh();
      },
    );
  }

  Widget _buildFooterLoader() {
    if (hotelLandingPlaylistBloc.state.playlistState ==
            PlaylistViewModelState.loading &&
        hotelLandingPlaylistBloc.state.playlist.isNotEmpty) {
      return const SizedBox(
          height: _kRemainingPixels,
          child: Center(child: CircularProgressIndicator()));
    }
    return const SizedBox(
      height: _kRemainingPixels,
    );
  }

  String _getAllIdSequence(List<PlaylistCardViewModel> hotelModel) {
    return List.generate(
        hotelModel.length, (index) => hotelModel[index].hotelId).toString();
  }

  void _getHotelFirebase(String hotelId, String hotelName, String url) {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.hotelId,
        value: hotelId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.hotelName,
        value: hotelName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.allIdSequence,
        value: _getAllIdSequence(hotelLandingPlaylistBloc.state.playlist));
  }
}
