import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/playlist/data_sources/play_list_mock_data_source.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/playlist/view/playlist_screen.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import '../../../helper/material_wrapper.dart';
import '../../../mocks/playlist/playlist_view_mock.dart';
import '../../hotel/repositories/internet_success_mock.dart';

// const String _kOtaSuggestionCardKey = 'dynamic_ota_suggestion_card_key';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Playlist Screen Test', (tester) async {
    GlobalKey<PlaylistScreenState> key = GlobalKey();
    PlaylistViewArgument playlistViewArgument = getPlaylistViewArgumentMock();
    Widget widget = getMaterialWrapperWithArguments(
      PlaylistScreen(
        key: key,
      ),
      AppRoutes.playlistScreen,
      playlistViewArgument,
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    key.currentState?.scrollListener();
    expect(find.byType(OtaAppBar), findsOneWidget);
    await tester.pump();
    await tester.pumpAndSettle();
  });

  testWidgets('Playlist Screen Test with success', (tester) async {
    GlobalKey<PlaylistScreenState> key = GlobalKey();
    mockPlayListPageData(
      remoteDataSource: PlayListMockDataSourceImpl(),
      internetInfo: InternetSuccessMock(),
    );
    PlaylistViewArgument playlistViewArgument = getPlaylistViewArgumentMock();
    Widget widget = ProviderInitializer(
      MaterialApp(
        routes: AppRoutes.getRoutes(),
        supportedLocales: [
          Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode),
          Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode),
        ],
        localizationsDelegates: const [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Kanit',
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(1);
        },
        home: Material(
            child: TestArgumentWidget(
          routeName: AppRoutes.playlistScreen,
          argument: playlistViewArgument,
          child: PlaylistScreen(key: key),
        )),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // var buttonToTap = find.byKey(const Key(_kOtaSuggestionCardKey));
    // await tester.tap(buttonToTap.first);
  });
}
