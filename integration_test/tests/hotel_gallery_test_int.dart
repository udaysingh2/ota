import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_rounded_corner_image.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';
import 'package:ota/main.dart' as app;
import 'package:ota/modules/gallery/view/gallery_screen.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_image_slider.dart';
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';

import '../configs/hoteDetailsConfig.dart' as hotelDetailsConfig;
import '../models/argument_data_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../utils/consolidated_data_source_automation.dart';
import '../utils/hotel_detail_data_source_automation.dart';

HotelAutomation hotelAutomation = new HotelAutomation();
List<RoomData> list = [];
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel gallery', (WidgetTester tester) async {
    app.main();
    print("Image gallery Test");
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    //await tester.tap(find.text("Login with alpha user"));
    await tester.pumpAndSettle();
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    print("starting test");
    list.add(RoomData(adults: 2, children: 0));
    HotelDetailDataArgumentAutomation hotelDetailDataArgument =
        new HotelDetailDataArgumentAutomation(
            currency: 'THB',
            checkOutDate: '2021-12-12',
            checkInDate: '2021-12-11',
            cityId: 'MA05110041',
            countryId: 'MA05110001',
            hotelId: 'MA0909060653',
            rooms: list);

    OtaConsolidatedRemoteDataSource otaConsolidatedRemoteDataSource =
        OtaConsolidatedRemoteDataSourceImpl();
    hotelAutomation = await otaConsolidatedRemoteDataSource
        .getHotelDetail(hotelDetailDataArgument);
    int? imagesCnt =
        hotelAutomation.data?.hotelDetail?.images?.galleryCount ?? 0;
    String? imageBaseUrl =
        hotelAutomation.data?.hotelDetail?.images?.baseUri ?? "";
    List<String?> imageUri =
        hotelAutomation.data?.hotelDetail?.images?.gallery ?? [];
    String? coverImgUrl =
        hotelAutomation.data?.hotelDetail?.images?.cover ?? "";
    print("Test started for gallery details for " + config[0]['hotelID']);
    await tester.tap(find.byType(SearchTextWidget));
    await tester.pump(Duration(seconds: 10));
    //getting value from backend and entering in ota search field
    final hotelName = hotelAutomation.data!.hotelDetail!.name;
    print('HotelName: ${hotelName.toString()} will be entered now ');
    await tester.enterText(find.byType(TextField), hotelName!);
    await tester.pump(Duration(seconds: 20));
    final suggestionResult1 = find.byType(OtaSuggestionTileWidget);
    await tester.tap(suggestionResult1.first);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    Finder coverImage = find.byKey(Key("coverImage"));
    expect(coverImage, findsOneWidget);
    HotelImageSlider cvrImage = tester.widget(coverImage);
    print("cover image url" + cvrImage.imageUrl[0]);
    print("coverimage from gql" + imageBaseUrl + coverImgUrl);
    expect(cvrImage.imageUrl[0], imageBaseUrl + coverImgUrl);
    expect(find.text("ดูรูปที่พัก"), findsOneWidget);
    await tester.tap(find.text("ดูรูปที่พัก"));
    await tester.pumpAndSettle(Duration(seconds: 10));
    await tester.pump();
    find.widgetWithText(HotelImageSlider, "ดูรูปที่พัก");
    await tester.pumpAndSettle(Duration(seconds: 10));
    Finder gallerylabel = find.byType(OtaAppBar);
    expect(gallerylabel, findsOneWidget);
    var allImages = find.byType(GalleryScreen);
    expect(allImages.precache(), true);

    if (imagesCnt > 0) {
      List<String> imageUrls = [];
      imageUri.forEach((url) {
        imageUrls.add(imageBaseUrl + url!);
      });
      Finder thumbNails = find.byType(OtaRoundedCornerImage);
      expect(thumbNails, findsNWidgets(imageUrls.length));
      int urlMatched = 0;
      thumbNails.evaluate().forEach((image) {
        imageUrls.forEach((url) {
          if (image.widget.key.toString().contains(url)) {
            urlMatched++;
          }
        });
      });
      expect(imageUrls.length, urlMatched);
      Finder firstImage = find.byType(OtaRoundedCornerImage).first;
      await tester.tap(firstImage);
      await tester.pumpAndSettle();
      Finder overlayImageText = find.text("1/" + imagesCnt.toString());
      expect(overlayImageText, findsOneWidget);
      await tester.tap(find.byKey(Key("right_icon")));
      await tester.pumpAndSettle();
      overlayImageText = find.text("2/" + imagesCnt.toString());
      expect(overlayImageText, findsOneWidget);
      await tester.pumpAndSettle();
      overlayImageText = find.text("1/" + imagesCnt.toString());
      await tester.tap(find.byKey(Key("left_icon")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("close_icon")));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaRoundedCornerImage).at(0),
          warnIfMissed: false);
      await tester.pumpAndSettle();
      for (var i = 1; i < imagesCnt + 1; i++) {
        overlayImageText = find.text(i.toString() + "/" + imagesCnt.toString());
        expect(overlayImageText, findsOneWidget);
        if (i < imagesCnt) {
          await tester.tap(find.byKey(Key("right_icon")), warnIfMissed: false);
          await tester.pumpAndSettle();
        } else {
          expect(find.byKey(Key("right_icon")), findsNothing);
        }
      }
      for (var i = imagesCnt - 1; i > 0; i--) {
        if (i >= 1) {
          await tester.tap(find.byKey(Key("left_icon")), warnIfMissed: false);
          await tester.pumpAndSettle();
          overlayImageText =
              find.text(i.toString() + "/" + imagesCnt.toString());
          expect(overlayImageText, findsOneWidget);
        } else {
          expect(find.byKey(Key("left_icon")), findsNothing);
        }
      }
      Finder secondImage = find.byType(OtaRoundedCornerImage).at(0);
      await tester.tap(secondImage, warnIfMissed: false);
      await tester.pumpAndSettle();
      overlayImageText = find.text("1/" + imagesCnt.toString());
      await tester.tap(overlayImageText);
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(overlayImageText);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("close_icon")));
    }
  });
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Hotel gallery-Negetive tests', (WidgetTester tester) async {
    app.main();
    print("Image gallery Test-Negetive");
    await tester.pumpWidget(app.MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    await tester.pump(Duration(seconds: 2));
    var config = json.decode(hotelDetailsConfig.HotelDetailsConfig.data);
    print("starting test");
    HotelDetailRemoteDataSourceAutomation
        hotelDetailRemoteDataSourceAutomation =
        HotelDetailRemoteDataSourceImpl();
    List<RoomData> roomData = [];
    roomData.add(new RoomData(adults: 2, children: 0));
    hotelAutomation =
        await hotelDetailRemoteDataSourceAutomation.getHotelDetail(
      HotelDetailDataArgumentAutomation(
        currency: config[1]['currency'],
        checkOutDate: config[1]['checkOutDate'],
        checkInDate: config[1]['checkInDate'],
        rooms: roomData,
        cityId: config[1]['cityId'],
        countryId: config[1]['countryId'],
        hotelId: config[1]['hotelID'],
      ),
    );
    // int? imagesCnt =
    //     hotelAutomation.data?.hotelDetail?.images?.galleryCount ?? 0;
    // String? imageBaseUrl =
    //     hotelAutomation.data?.hotelDetail?.images?.baseUri ?? "";
    // List<String?> imageUri =
    //     hotelAutomation.data?.hotelDetail?.images?.gallery ?? [];
    // String? coverImgUrl =
    //     hotelAutomation.data?.hotelDetail?.images?.cover ?? "";
    print("Test started for gallery details for " + config[0]['hotelID']);
    await tester.tap(find.byType(SearchTextWidget));
    await tester.pump(Duration(seconds: 10));
    //getting value from backend and entering in ota search field
    final hotelName = hotelAutomation.data!.hotelDetail!.name;
    print('HotelName: ${hotelName.toString()} will be entered now ');
    await tester.enterText(find.byType(TextField), hotelName!);
    await tester.pump(Duration(seconds: 20));
    final suggestionResult1 = find.byType(OtaSuggestionTileWidget);
    await tester.tap(suggestionResult1.first);
    await tester.pumpAndSettle(Duration(milliseconds: 3000));
    Finder coverImage = find.byKey(Key("coverImage"));
    expect(coverImage, findsOneWidget);
    CachedNetworkImage cachedcvrImage =
        tester.widget(find.byType(CachedNetworkImage));
    //String CverImagePlaceHolder="assets/images/icons/default_network_cache_image.png";
    expect(cachedcvrImage.imageUrl, '');
    //expect(cvrImage.placeholder,CverImagePlaceHolder);
    expect(find.text("ดูรูปที่พัก"), findsOneWidget);
    await tester.tap(find.text("ดูรูปที่พัก"));
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 10));
    Finder gallerylabel = find.byType(OtaAppBar);
    expect(gallerylabel, findsOneWidget);
    Finder thumbNails = find.byType(OtaRoundedCornerImage);
    expect(thumbNails, findsNothing);
    expect(find.byType(OtaNetworkErrorWidget), findsNothing);
    print(" Gallery- All negetive tests passed");
  });
}
