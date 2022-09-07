import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/repositories/car_detail_repository_impl.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_heart_button.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_share_button.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const String _kCarDetailListKey = "car_detail_list_key";
const String _kLastSizeBoxKey = "last_size_box_key";
const String _kCarPickUpDropOffWidgetKey = "car_pickup_dropoff_key";
const String _kBackIconKey = "back_icon_key";
const String _kCarDetailSuccessSliverListKey =
    "car_detail_success_sliver_list_key";
const String _kCarDeatilPriceWidgetKey = "car_detail_price_widget_key";
const String _kCarDetailStickyBarKey = 'car_detail_sticky_bar_key';
const String _kCarDetailGalleryButtonKey = 'car_detail_gallery_button_key';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  group("Car Detail Screen Test", () {
    CarDetailRepositoryImpl.setMockInternet(InternetSuccessMock());
    testWidgets('Car Detail Screen Test with success',
        (WidgetTester tester) async {
      Map<String, dynamic> fullData =
          json.decode(fixture("carRental/car_rental_detail_mock.json"));

      CarDetailRemoteDataSourceImpl.setMock(
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
                      AppRoutes.carDetailScreen,
                      arguments: _getArgumentData(
                          CarRentalDetailUserType.loggedInUser),
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

        await tester.tap(find.byType(ShareButton));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kCarDetailSuccessSliverListKey)),
          find.byKey(const Key(_kCarDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCarPickUpDropOffWidgetKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCarDetailStickyBarKey)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(AppLocalizationsStrings.includeLabel)),
          find.byKey(const Key(_kCarDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester
            .tap(find.byKey(const Key(AppLocalizationsStrings.includeLabel)));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kBackIconKey)));
        await tester.pumpAndSettle();

        await tester.dragUntilVisible(
          find.byKey(const Key(_kLastSizeBoxKey)),
          find.byKey(const Key(_kCarDetailListKey)),
          const Offset(0, -100),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key(_kCarDeatilPriceWidgetKey)));
      });
    });
    testWidgets('Car Detail screen Test with failure',
        (WidgetTester tester) async {
      CarDetailRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
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
                  AppRoutes.carDetailScreen,
                  arguments:
                      _getArgumentData(CarRentalDetailUserType.loggedInUser),
                ),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Car Detail Screen Test with No data',
        (WidgetTester tester) async {
      Map<String, dynamic> fullData =
          json.decode(fixture("carRental/car_rental_detail_with_no_data.json"));

      CarDetailRemoteDataSourceImpl.setMock(
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
                  AppRoutes.carDetailScreen,
                  arguments:
                      _getArgumentData(CarRentalDetailUserType.loggedInUser),
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

        await tester.tap(find.byKey(const Key(_kCarDetailGalleryButtonKey)));
      });
    });
    testWidgets('Car Detail Screen Test with favourite success',
        (WidgetTester tester) async {
      Map<String, dynamic> fullData =
          json.decode(fixture("carRental/car_rental_detail_mock.json"));

      CarDetailRemoteDataSourceImpl.setMock(
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
                      AppRoutes.carDetailScreen,
                      arguments: _getArgumentData(
                          CarRentalDetailUserType.loggedInUser),
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

        await tester.tap(find.byType(CarDetailHeartButton));
      });
    });
    testWidgets('Car Detail Screen Test with No internet',
        (WidgetTester tester) async {
      CarDetailRepositoryImpl.setMockInternet(InternetFailureMock());

      Map<String, dynamic> fullData =
          json.decode(fixture("carRental/car_rental_detail_with_no_data.json"));

      CarDetailRemoteDataSourceImpl.setMock(
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
                  AppRoutes.carDetailScreen,
                  arguments:
                      _getArgumentData(CarRentalDetailUserType.loggedInUser),
                ),
              );
            }),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });
  });
}

_getArgumentData(CarRentalDetailUserType userType) {
  return CarDetailArgumentModel(
    carId: '2',
    pickupLocationId: 'pickupLocation',
    returnLocationId: 'pickupLocation',
    pickupDate: DateTime.now(),
    returnDate: DateTime.now(),
    supplierId: '12345',
    includeDriver: 'false',
    residenceCountry: 'Bangkok',
    currency: 'THB',
    rentalType: 'day',
    age: 8,
    pickupCounter: '06',
    returnCounter: '06',
    userType: userType,
    cityName: "Bangkok",
    rateKey: "eNqLVjI0VNKJNjKN1THUMTLVMTPQMdAxMosFAEAQBRw",
    refCode: "123qwe",
  );
}
