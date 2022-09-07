import 'package:flutter/material.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/bloc/hotel_landing_static_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/widgets/hotel_landing_playlist_mixin.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/playlist_view_model.dart';

const double _kRemainingPixels = 50.0;

class HotelLandingStaticPlaylistScreen extends StatefulWidget {
  const HotelLandingStaticPlaylistScreen({Key? key}) : super(key: key);
  @override
  HotelLandingStaticPlaylistScreenState createState() =>
      HotelLandingStaticPlaylistScreenState();
}

class HotelLandingStaticPlaylistScreenState
    extends State<HotelLandingStaticPlaylistScreen> with HotelLandingPlaylist {
  final HotelLandingStaticPlaylistBloc _hotelLandingStaticPlaylistBloc =
      HotelLandingStaticPlaylistBloc();
  late HotelLandingStaticArgumentModel argument;
  @override
  void initState() {
    super.initState();
    intitialiseApiCall();
  }

  void intitialiseApiCall() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hotelLandingStaticPlaylistBloc.initiateApiCall(argument);
      scrollController.addListener(() {
        if (scrollController.hasClients &&
            scrollController.position.extentAfter <= _kRemainingPixels) {
          _hotelLandingStaticPlaylistBloc.loadNextPage(argument);
        }
      });

      _hotelLandingStaticPlaylistBloc.stream.listen((event) {
        if (_hotelLandingStaticPlaylistBloc.state.playlistState ==
            PlaylistViewModelState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
    });
  }

  @override
  void onRefresh() {
    _hotelLandingStaticPlaylistBloc.pullToRefresh(argument);
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context)?.settings.arguments
        as HotelLandingStaticArgumentModel;
    return builder(context, argument.playlistName);
  }

  @override
  BuildContext getBuildContext() {
    return context;
  }

  @override
  HotelLandingPlaylistBloc getHotelLandingPlaylistBloc() {
    return _hotelLandingStaticPlaylistBloc;
  }
}
