//LandingDataAutomation
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_card.dart';
import 'package:ota/main.dart' as app;

import '../../models/landing_models_automation.dart';
import '../../models/playlist_result_data_model_automation.dart';
import '../../utils/Reusable/utility.dart';
import '../../utils/consolidated_data_source_automation.dart';

LandingDataAutomation landingDataAutomation = LandingDataAutomation();
PlaylistResultModelAutomation playlistResultModelAutomation =
    PlaylistResultModelAutomation();
AppActions appActions = AppActions();

///Test to verify the landing page
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
      'verification of the landing page icons greeting message,banner,service cards and playlist',
      (WidgetTester tester) async {
    OtaConsolidatedRemoteDataSource otaConsolidatedRemoteDataSource =
        OtaConsolidatedRemoteDataSourceImpl();
    landingDataAutomation =
        await otaConsolidatedRemoteDataSource.getLandingPage();
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(Duration(seconds: 10));
    // await tester.tap(find.text('Login with alpha user'));
    await tester.pumpAndSettle(Duration(seconds: 20));

    ///validating custom landing page greeting text
    expect(
        find.text(landingDataAutomation
            .getLandingPageDetails!.data!.defaultCustomText!),
        findsWidgets);

    await tester.pump(Duration(seconds: 40));

    //await tester.ensureVisible(find.byKey(Key("closeButton")));

    //await tester.tap(find.byKey(Key("otaRadioButton")));
    // await tester.pump(Duration(seconds: 10));
    //await tester.tap(find.byKey(Key("closeButton")));
    await tester.dragUntilVisible(
        find.text(landingDataAutomation
            .getLandingPageDetails!.data!.businessCards!
            .elementAt(3)
            .serviceText!),
        find.byType(CustomScrollView),
        Offset(0, 100));

    ///Verifying the business cards BE data with FE
    landingDataAutomation.getLandingPageDetails!.data!.businessCards!
        .forEach((serviceCard) async {
      expect(find.text(serviceCard.serviceText!), findsOneWidget);
      // await tester.ensureVisible(find.text(serviceCard.serviceText!));
      //await tester.ensureVisible(find.text(serviceCard.title!).first);
      expect(find.text(serviceCard.title!), findsWidgets);
      // expect(find.text(serviceCard.description!), findsOneWidget);
    });
    print(
        '-------------Service cards are working as expected---------------- ');
    await tester.pumpAndSettle(Duration(seconds: 15));

    ///verify the full playlist by scrolling vertically
    Finder fullPlayListIcon = find.byType(OtaNextButton);
    await tester.dragUntilVisible(
        fullPlayListIcon, find.byType(CustomScrollView), Offset(0, -150));
    await tester.pumpAndSettle(Duration(seconds: 10));
    print("Scrolled successfully and all widget loaded successfully!");
    await tester.tap(fullPlayListIcon.first);
    print("Successfully tapped on it!");

    List<IcPlaylistAutomation>? dynamicPlayList =
        playlistResultModelAutomation.getPlaylists!.dynamicPlaylist!;
    for (IcPlaylistAutomation myList in dynamicPlayList) {
      List<ListElementAutomation>? list = myList.list;
      int playListCardCount = list!.length;
      print("Total number of playList card is ---> " +
          playListCardCount.toString());
      int i = 0;
      // "J" is using for scrolling screen after 3 cards which is displayed in UI
      int j = 0;
      //"K" is using for handling "J" value after scrolling on screen it is helping to set J as 0 after each scroll
      int k = 1;
      for (ListElementAutomation playListDetails in list) {
        k = 2;
        Finder suggestionCards = find.byType(OtaSuggestionCard);
        int displayedCardsPerScreen = suggestionCards.evaluate().length;
        print("card displayed per page ----- " +
            displayedCardsPerScreen.toString());
        print("loop number ---> " + i.toString());
        String hotelName = playListDetails.hotelName!;
        print(hotelName);
        expect(appActions.findWidgetBy("Text", hotelName), findsOneWidget);

        ReviewAutomation? review = playListDetails.review;
        String hotelReviewDesc = review!.description!;
        print(hotelReviewDesc);
        expect(
            appActions.findWidgetBy("Text", hotelReviewDesc), findsOneWidget);

        //  var hotelReviewCount = review.score!;
        // print(hotelReviewCount);
        // expect(appActions.findWidgetBy("Text", hotelReviewCount.toString()), findsOneWidget);

        AddressAutomation? address = playListDetails.address;
        String hotelLocationName = address!.locationName!;
        String hotelCityName = address.cityName!;
        String hotelAddress = hotelLocationName + ", " + hotelCityName;
        print(hotelAddress);
        expect(appActions.findWidgetBy("Text", hotelAddress), findsOneWidget);
        if (j + 1 == displayedCardsPerScreen || displayedCardsPerScreen == 4) {
          if (i == playListCardCount - 1) {
            break;
          }
          print("Scrolling down to see other cards------------- ");
          Finder hotelReviewToScroll =
              appActions.findWidgetBy("Text", hotelReviewDesc);
          await tester.dragUntilVisible(hotelReviewToScroll,
              find.byType(CustomScrollView), Offset(0, -150));
          await tester.pumpAndSettle(Duration(seconds: 10));
          j = 0;
          k = 0;
        }
        if (k != 0) {
          j++;
        }
        i++;
      }
    }
  });
}
