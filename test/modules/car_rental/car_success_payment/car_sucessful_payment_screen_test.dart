import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../mocks/hotel/hotel_success_payment/hotel_success_payment_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);

  testWidgets('Car Success Payment Screen ', (WidgetTester tester) async {
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
              Provider.of<LandingPageViewModel>(context).serviceList =
                  getLandingPageServiceCards();
              return TextButton(
                child: const Text("press"),
                onPressed: () => Navigator.pushNamed(
                    context, AppRoutes.carPaymentSuccessScreen,
                    arguments: _getArgumentData()),
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
}

CarPaymentArgumentModel _getArgumentData() {
  OtaCountDownController otaCountDownController =
      OtaCountDownController(durationInSecond: 1000);

  return CarPaymentArgumentModel(
    totalPrice: 1000.00,
    age: 30,
    carName: 'Accord',
    brandName: 'Honda',
    serviceProvider: 'ABC',
    bagLargeNbr: 4,
    bagSmallNbr: 4,
    seatNbr: 5,
    gear: '6',
    otaCountDownController: otaCountDownController,
    doorNbr: 4,
    pickupDate: DateTime.now(),
    returnDate: DateTime.now(),
    pickUpPoint: "abc",
    droffPoint: "abc",
    duration: 3,
    firstName: 'first',
    secondName: 'second',
    driverFirstName: 'driver',
    driverLastName: 'last',
    flightNumber: '123',
    driverAge: 32,
    extraCharge: getExtraCharge(),
    bookingUrn: "123",
    rateKey: "123",
    refCode: "123",
    imageUrl: "https://train.travflex.com/ImageData/Car/crv-1.jpg",
    logoUrl: "https://train.travflex.com/ImageData/Car/crv-1.jpg",
    craftType: "craftType",
    carReservationViewArgumentModel: getData(),
    pricePerDay: 100,
    meetingPointDescription: 'qwwert',
    pickUpaddress: "Don Mong",
    pickUpOpenTime: "12",
    pickUpCloseTime: "98",
    returnPointDescription: "jjjj",
    returnAddress: "jhgg",
    returnOpenTime: "jhbjbj",
    returnCloseTime: "hbhbh",
    fuelType: "kjhh",
    engine: "hv",
    year: DateTime.now().year,
    facilities: ['a', 'b', 'c'],
    carDetailInfoDataViewModel: CarInfoDataViewModel(
      carDetailsPickUp: getInfo(),
      carDetails: getInfo(),
      carDetailsDropOff: getInfo(),
      pricing: carDetailInfoPricing(),
      facilities: ['q', 'e'],
      carInfo: carDetailInfoCarMainData(),
      pickupLocation: LocationsModelData(
        lattitude: 'qwee',
        longitude: 'qwee',
      ),
      dropOffLocation: LocationsModelData(
        lattitude: 'dhdhd',
        longitude: 'ghgh',
      ),
    ),
  );
}

List<ExtraChargeData>? getExtraCharge() {
  return [
    ExtraChargeData(
      id: 1,
      carRateId: 2,
    )
  ];
}

CarReservationViewArgumentModel getData() {
  return CarReservationViewArgumentModel();
}

List<CarDetailInfoCell> getInfo() {
  return [
    CarDetailInfoCell(
        imagePath: "https://train.travflex.com/ImageData/Car/crv-1.jpg",
        subTitle: "qwww",
        title: "ddd")
  ];
}

CarDetailInfoPricing carDetailInfoPricing() {
  return CarDetailInfoPricing(costPerDay: '1000', totalCost: '1999');
}

CarDetailInfoCarMainData carDetailInfoCarMainData() {
  return CarDetailInfoCarMainData(
      title: 'title',
      imagePath: 'https://train.travflex.com/ImageData/Car/crv-1.jpg');
}
