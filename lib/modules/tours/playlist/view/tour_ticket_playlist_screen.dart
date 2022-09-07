import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_tickets_playlist_view_all_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/bloc/tour_ticket_playlist_bloc.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_view_model.dart';

const String _kPlaylistSection = "T&A_Landing";
const String _kTourServiceType = "Tour";
const String _kTicketServiceType = "Ticket";
const int _kTravelId = 3;

class TourTicketPlaylistScreen extends StatefulWidget {
  const TourTicketPlaylistScreen({Key? key}) : super(key: key);

  @override
  State<TourTicketPlaylistScreen> createState() =>
      _TourTicketPlaylistScreenState();
}

class _TourTicketPlaylistScreenState extends State<TourTicketPlaylistScreen> {
  final TourTicketPlaylistBloc _bloc = TourTicketPlaylistBloc();
  TourTicketPlaylistArgument? _argument;
  int _currentPage = 1;

  _requestPlaylistData() {
    _bloc.getTourAndTicketPlaylist(_argument);
  }

  bool get _isToursPlaylist =>
      _argument != null && _argument!.playlistName == PlaylistType.tour.value;

  PlaylistType get _playlistType =>
      _argument != null && _argument!.playlistName == PlaylistType.tour.value
          ? PlaylistType.tour
          : PlaylistType.ticket;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_bloc.playlistSize == 0) _requestPlaylistData();
    });
    _bloc.stream.listen(
      (event) {
        if (_bloc.state.pageState ==
            TourTicketPlaylistScreenPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _argument = ModalRoute.of(context)?.settings.arguments
        as TourTicketPlaylistArgument;
    _bloc.initData(_argument);
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
            context,
            _isToursPlaylist
                ? AppLocalizationsStrings.recommendedTours
                : AppLocalizationsStrings.recommendedTicket),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: () {
          if (_bloc.isLoading) {
            return const OTALoadingIndicator();
          } else {
            return _buildPlaylistView();
          }
        },
      ),
    );
  }

  bool _isNewDataRequired(int index) {
    int maxSize = _currentPage * _argument!.limit;
    if (maxSize == (index + 1)) return true;
    return false;
  }

  Widget _buildPlaylistView() {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize16),
      itemCount: _bloc.playlistSize,
      itemBuilder: (context, index) {
        if (_isNewDataRequired(index)) {
          _currentPage++;
          _argument!.offset = _bloc.playlistSize;
          _requestPlaylistData();
        }
        return _buildTourTicketPlaylistCard(
            _bloc.state.tourTicketPlaylist![index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: kSize16),
    );
  }

  Widget _buildTourTicketPlaylistCard(TourTicketPlaylistModel playlistModel) {
    return TourTicketPlaylistCard(
      name: playlistModel.name,
      location: playlistModel.locationName,
      category: playlistModel.category,
      promotionTextTop: playlistModel.promotionTextLine1,
      promotionTextBottom: playlistModel.promotionTextLine2,
      imageUrl: playlistModel.imageUrl,
      price: playlistModel.startPrice,
      cityName: playlistModel.cityName,
      playlistType: _playlistType,
      isInHorizontalScroll: false,
      onPress: () {
        _publishFirebaseData(playlistModel);
        _onPlaylistCardClick(
            playlistModel.id!, playlistModel.cityId!, playlistModel.countryId!);
      },
      amentities: _amenitiesList(playlistModel.capsulePromotions),
    );
  }

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

  void _onPlaylistCardClick(String id, String cityId, String countryId) {
    final userType = getLoginProvider().userType;
    if (_isToursPlaylist) {
      final tourDetailUserType = userType == UserType.guestUser
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
      final ticketDetailUserType = userType == UserType.guestUser
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

  void _publishFirebaseData(TourTicketPlaylistModel? model) {
    FirebaseHelper.addUserLocation(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.playlistSection,
        value: _kPlaylistSection);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.travelId,
        value: _kTravelId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.travelName,
        value: _kTourServiceType);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.activityId,
        value: model?.id);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.activityName,
        value: model?.name);
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        value: _bloc.state.tourTicketPlaylist?.map((e) => e.id).toList(),
        key: TourTicketPlaylistViewAllFirebase.allIdSequence);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.activityService,
        value: _isToursPlaylist ? _kTourServiceType : _kTicketServiceType);
    FirebaseHelper.stopCapturingEvent(FirebaseEvent.tourTicketPlaylistViewAll);
  }
}
