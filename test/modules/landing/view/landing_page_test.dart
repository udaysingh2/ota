import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/persistence/hive/boxes.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source.dart';
import 'package:ota/domain/landing/banner/data_sources/banner_remote_data_source_mock.dart';
import 'package:ota/domain/landing/banner/repositories/banner_repository_impl.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_mock_data_source.dart';
import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/landing/service_card/repositories/service_card_repository_impl.dart';
import 'package:ota/domain/playlist/data_sources/playlist_remote_data_source.dart';
import 'package:ota/domain/playlist/repositories/playlist_repository_impl.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source.dart';
import 'package:ota/domain/popup/data_sources/popup_remote_data_source_mock.dart';
import 'package:ota/domain/popup/repositories/popup_repository_impl.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_mock_data_source.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/repositories/prefernce_questions_repository_impl.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/data_sources/search_remote_mock.dart';
import 'package:ota/domain/search/repositories/search_repository_impl.dart';
import 'package:ota/domain/static_playlist/data_source/static_playlist_mock_data_source.dart';
import 'package:ota/domain/static_playlist/data_source/static_playlist_remote_data_source.dart';
import 'package:ota/domain/static_playlist/repositories/static_playlist_repository_impl.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';
import 'package:ota/modules/landing/view/widgets/service_card_widget.dart';

import '../../../helper.dart';
import '../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    HttpOverrides.global = null;
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/path_provider_macos');
    channel.setMockMethodCallHandler((call) async {
      return ".";
    });
    await Hive.initFlutter();
    await Hive.openBox<CarRecentSearchData>(BoxKeys.kRecentSearchBox);
  });
  testWidgets('Hotel Landing Page case6', (WidgetTester tester) async {
    PreferenceQuestionsRepositoryImpl.setMockInternet(InternetSuccessMock());
    PreferenceQuestionsRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(PreferenceQuestionsMockDataSourceImpl.getMockData()),
        exception: OperationException()));

    LandingBannerRepositoryImpl.setMockInternet(InternetSuccessMock());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(LandingBannerMockDataSourceImpl.getMockData())));

    PopupRepositoryImpl.setMockInternet(InternetSuccessMock());
    PopupRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(PopupMockDataSourceImpl.getMockData())));

    ServiceCardRepositoryImpl.setMockInternet(InternetSuccessMock());
    ServiceCardRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(ServiceCardMockDataSourceImpl.getMockData())));

    OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    OtaStaticPlayListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(OtaStaticPlayListMockDataSourceImpl.getMockData())));

    SearchRepositoryImpl.setMockInternet(InternetSuccessMock());
    SearchRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(SearchMockDataSourceImpl.getRecommendationMockData())));

    mockPlayListPageData(
      internetInfo: InternetSuccessMock(),
    );
    PlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));

    await tester.runAsync(() async {
      Widget widget =
          getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SearchTextWidget));
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });

  testWidgets('Hotel Landing Page case2', (WidgetTester tester) async {
    PreferenceQuestionsRepositoryImpl.setMockInternet(InternetSuccessMock());
    PreferenceQuestionsRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(PreferenceQuestionsMockDataSourceImpl.getMockData()),
        exception: OperationException()));

    LandingBannerRepositoryImpl.setMockInternet(InternetSuccessMock());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(LandingBannerMockDataSourceImpl.getMockData())));

    PopupRepositoryImpl.setMockInternet(InternetSuccessMock());
    PopupRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(PopupMockDataSourceImpl.getMockData())));

    ServiceCardRepositoryImpl.setMockInternet(InternetSuccessMock());
    ServiceCardRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(ServiceCardMockDataSourceImpl.getMockData())));

    OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    OtaStaticPlayListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(OtaStaticPlayListMockDataSourceImpl.getMockData())));

    SearchRepositoryImpl.setMockInternet(InternetSuccessMock());
    SearchRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(SearchMockDataSourceImpl.getRecommendationMockData())));

    mockPlayListPageData(
      internetInfo: InternetSuccessMock(),
    );
    PlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));

    await tester.runAsync(() async {
      Widget widget =
          getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      // expect(find.byKey(const Key("NextKey")), findsOneWidget);
      await tester.tap(find.byType(OtaSuggestionCardHorizontalAmenities).first);
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });
  testWidgets('Hotel Landing Page case3', (WidgetTester tester) async {
    PreferenceQuestionsRepositoryImpl.setMockInternet(InternetSuccessMock());
    PreferenceQuestionsRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(PreferenceQuestionsMockDataSourceImpl.getMockData()),
        exception: OperationException()));

    LandingBannerRepositoryImpl.setMockInternet(InternetSuccessMock());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(LandingBannerMockDataSourceImpl.getMockData())));

    PopupRepositoryImpl.setMockInternet(InternetSuccessMock());
    PopupRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(PopupMockDataSourceImpl.getMockData())));

    ServiceCardRepositoryImpl.setMockInternet(InternetSuccessMock());
    ServiceCardRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(ServiceCardMockDataSourceImpl.getMockData())));

    OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    OtaStaticPlayListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(OtaStaticPlayListMockDataSourceImpl.getMockData())));

    SearchRepositoryImpl.setMockInternet(InternetSuccessMock());
    SearchRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(SearchMockDataSourceImpl.getRecommendationMockData())));

    mockPlayListPageData(
      internetInfo: InternetSuccessMock(),
    );
    PlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));

    await tester.runAsync(() async {
      Widget widget =
          getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      // expect(find.byKey(const Key("NextKey")), findsOneWidget);
      await tester.tap(find.byType(BannerWidget).first);
      try {
        await tester.pumpAndSettle();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  });

  group("Service card click", () {
    PreferenceQuestionsRepositoryImpl.setMockInternet(InternetSuccessMock());
    PreferenceQuestionsRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(PreferenceQuestionsMockDataSourceImpl.getMockData()),
        exception: OperationException()));

    LandingBannerRepositoryImpl.setMockInternet(InternetSuccessMock());
    LandingBannerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(LandingBannerMockDataSourceImpl.getMockData())));

    PopupRepositoryImpl.setMockInternet(InternetSuccessMock());
    PopupRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(PopupMockDataSourceImpl.getMockData())));

    ServiceCardRepositoryImpl.setMockInternet(InternetSuccessMock());
    ServiceCardRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result: json.decode(ServiceCardMockDataSourceImpl.getMockData())));

    OtaStaticPlaylistRepositoryImpl.setMockInternet(InternetSuccessMock());
    OtaStaticPlayListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(OtaStaticPlayListMockDataSourceImpl.getMockData())));

    SearchRepositoryImpl.setMockInternet(InternetSuccessMock());
    SearchRemoteDataSourceImpl.setMock(GraphQlResponseMock(
        result:
            json.decode(SearchMockDataSourceImpl.getRecommendationMockData())));

    mockPlayListPageData(
      internetInfo: InternetSuccessMock(),
    );
    PlayListRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: getMockDataWithString(_responseMock)));
    testWidgets('Ota Landing Page Hotel card', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget =
            getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ServiceCardWidget).first);
        try {
          await tester.pumpAndSettle();
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
    testWidgets('Ota Landing Page Tour card', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget =
            getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ServiceCardWidget).last);
        try {
          await tester.pumpAndSettle();
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
    testWidgets('Ota Landing Page CAR card', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget =
            getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ServiceCardWidget).at(1));
        try {
          await tester.pumpAndSettle();
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
    testWidgets('Ota Landing Page Insurance card', (WidgetTester tester) async {
      await tester.runAsync(() async {
        Widget widget =
            getWidgetPressButtonWithProvider(AppRoutes.landingPage, null);
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ServiceCardWidget).at(2));
        try {
          await tester.pumpAndSettle();
        } catch (e) {
          debugPrint(e.toString());
        }
      });
    });
  });
}

var _responseMock = """ 
{
    "getPlaylists": {
      "staticPlaylist": {
        "source": null,
        "serviceName": "HOTEL",
        "playlist": [
          {
            "playlistId": "55555",
            "playlistName": "โรงแรมแนะนำพิเศษ",
            "cardList": [
              {
                "id": "MA1111000019",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "imageUrl": "https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
                "countryName": null,
                "name": "โรงแรมอโรม่า",
                "locationName": "",
                "locationId": null,
                "cityName": "กรุงเทพ",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [
                  {
                    "name": "Free Food Delivery",
                    "code": "FREE01"
                  }
                ],
                "infopromotion": []
              },
              {
                "id": "MA0603000157",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "imageUrl": "https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
                "countryName": null,
                "name": "เชียงใหม่ภูคำ",
                "locationName": "",
                "locationId": null,
                "cityName": "เชีบงใหม่",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [
                  {
                    "name": "Free Food Delivery",
                    "code": "FREE01"
                  }
                ],
                "infopromotion": []
              },
              {
                "id": "MA0603000037",
                "cityId": "MA05110908",
                "countryId": "MA05110001",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/pattaya_hiso-general1.jpg",
                "countryName": null,
                "name": "พัทยาไฮโซ",
                "locationName": "พัทยา",
                "locationId": null,
                "cityName": "ชลบุรี",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              }
            ]
          },
          {
            "playlistId": "55556",
            "playlistName": "โรงแรมแนะนำพิเศษ",
            "cardList": [
              {
                "id": "MA1111000019",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "imageUrl": "https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
                "countryName": null,
                "name": "โรงแรมอโรม่า",
                "locationName": "",
                "locationId": null,
                "cityName": "กรุงเทพ",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [
                  {
                    "name": "Free Food Delivery",
                    "code": "FREE01"
                  }
                ],
                "infopromotion": []
              },
              {
                "id": "MA0603000157",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "imageUrl": "https://train.travflex.com/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
                "countryName": null,
                "name": "เชียงใหม่ภูคำ",
                "locationName": "",
                "locationId": null,
                "cityName": "เชีบงใหม่",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [
                  {
                    "name": "Free Food Delivery",
                    "code": "FREE01"
                  }
                ],
                "infopromotion": []
              },
              {
                "id": "MA0603000037",
                "cityId": "MA05110908",
                "countryId": "MA05110001",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/pattaya_hiso-general1.jpg",
                "countryName": null,
                "name": "พัทยาไฮโซ",
                "locationName": "พัทยา",
                "locationId": null,
                "cityName": "ชลบุรี",
                "styleName": null,
                "startPrice": 0,
                "productType": "HOTEL",
                "address": null,
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              }
            ]
          }
        ]
      },
      "dynamicPlaylist": {
        "source": "Dynamic",
        "serviceName": "HOTEL",
        "playlist": [
          {
            "playlistId": null,
            "playlistName": null,
            "cardList": [
              {
                "id": "MA0511000113",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/boulevard_bangkok-general1.jpg",
                "name": "บูเลอวาร์ด กรุงเทพฯ สุขุมวิท",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "2 ถนนสุขุมวิท ซอย 5",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000115",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/ambassador_bangkok-general1.jpg",
                "name": "แอมบาสซาเดอร์ กรุงเทพฯ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "171 ถ.สุขุมวิท ซอย 11, คลองเตยเหนือ, วัฒนา",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000124",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/ariston_bangkok-general1.jpg",
                "name": "Ariston กรุงเทพฯ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "19 ซอย 24",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000179",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/four_wings-general1.jpg",
                "name": "โฟร์วิงส์",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "40 แขวงคลองตัน เขตคลองเตย",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000194",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/golden_palace-general1.jpg",
                "name": "โกลเด้นพาเลซ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "15 สุขุมวิท ซอย 1",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000198",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/grace_bangkok-general1.jpg",
                "name": "เกรซ กรุงเทพ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "12 สุขุมวิท ซอย 3, นานาเหนือ, วัฒนา",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000269",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/imperial_impala-general1.jpg",
                "name": "Imperial Impala",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "9 ซอยสุขุมวิท 24",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000270",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/bangkok_marriott_marquis_queen_s_park-general1.jpg",
                "name": "แบงค็อก แมริออท มาร์ควิส ควีนส์พาร์ค",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "199 ซอยสุขุมวิท ซอย 22 คลองตัน คลองเตย",
                "address1": null,
                "rating": 5,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000271",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/double_tree_by_hilton_sukhumvit-general1.jpg",
                "name": "ดับเบิ้ลทรี บาย ฮิลตัน สุขุมวิท กรุงเทพ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "18/1 ซอยสุขุมวิท 26 ถนนสุขุมวิท แขวงคลองตัน เขตคลอ",
                "address1": null,
                "rating": 5,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000273",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/jw_marriott_bangkok-general1.jpg",
                "name": "เจดับบลิว แมริออท",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "4 สุขุมวิทซอย 2",
                "address1": null,
                "rating": 5,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000274",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/landmark_bangkok-general1.jpg",
                "name": "แลนด์มาร์คกรุงเทพ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "138 ถนนสุขุมวิท",
                "address1": null,
                "rating": 5,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000282",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/miami_bangkok-general1.jpg",
                "name": "ไมอามี่กรุงเทพฯ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "2 ซอย 13 ถนนสุขุมวิท",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000294",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/bangkok_lotus_sukhumvit-general1.jpg",
                "name": "โลตัส สุขุมวิท กรุงเทพฯ - บริหารโดยแอคคอร์",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "1 ซอยแดงอุดม, สุขุมวิท 33, แขวงคลองตันเหนือ, เขตวั",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000309",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/rama_gardens_bangkok-general1.jpg",
                "name": "รามา การ์เด้นส์ กรุงเทพฯ",
                "locationName": "ดอนเมือง",
                "locationId": "MA06030005",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "9/9 ถนนวิภาวดี รังสิต แขวงตลาดบางเขน เขตจตุจักร กท",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000310",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/rembrandt_hotel_bangkok-general1.jpg",
                "name": "แรมแบรนดท์โฮเท็ลกรุงเทพ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "19 ถนนสุขุมวิทซอย 18",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000311",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/rex_bangkok-general1.jpg",
                "name": "เร็กซ์กรุงเทพ",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "762/1 ถนนสุขุมวิท",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000313",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/royal_benja-general1.jpg",
                "name": "รอยัล เบญจา",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "39 ซอย สุขุมวิท 5 ถนน เขต วัฒนา",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000315",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/royal_orchid_sheraton_and_towers-general1.jpg",
                "name": "รอยัล ออคิด เชอราตัน",
                "locationName": "เจริญกรุง",
                "locationId": "MA05110010",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "2 ถ. เจริญกรุง ซ. 30 สี่พระยา บางรัก",
                "address1": null,
                "rating": 5,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000331",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/tai_pan-general1.jpg",
                "name": "ไทปัน",
                "locationName": "สุขุมวิท",
                "locationId": "MA05110011",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "25 สุขุมวิท ซอย 23, แขวง คลองเตยเหนือ, เขต วัฒนา",
                "address1": null,
                "rating": 3,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              },
              {
                "id": "MA0511000335",
                "cityId": "MA05110041",
                "countryId": "MA05110001",
                "countryName": "ไทย",
                "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/tongtara_riverview-general1.jpg",
                "name": "ทองธารา ริเวอร์วิว",
                "locationName": "เจริญกรุง",
                "locationId": "MA05110010",
                "cityName": "กรุงเทพมหานคร",
                "styleName": null,
                "startPrice": null,
                "productType": null,
                "address": "9/99 ถนนเจริญกรุง บางคอแหลม",
                "address1": null,
                "rating": 4,
                "review": null,
                "promotionText_line1": null,
                "promotionText_line2": null,
                "capsulePromotion": [],
                "infopromotion": []
              }
            ]
          }
        ]
      }
    }
}
""";
