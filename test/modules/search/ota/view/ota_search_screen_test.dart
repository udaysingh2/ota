import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/search/ota/view/ota_search_screen.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_screen_model.dart'
    as state;

import '../../../../helper/material_wrapper.dart';

void main() {
  GlobalKey<OtaSearchScreenState> key = GlobalKey();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('OtaSearchScreen widget ==> searchScreenBloc bloc',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        OtaSearchScreen(
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
      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.failure;
      key.currentState?.searchScreenBloc.isStateResults == true;
      key.currentState?.suggestionBloc.state.suggestionState =
          OtaSuggestionViewModelState.success;
      key.currentState?.suggestionBloc.state.suggestionList = [
        model(),
      ];
      await tester.pump();

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

      ///For function _getSearchResultByLocation()
      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.failure;
      await tester.pump();

      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.empty;
      await tester.pumpWidget(widget);

      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.success;
      await tester.pumpWidget(widget);
    });
  });

  testWidgets('OtaScreenBloc ==> OtaSearchViewPageState.success',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        OtaSearchScreen(
          key: key,
        ),
      );
      // await tester.pumpWidget(widget);

      await tester.pump();

      /// Testing Function onSearchFieldTap()
      key.currentState?.searchScreenBloc.setStateNone();
      key.currentState?.onSearchFieldTap();
      await tester.pump();

      /// For value setup
      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.success;
      key.currentState?.searchScreenBloc.isStateResults == true;
      key.currentState?.suggestionBloc.state.suggestionState =
          OtaSuggestionViewModelState.success;
      key.currentState?.suggestionBloc.state.suggestionList = [
        model(),
      ];
      await tester.pump();

      ///For function _getSearchResultByLocation()
      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.results;
      key.currentState?.otaSearchBloc.state.pageState =
          OtaSearchViewPageState.success;
      await tester.pumpWidget(widget);
    });
  });

  testWidgets('OtaSearchScreen widget ==> suggestions bloc',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        OtaSearchScreen(
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
      key.currentState?.searchScreenBloc.state.otaSearchScreenState =
          state.OtaSearchScreenState.suggestions;
      key.currentState?.searchScreenBloc.isStateResults == true;
      key.currentState?.suggestionBloc.state.suggestionState =
          OtaSuggestionViewModelState.success;
      key.currentState?.suggestionBloc.state.suggestionList = [
        model(),
      ];
      await tester.pump();

      /// Testing Function onSearchTextChange() Not empty text
      key.currentState?.textFieldController.text = "Search text";
      key.currentState?.onSearchTextChange();
      await tester.pump();

      await Future.delayed(const Duration(milliseconds: 1200));
      await tester.pump();
    });
  });

  testWidgets('OtaSearchScreen widget ==> _recommendationBloc',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(
        OtaSearchScreen(
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
      key.currentState?.recommendationBloc.state.recommendationState =
          OtaRecommendationViewModelState.success;
      key.currentState?.recommendationBloc.state.recommendationList = [
        OtaRecommendationModel(
          serviceTitle: 'serviceTitle',
          imageUrl: 'imageUrl',
        ),
      ];
      key.currentState?.recommendationBloc.state.searchHistoryList = [
        OtaSearchHistoryModel(keyword: 'test'),
      ];
      await tester.pump();

      /// Testing Function onSearchTextChange() Not empty text
      key.currentState?.textFieldController.text = "Search text";
      key.currentState?.onSearchTextChange();
      await tester.pump();

      // await Future.delayed(const Duration(milliseconds: 1500));
      await tester.pump();
    });
  });
}

OtaSuggestionModel model() => OtaSuggestionModel(
      id: 'id',
      name: 'name',
      hotelId: 'hotelId',
      cityId: 'cityId',
      countryId: 'countryId',
      locationId: 'locationId',
    );
