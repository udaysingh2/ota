import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_fab_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_card.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button.dart';
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';

import '../models/argument_data_model_automation.dart';
import '../models/favourites_result_model_domain_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/consolidated_data_source_automation.dart';

HotelAutomation hotelAutomation = HotelAutomation();
FavouritesResultModelDomainAutomation favouritesResultModelDomainAutomation =
    FavouritesResultModelDomainAutomation();
List<RoomData> list = [];

///Test to verify the landing page
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  String testDescription =
      'Validate if the hotels marked as favorites functionality';
  testWidgets(testDescription, (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    list.add(RoomData(adults: 2, children: 0));
    HotelDetailDataArgumentAutomation hotelDetailDataArgumentAutomation =
        new HotelDetailDataArgumentAutomation(
            currency: 'THB',
            checkOutDate: '2021-12-12',
            checkInDate: '2021-12-11',
            cityId: 'MA05110041',
            countryId: 'MA05110001',
            hotelId: 'MA0909060653',
            rooms: list);
    print(
        '--------hotelDetailDataArgument $hotelDetailDataArgumentAutomation----------------');
    OtaConsolidatedRemoteDataSource otaConsolidatedRemoteDataSource =
        OtaConsolidatedRemoteDataSourceImpl();
    hotelAutomation = await otaConsolidatedRemoteDataSource
        .getHotelDetail(hotelDetailDataArgumentAutomation);
    print(
        '---------Hotel automation data from BE is ${hotelAutomation.toString()}');
    var hotelName = hotelAutomation.data!.hotelDetail!.name!.toString();
    await tester.pumpAndSettle(Duration(seconds: 15));
    await tester.tap(find.byType(SearchTextWidget));

    //fetching value from backend and entering in ota search field
    print('----------hotelName "${hotelName.toString()}" will be entered now ');
    await tester.pump(Duration(seconds: 20));
    await tester.enterText(find.byType(TextField), hotelName);
    await tester.pump(Duration(seconds: 20));
    print('------------Hotel Name $hotelName is searched');
    final suggestionResult1 = find.byType(OtaSuggestionTileWidget);
    await tester.tap(suggestionResult1.first);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    await tester.tap(find.byType(OtaSuggestionCard).first);
    await tester.pumpAndSettle(Duration(milliseconds: 6000));
    var heartIconButton = find.byType(HeartButton);
    var markedHotel = find.byKey(Key('hotelName'));

    ///verifying if the favorite icon is visible in property details page
    expect(heartIconButton, findsOneWidget);
    print('----------The favorite icon is visible on FE-------------');
    await tester.tap(heartIconButton);
    await tester.pump(Duration(seconds: 10));
    await tester.pumpAndSettle(Duration(seconds: 20));
    await tester.tap(find.byType(BackNavigationButton));
    await tester.pump(Duration(seconds: 10));
    await tester.tap(find.byType(IconButton));
    bool flag = false;
    await tester.pumpAndSettle(Duration(seconds: 20));

    ///THESE steps will ensure the favorite list functionalities
    var fabButtonsIcon = find.byType(OtaFABButton);
    await tester.tap(fabButtonsIcon.last);
    await tester.pumpAndSettle(Duration(seconds: 5));
    await tester.tap(fabButtonsIcon.at(0));
    await tester.pumpAndSettle(Duration(seconds: 15));
    List<String?> listOfFavorites = [];
    favouritesResultModelDomainAutomation =
        await otaConsolidatedRemoteDataSource.getFavouritesData('HOTEL', 0, 20);
    int totalFavoriteHotelsCount = favouritesResultModelDomainAutomation
        .getAllFavorites!.data!.favourites!.length;
    print(
        '----------The number of hotels marked as favorites are ${totalFavoriteHotelsCount.toString()}');

    ///This is to check if the hotel marked as favorite is available in the favorite list
    for (int i = 0; i < totalFavoriteHotelsCount; i++) {
      listOfFavorites.add(favouritesResultModelDomainAutomation
          .getAllFavorites!.data!.favourites!
          .elementAt(i)
          .hotelName!);
      print(
          '------------List$i of favorites ${favouritesResultModelDomainAutomation.getAllFavorites!.data!.favourites!.elementAt(i).hotelName}');
    }
    print('---------hotel to be searched for is $markedHotel');
    try {
      if (listOfFavorites.contains(markedHotel)) {
        flag = true;
      }
      if (flag == true) {
        print(
            'The test: " $testDescription " has passed and $markedHotel hotel is visible in favorites list');
      }
    } catch (e) {
      print('Exception handled is ${e.toString()}');
    }
  });
}
