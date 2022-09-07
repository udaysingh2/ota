import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/hotel_landing_static_playlist_screen.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';
import '../../../../helper/material_wrapper.dart';
import '../../../../mocks/hotel/hotel_landing_playlist/hotel_landing_static_view_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Hotel Landing Dynamic Playlist Screen Test', (tester) async {
    GlobalKey<HotelLandingStaticPlaylistScreenState> key = GlobalKey();
    HotelLandingStaticArgumentModel playlistViewArgument =
        getHotelLandingStaicViewArgumentMock();
    Widget widget = getMaterialWrapperWithArguments(
      HotelLandingStaticPlaylistScreen(
        key: key,
      ),
      AppRoutes.hotelLandingStaticPlaylistScreen,
      playlistViewArgument,
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    await tester.pump();
    await tester.pumpAndSettle();
  });
}
