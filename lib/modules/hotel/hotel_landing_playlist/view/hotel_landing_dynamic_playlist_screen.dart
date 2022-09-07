import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_dynamic_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_static_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/widgets/hotel_landing_playlist_mixin.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_dynamic_argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

const double _kRemainingPixels = 50.0;

class HotelLandingDynamicPlaylistScreen extends StatefulWidget {
  const HotelLandingDynamicPlaylistScreen({Key? key}) : super(key: key);

  @override
  HotelLandingDynamicPlaylistScreenState createState() =>
      HotelLandingDynamicPlaylistScreenState();
}

class HotelLandingDynamicPlaylistScreenState
    extends State<HotelLandingDynamicPlaylistScreen> with HotelLandingPlaylist {
  final HotelLandingDynamicPlaylistBloc _hotelLandingDynamicPlaylistBloc =
      HotelLandingDynamicPlaylistBloc();
  late HotelLandingDynamicArgumentModel argument;

  @override
  void initState() {
    super.initState();
    initializeApiCall();
  }

  void initializeApiCall() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments
          as HotelLandingDynamicArgumentModel;
      _hotelLandingDynamicPlaylistBloc.initiateApiCall(argument);
      scrollController.addListener(() {
        if (scrollController.hasClients &&
            scrollController.position.extentAfter <= _kRemainingPixels) {
          _hotelLandingDynamicPlaylistBloc.loadNextPage(argument);
        }
      });

      _hotelLandingDynamicPlaylistBloc.stream.listen((event) {
        if (_hotelLandingDynamicPlaylistBloc.state.playlistState ==
            PlaylistViewModelState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
    });
  }

  @override
  void onRefresh() {
    _hotelLandingDynamicPlaylistBloc.pullToRefresh(argument);
  }

  @override
  Widget build(BuildContext context) {
    return builder(context,
        getTranslated(context, AppLocalizationsStrings.accommodations));
  }

  @override
  BuildContext getBuildContext() {
    return context;
  }

  @override
  HotelLandingPlaylistBloc getHotelLandingPlaylistBloc() {
    return _hotelLandingDynamicPlaylistBloc;
  }
}
