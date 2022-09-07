import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/persistence/hive/boxes.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';
import 'package:ota/modules/car_rental/car_landing/view/car_landing_screen.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_recommendation_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String _kRecommendationButton = "CarRecommendationButton";
const _keyCarDateTimePicker = "CarDateTimePickerButton";
const String _kOtaAppBar = "OtaAppBarButton";

void main() {
  CarRecommendedLocationBloc carRecommendedLocationBloc =
      CarRecommendedLocationBloc();

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
  Map<String, dynamic> fullData = json.decode(
      fixture("hotel_landing/hotel_recommended_location/hotel_recommend.json"));

  RecommendedLocationRepositoryImpl.setMockInternet(InternetSuccessMock());

  testWidgets("Car Landing Screen", (WidgetTester tester) async {
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: fullData));
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(MultiProvider(
        providers: [
          ChangeNotifierProvider<CarDatesLocationUpdateViewModel>(
              create: (context) => CarDatesLocationUpdateViewModel()),
          ChangeNotifierProvider<LoginModel>(create: (context) => LoginModel())
        ],
        builder: (_, child) {
          return const CarLandingScreen();
        },
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      // await tester.tap(find.byKey(const Key(_kOtaCarDriverAgeButton)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kOtaAppBar)));
      if (carRecommendedLocationBloc.isSuccess &&
          !carRecommendedLocationBloc.isRecommendationsEmpty) {
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key(_kRecommendationButton)));
        await tester.pumpAndSettle();
      }
      await tester.pump();
    });
  });

  testWidgets("Car Landing Screen Test 2", (WidgetTester tester) async {
    RecommendedLocationRemoteDataSourceImpl.setMock(
        GraphQlResponseMock(result: fullData));
    await tester.runAsync(() async {
      Widget widget = getMaterialWrapper(MultiProvider(
        providers: [
          ChangeNotifierProvider<CarDatesLocationUpdateViewModel>(
              create: (context) => CarDatesLocationUpdateViewModel()),
          ChangeNotifierProvider<LoginModel>(create: (context) => LoginModel())
        ],
        builder: (_, child) {
          return const CarLandingScreen();
        },
      ));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key(_keyCarDateTimePicker)), findsWidgets);
      await tester.pumpAndSettle();
    });
  });
}
