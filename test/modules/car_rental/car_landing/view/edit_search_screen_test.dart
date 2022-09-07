import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/data_sources/recommended_location_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/repositories/recommended_location_repo_impl.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_landing/view/edit_search_screen.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_diffrent_drop_toggel.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    HttpOverrides.global = null;
  });
  Map<String, dynamic> fullData = json.decode(
      fixture("hotel_landing/hotel_recommended_location/hotel_recommend.json"));

  RecommendedLocationRepositoryImpl.setMockInternet(InternetSuccessMock());

  testWidgets("Edit Search Screen test", (WidgetTester tester) async {
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
          return const EditSearchScreen();
        },
      ));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaTextButton).last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CarLandingDifferentDropToggle).first);
      await tester.pumpAndSettle();
    });
  });
}
