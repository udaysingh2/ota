import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/repositories/car_detail_repository_impl.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_card_widget.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String kRightArrowButton = 'supplierCardArrowClick';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Car supplier Screen Test", () {
    CarSupplierRepositoryImpl.setMockInternet(InternetSuccessMock());

    testWidgets('Car supplier Screen Test with success',
        (WidgetTester tester) async {
      Map<String, dynamic> fullData =
          json.decode(fixture("car_supplier/car_supplier.json"));

      CarSupplierRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: fullData));

      await tester.runAsync(() async {
        await tester.pumpWidget(
          ProviderInitializer(
            MaterialApp(
              navigatorKey: GlobalKeys.navigatorKey,
              routes: AppRoutes.getRoutes(),
              supportedLocales: [
                Locale(LanguageCodes.english.code,
                    LanguageCodes.english.countryCode),
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
                      context,
                      AppRoutes.carSupplierScreen,
                      arguments: _getArgumentData(),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(kRightArrowButton)).first);
        await tester.pumpAndSettle();

        await tester.tap(find.byType(CarSupplierCardWidget).at(0),
            warnIfMissed: false);

        await tester.tap(find.byKey(const Key("ReserveButton")).first);
      });
    });

    testWidgets('Car supplier Screen Test with No data',
        (WidgetTester tester) async {
      Map<String, dynamic> fullData =
          json.decode(fixture("carRental/car_rental_detail_with_no_data.json"));

      CarSupplierRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: fullData));
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
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
                  context,
                  AppRoutes.carSupplierScreen,
                  arguments: _getArgumentData(),
                ),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await Future.delayed(const Duration(seconds: 1));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });
  });
  group("Car Supplier screen test ", () {
    Map<String, dynamic> fullData =
        json.decode(fixture("car_supplier/car_supplier.json"));
    Map<String, dynamic> carDetailData =
        json.decode(fixture("carRental/car_rental_detail_mock.json"));
    testWidgets('Car Supplier screen test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        CarSupplierRepositoryImpl.setMockInternet(InternetSuccessMock());
        CarDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
        CarSupplierRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        CarDetailRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: carDetailData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.carSupplierScreen,
          _getArgumentData(),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key("supplierListArrowKey")).first);
        await tester.pump();
        await tester.pump();
      });
    });
  });
}

_getArgumentData() {
  return CarSupplierArgumentViewModel(
    carId: '2',
    pickupLocationId: 'pickupLocation',
    returnLocationId: 'pickupLocation',
    pickupDate: DateTime.now(),
    returnDate: DateTime.now(),
    includeDriver: 'false',
    residenceCountry: 'Bangkok',
    currency: 'THB',
    rentalType: 'day',
    age: 8,
    pickupCounter: '06',
    returnCounter: '06',
    craftType: "craftType",
    carName: "",
    brandName: "",
    pickupLocation: "",
    returnLocation: "",
    thumbImage: "",
  );
}
