import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/hotel/hotel_landing_dynamic_single_playlist/repositories/hotel_landing_dynamic_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_mock_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source_mock.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/get_customer_details/repositories/customer_repository_impl_test.dart';
import '../../../../helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Hotel Landing Page case1', (WidgetTester tester) async {
    RecommendedLocationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(RecommendedLocationMockDataSourceImpl.getMockData())));
    RecommendedLocationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    HotelDynamicPlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: jsonDecode(_responseMock)));

    HotelStaticPlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(mockResult)));

    HotelLandingDynamicRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    LandingBannerRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(
            LandingBannerMockDataSourceImpl.getMockData())));

    await tester.runAsync(() async {
      await tester.pumpWidget(ProviderInitializer(
        MaterialApp(
          navigatorKey: GlobalKeys.navigatorKey,
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
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.hotelLandingScreen,
                    arguments: _getArgument()),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Hotel Landing Page case2', (WidgetTester tester) async {
    RecommendedLocationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            jsonDecode(RecommendedLocationMockDataSourceImpl.getMockData())));
    RecommendedLocationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());

    HotelDynamicPlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: jsonDecode(_responseMock1)));

    HotelStaticPlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(mockResult)));

    HotelLandingDynamicRepositoryImpl.setMockInternet(
        InternetConnectionInfoMocked());
    LandingBannerRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: getMockDataWithString(
            LandingBannerMockDataSourceImpl.getMockData())));

    await tester.runAsync(() async {
      await tester.pumpWidget(ProviderInitializer(
        MaterialApp(
          navigatorKey: GlobalKeys.navigatorKey,
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
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.hotelLandingScreen,
                    arguments: _getArgument()),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.pump();
    });
  });

  testWidgets('Hotel Landing Page internet failure',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({"": ""});
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(exception: OperationException()));
    RecommendedLocationRepositoryImpl.setMockInternet(
        InternetConnectionInfoMockedFalse());
    HotelLandingDynamicRepositoryImpl.setMockInternet(
        InternetConnectionInfoMockedFalse());
    await tester.runAsync(() async {
      await tester.pumpWidget(ProviderInitializer(
        MaterialApp(
          navigatorKey: GlobalKeys.navigatorKey,
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
          localeResolutionCallback: (locale, supportedLocales) {
            return supportedLocales.elementAt(0);
          },
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.hotelLandingScreen,
                    arguments: _getArgument()),
              );
            }),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });
}

var _responseMock = '''
{"__typename":"Mutation","getRecentViewPlaylist":{"__typename":"RecentViewPlaylistResponse","recentViewPlaylist":[{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1210100023","cityId":"MA05110041","countryId":"MA05110001","rating":5,"hotelName":"W Bangkok","image":"https://trbhmanage.travflex.com/ImageData/Hotel/w_bangkok-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1111000019","cityId":"MA05110041","countryId":"MA05110001","rating":4,"hotelName":"Amora Neoluxe Bangkok","image":"https://trbhmanage.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0511000344","cityId":"MA05110041","countryId":"MA05110001","rating":5,"hotelName":"Shangri La Bangkok","image":"https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0511000325","cityId":"MA05110041","countryId":"MA05110001","rating":5,"hotelName":"Centara Grand at Central Plaza Ladprao Bangkok","image":"https://trbhmanage.travflex.com/ImageData/Hotel/centara_grand_at_central_plaza_ladprao_bangkok-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0201094096","cityId":"MA05110067","countryId":"MA05110001","rating":3,"hotelName":"Athome Guesthouse","image":"https://trbhmanage.travflex.com/ImageData/Hotel/athome_guesthouse-general1.jpg","locationName":"Phuket,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA15064954","cityId":"MA05110037","countryId":"MA05110001","rating":4,"hotelName":"The Tide Resort","image":"https://trbhmanage.travflex.com/ImageData/Hotel/the_tide_resort-general1.jpg","locationName":"Chon Buri,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1304040327","cityId":"MA05110008","countryId":"MA05110001","rating":3,"hotelName":"107 Tower Nan","image":"https://trbhmanage.travflex.com/ImageData/Hotel/107_tower_nan-general1.jpg","locationName":"Nan,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0711110448","cityId":"MA05110040","countryId":"MA05110001","rating":4,"hotelName":"Krungsri River","image":"https://trbhmanage.travflex.com/ImageData/Hotel/krungsri_river-general1.jpg","locationName":"Ayutthaya,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1106060109","cityId":"MA05110040","countryId":"MA05110001","rating":3,"hotelName":"Ayothaya Riverside","image":"https://trbhmanage.travflex.com/ImageData/Hotel/ayothaya_riverside-general1.jpg","locationName":"Ayutthaya,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1905000182","cityId":"MA05110067","countryId":"MA05110001","rating":4,"hotelName":"OZO Phuket","image":"https://trbhmanage.travflex.com/ImageData/Hotel/ozo_phuket-general1.jpg","locationName":"Phuket,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0710101841","cityId":"MA05110067","countryId":"MA05110001","rating":4,"hotelName":"Phuket Graceland Resort and Spa","image":"https://trbhmanage.travflex.com/ImageData/Hotel/phuket_graceland_resort_and_spa-general1.jpg","locationName":"Phuket,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0604000016","cityId":"MA05110067","countryId":"MA05110001","rating":4,"hotelName":"Phuket Orchid Resort and Spa","image":"https://trbhmanage.travflex.com/ImageData/Hotel/phuket_orchid_resort_and_spa-general1.jpg","locationName":"Phuket,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1211110194","cityId":"MA05110067","countryId":"MA05110001","rating":5,"hotelName":"Sunsuri Phuket","image":"https://trbhmanage.travflex.com/ImageData/Hotel/sunsuri_phuket-general1.jpg","locationName":"Phuket,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA1904000663","cityId":"MA05110041","countryId":"MA05110001","rating":5,"hotelName":"Avani Sukhumvit Bangkok","image":"https://trbhmanage.travflex.com/ImageData/Hotel/avani_sukhumvit_bangkok-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA2201000004","cityId":"MA05110035","countryId":"MA05110001","rating":5,"hotelName":"Centara Hotel and Convention Centre Udon Thani","image":"https://trbhmanage.travflex.com/ImageData/Hotel/centara_hotel_and_convention_centre_udon_thani-general1.jpg","locationName":"Udon Thani,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0711050518","cityId":"MA05110041","countryId":"MA05110001","rating":4,"hotelName":"Courtyard By Marriott Bangkok (SHA Plus)","image":"https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA13110503","cityId":"MA05110041","countryId":"MA05110001","rating":1,"hotelName":"ISanook Bangkok (SHA Extra Plus)","image":"https://trbhmanage.travflex.com/ImageData/Hotel/isanook_bangkok_(sha_extra_plus)-general1.jpg","locationName":"Bangkok,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA12080291","cityId":"MA05110040","countryId":"MA05110001","rating":4,"hotelName":"Classic Kameo and Serviced Apartments Ayutthaya","image":"https://trbhmanage.travflex.com/ImageData/Hotel/classic_kameo_and_serviced_apartments_ayutthaya-general1.jpg","locationName":"Ayutthaya,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0711070783","cityId":"MA05110035","countryId":"MA05110001","rating":4,"hotelName":"Centara and Convention Centre Udon Thani","image":"https://trbhmanage.travflex.com/ImageData/Hotel/centara_and_convention_centre_udon_thani-general1.jpg","locationName":"Udon Thani,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]},{"__typename":"ListOfRecentViewPlaylist","hotelId":"MA0603000157","cityId":"MA05110001","countryId":"MA05110001","rating":3,"hotelName":"Chiang Mai Phucome","image":"https://trbhmanage.travflex.com/ImageData/Hotel/chiang_mai_phucome-general1.jpg","locationName":"Chiang Mai,Thailand","promotionList":[{"__typename":"PromotionList","productId":"GLOBAL","productType":"HOTEL","promotionType":"CAPSULE","promotionCode":"281","line1":"Free Food Delivery","line2":"","startDate":"2022-07-01 00:00:00","endDate":"2022-07-31 23:59:59","name":"Book now get free Robinhood food delivery fee"}]}],"dynamicPlaylist":{"__typename":"Playlist","source":null,"serviceName":null,"playlist":null},"status":{"__typename":"Status","code":"1000","header":"Success","description":null,"errors":null}}}
''';

var _responseMock1 = """ 
{
  "getRecentViewPlaylist": {
    "listType": "recentViewPlaylist",
    "dynamicPlaylist": {
      "serviceName": "hotels",
      "source": "dynamic",
      "playlist": [
        {
          "playlistId": "222",
          "playlistName": "Special recommended",
          "cardList": [
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            },
            {
              "id": "MA0201175007",
              "name": "Amari Phuket",
              "address": "2 Meun-Ngern Road Patong Beach, Kathu Address field 3",
              "locationId": "MA06040001",
              "locationName": "Patong Beach",
              "cityId": "MA05110067",
              "cityName": "Phuket",
              "countryId": "MA05110001",
              "countryName": "Thailand",
              "capsulePromotions": [
                {
                  "name": "cap1",
                  "code": "007"
                }
              ],
              "rating": 4,
              "infopromotion": [],
              "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket-general1.jpg",
              "promotionText1": "",
              "promotionText2": "",
              "styleName": "NONE",
              "startPrice": 1200,
              "productType": null,
              "review": {
                "score": 4,
                "numReview": 10,
                "description": "superb"
              }
            }
          ]
        }
      ]
    }
  }
}
""";

String mockResult = '''
{"__typename":"Mutation","getPlaylists":{"__typename":"PlayListResponse","staticPlaylist":{"__typename":"Playlist","source":null,"serviceName":"HOTEL","playlist":[{"__typename":"PlaylistDataResponse","playlistId":"55555","playlistName":"Hotel Recommended","cardList":[{"__typename":"PlaylistData","id":"MA1111000019","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg","countryName":null,"name":"Amora Neoluxe Bangkok","locationName":"Bangkok","locationId":null,"cityName":"Bangkok","styleName":null,"startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":"discount","promotionText_line2":"50%","capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"FREE01"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0603000157","cityId":"MA05110001","countryId":"MA05110001","imageUrl":"https://train.travflex.com/ImageData/Hotel/chiang_mai_phucome-general1.jpg","countryName":null,"name":"Chiang Mai Phucome","locationName":"","locationId":null,"cityName":"Chiang Mai","styleName":null,"startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":"discount","promotionText_line2":"50%","capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"FREE01"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0603000037","cityId":"MA05110908","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/pattaya_hiso-general1.jpg","countryName":null,"name":"Pattaya Hiso","locationName":"Pattaya","locationId":null,"cityName":"Chonburi","styleName":null,"startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":"Only","promotionText_line2":"RBH","capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"FREE01"}],"infopromotion":[]}]},{"__typename":"PlaylistDataResponse","playlistId":"17","playlistName":"Hotel in bangkok","cardList":[{"__typename":"PlaylistData","id":"MA0511000344","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg","countryName":null,"name":"Shangri La Bangkok","locationName":" Wat Suan Phu New ","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0810000023","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/p_and_r_residence_siphaya_bangkok-general1.jpg","countryName":null,"name":"P and R Residence Siphaya Bangkok","locationName":" Charoen Krung ","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0711050518","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-general1.jpg","countryName":null,"name":"Courtyard By Marriott Bangkok (SHA Plus)","locationName":"Rajdamri","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA1210100023","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/w_bangkok-general1.jpg","countryName":null,"name":"W Bangkok","locationName":" North Sathorn ","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA1711000127","cityId":"MA05110001","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/little_bear_s_home_(sha_plus)-general1.jpg","countryName":null,"name":"Little Bear s Home (SHA Plus)","locationName":"Sripoom","locationId":null,"cityName":" Chiang Mai ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]}]},{"__typename":"PlaylistDataResponse","playlistId":"27","playlistName":"Purple Overlay","cardList":[{"__typename":"PlaylistData","id":"MA1106060109","cityId":"MA05110040","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/ayothaya_riverside-general1.jpg","countryName":null,"name":"Ayothaya Riverside","locationName":" Pasak River ","locationId":null,"cityName":"Ayutthaya","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA13100327","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"101 Holiday Suite (SHA Extra Plus)","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2112000010","cityId":"MA15010002","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Baan Raong Fon (SHA Extra Plus)","locationName":null,"locationId":null,"cityName":" Amnat Charoen ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2112000008","cityId":"MA15010002","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/baan_rim_bung_(sha_plus)-general1.jpg","countryName":null,"name":"Baan Rim Bung (SHA Plus)","locationName":null,"locationId":null,"cityName":" Amnat Charoen ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2112000009","cityId":"MA15010002","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Baan Roi Daw","locationName":null,"locationId":null,"cityName":" Amnat Charoen ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2112000007","cityId":"MA15010002","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Baan Rim Khong","locationName":null,"locationId":null,"cityName":" Amnat Charoen ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0906060127","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/13_coins_airport_grand_resort_(sha)-general1.jpg","countryName":null,"name":"13 Coins Airport Grand Resort (SHA)","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2202000026","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"702 hotel","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0909060653","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/adelphi_grande_(sha_plus)-general1.jpg","countryName":null,"name":"Adelphi Grande (SHA Plus)","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA14020766","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/airy_suvarnabhumi_hotel-general1.jpg","countryName":null,"name":"Airy Suvarnabhumi Hotel","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA1803001622","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/akyra_tas_sukhumvit_bangkok-general1.jpg","countryName":null,"name":"Akyra TAS Sukhumvit Bangkok","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA1912002215","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Am Bed Hostel - Adults Only","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0511000114","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/amari_watergate_(sha_extra_plus)-general1.jpg","countryName":null,"name":"Amari Watergate (SHA Extra Plus)","locationName":"Pratunam","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA14124673","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/amarin_inn-general1.jpg","countryName":null,"name":"Amarin Inn","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":2,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2202000006","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Baan 92","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0511000294","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/bangkok_lotus_sukhumvit-general1.jpg","countryName":null,"name":"Bangkok Lotus Sukhumvit","locationName":"Sukhumvit","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2110000033","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"Beanstalk Bangkok's test (SHA Extra Plus)","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA1204040029","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/best_western_premier_sukhumvit-general1.jpg","countryName":null,"name":"Best Western Premier Sukhumvit","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA2112000047","cityId":"MA05110041","countryId":"MA05110001","imageUrl":null,"countryName":null,"name":"BluePrint Hotel","locationName":null,"locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":1,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]}]},{"__typename":"PlaylistDataResponse","playlistId":"18","playlistName":"Pool Villa","cardList":[{"__typename":"PlaylistData","id":"MA1210100023","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/w_bangkok-general1.jpg","countryName":null,"name":"W Bangkok","locationName":" North Sathorn ","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0511000325","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/centara_grand_at_central_plaza_ladprao_bangkok-general1.jpg","countryName":null,"name":"Centara Grand at Central Plaza Ladprao Bangkok","locationName":" Viphavadee Rangsit ","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":5,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0201175007","cityId":"MA05110067","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/amari_phuket_(sha)-general1.jpg","countryName":null,"name":"Amari Phuket (SHA)","locationName":" Patong Beach ","locationId":null,"cityName":"Phuket","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"},{"__typename":"CapsulePromotions","name":"specials deals","code":"227"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA0711050518","cityId":"MA05110041","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/courtyard_by_marriott_bangkok_(sha_plus)-general1.jpg","countryName":null,"name":"Courtyard By Marriott Bangkok (SHA Plus)","locationName":"Rajdamri","locationId":null,"cityName":"Bangkok","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":4,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]}]},{"__typename":"PlaylistDataResponse","playlistId":"82","playlistName":"Hotel in Chiang Rai","cardList":[{"__typename":"PlaylistData","id":"MA15061569","cityId":"MA05110002","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/after_glow_hostel_(sha_plus)-general1.jpg","countryName":null,"name":"After Glow Hostel (SHA Plus)","locationName":null,"locationId":null,"cityName":" Chiang Rai ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]},{"__typename":"PlaylistData","id":"MA15064747","cityId":"MA05110002","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/akha_hill_house_hotel_(sha_extra_plus)-general1.jpg","countryName":null,"name":"Akha Hill House Hotel (SHA Extra Plus)","locationName":"Maung","locationId":null,"cityName":" Chiang Rai ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":2,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]}]},{"__typename":"PlaylistDataResponse","playlistId":"85","playlistName":"test","cardList":[{"__typename":"PlaylistData","id":"MA15061569","cityId":"MA05110002","countryId":"MA05110001","imageUrl":"https://trbhmanage.travflex.com/ImageData/Hotel/after_glow_hostel_(sha_plus)-general1.jpg","countryName":null,"name":"After Glow Hostel (SHA Plus)","locationName":null,"locationId":null,"cityName":" Chiang Rai ","styleName":"","startPrice":0,"productType":"HOTEL","address":null,"address1":null,"rating":3,"review":null,"promotionText_line1":null,"promotionText_line2":null,"capsulePromotion":[{"__typename":"CapsulePromotions","name":"Free Food Delivery","code":"281"}],"infopromotion":[]}]}]}}}
''';

RecommendedLocationViewModel _getArgument() {
  return RecommendedLocationViewModel(
      recommendationsState: RecommendedLocationModelState.success,
      recommendedLocationList: [
        RecommendedLocationModel(
            cityId: '123',
            placeName: 'Bangkok',
            countryId: '123',
            hotelId: '123',
            playlistId: '123',
            searchKey: 'Bangkok')
      ]);
}
