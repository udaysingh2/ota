import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';
import 'package:ota/modules/search/hotel/view/hotel_search_screen.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_suggestion_view_model.dart';
import '../../../../helper/material_wrapper.dart';

void main() {
  GlobalKey<HotelSearchScreenState> key = GlobalKey();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('HotelSearchScreen widget ==> Suggestions list with success',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        HotelSearchScreen(
          key: key,
        ),
      );
      await tester.pumpWidget(widget);

      await tester.pump();

      /// Testing Function onSearchFieldTap()
      key.currentState?.searchScreenBloc.setStateNone();
      key.currentState?.onSearchFieldTap();
      await tester.pump();

      /// For value setup
      key.currentState?.suggestionBloc.state.suggestionState =
          HotelSuggestionViewModelState.success;
      key.currentState?.suggestionBloc.state.suggestionList = [
        getSuggestionModel(),
      ];

      /// Testing Function onSearchTextChange() Not empty text
      key.currentState?.textFieldController.text = "Search text";
      key.currentState?.onSearchTextChange();
      await tester.pump();

      await Future.delayed(const Duration(milliseconds: 1200));
      await tester.pump();

      /// Testing Function onSearchTextChange() empty text
      key.currentState?.textFieldController.text = "";
      key.currentState?.onSearchTextChange();
      await tester.pump();

      /// Testing Function onCrossButtonTap()
      key.currentState?.searchScreenBloc.setStateSuggestions();
      key.currentState?.onCrossButtonTap();
      await tester.pump();
    });
  });

  testWidgets('HotelSearchScreen widget ==> Recommendation list not empty',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
              child: HotelSearchScreen(
            key: key,
          )),
        ),
      );
      await tester.pumpWidget(widget);

      key.currentState?.searchScreenBloc.setStateRecommendations();
      key.currentState?.recommendationBloc.state.recommendationList = [
        HotelRecommendationModel(
            serviceTitle: "ServiceTitle", imageUrl: "ImageUrl")
      ];
      key.currentState?.recommendationBloc.state.recommendationState =
          HotelRecommendationViewModelState.success;

      key.currentState?.recommendationBloc
          .emit(key.currentState!.recommendationBloc.state);
      await tester.pump();

      ///For value setup
      key.currentState?.loginModel.userType = UserType.loggedInUser;
      key.currentState?.searchScreenBloc.isStateRecommendations == true;
      key.currentState?.recommendationBloc.state.recommendationState =
          HotelRecommendationViewModelState.success;
      key.currentState?.recommendationBloc.state.searchHistoryList = [
        HotelSearchHistoryModel(keyword: 'test')
      ];
      key.currentState?.recommendationBloc.state.recommendationList = [
        HotelRecommendationModel(
          serviceTitle: 'serviceTitle',
          imageUrl: 'imageUrl',
        ),
      ];

      ///initDefaultValue
      key.currentState?.recommendationBloc.initDefaultValue();
      await tester.pump();

      ///fetchRecommendationData
      key.currentState?.recommendationBloc.fetchRecommendationData();
      await tester.pump();

      ///isRecommendationsEmpty
      key.currentState?.recommendationBloc.isRecommendationsEmpty;
      await tester.pump();

      ///isSearchHistoryEmpty
      key.currentState?.recommendationBloc.isSearchHistoryEmpty;
      await tester.pump();
    });
  });

  testWidgets('HotelSearchScreen widget suggestions state',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          routes: AppRoutes.getRoutes(),
          supportedLocales: [
            Locale(
                LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
              child: HotelSearchScreen(
            key: key,
          )),
        ),
      );
      await tester.pumpWidget(widget);

      key.currentState?.searchScreenBloc.setStateSuggestions();
      key.currentState?.suggestionBloc.state.suggestionState =
          HotelSuggestionViewModelState.success;
      key.currentState?.suggestionBloc.state.suggestionList = [
        HotelSuggestionModel(
          cityId: 'CityId',
          countryId: 'CountryId',
          hotelId: 'HotelId',
          id: 'Id',
          locationId: 'LocationId',
          name: 'Name',
          searchSuggestionType: SearchSuggestionType.hotel,
        ),
        HotelSuggestionModel(
          cityId: 'CityId1',
          countryId: 'CountryId1',
          hotelId: 'HotelId1',
          id: 'Id1',
          locationId: 'LocationId1',
          name: 'Name1',
          searchSuggestionType: SearchSuggestionType.cityLocation,
        ),
      ];
      key.currentState?.suggestionBloc
          .emit(key.currentState!.suggestionBloc.state);
      await tester.pump();

      /// Testing Function fetchSuggestionData()
      key.currentState?.suggestionBloc.fetchSuggestionData('test');
      await tester.pump();

      /// Testing Function clearSuggestions()
      key.currentState?.suggestionBloc.clearSuggestions();
      await tester.pump();
    });
  });
}

HotelSuggestionModel getSuggestionModel() => HotelSuggestionModel(
      id: 'id',
      name: 'name',
      hotelId: 'hotelId',
      cityId: 'cityId',
      countryId: 'countryId',
      locationId: 'locationId',
    );
