import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/payment_status/data_sources/payment_status_remote_data_source.dart';
import 'package:ota/domain/payment_status/repositories/payment_status_repository_impl.dart';
import 'package:ota/modules/payment_method/view_model/payment_initiate_argument_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/get_customer_details/repositories/customer_repository_impl_test.dart';

void main() {
  late OtaCountDownController otaCountDownController =
      OtaCountDownController(durationInSecond: 10);
  PaymentMethodInitiateArgument paymentMethodInitiateArgument =
      PaymentMethodInitiateArgument(
          currency: "THB",
          otaCountDownController: otaCountDownController,
          bookingUrn: "H20211025AA0232",
          newbookingUrn: "",
          paymentDetails: [
        PaymentMethodTypeArgument(
          paymentMethod: "CARD",
          price: 2200.0,
          paymentMethodId: "1MH23456Z789776D",
          cardType: "JCB",
          cardRef: '',
        )
      ]);
  Widget widget = MaterialApp(
    routes: AppRoutes.getRoutes(),
    supportedLocales: [
      Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode),
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
            AppRoutes.paymentLoadingScreen,
            arguments: paymentMethodInitiateArgument,
          ),
        );
      }),
    ),
  );

  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  group("Payment loading screen with payment status", () {
    SharedPreferences.setMockInitialValues({"": ""});
    PaymentStatusRepositoryImpl.setMockInternet(InternetConnectionInfoMocked());
    // testWidgets('Payment loading screen positive2',
    //     (WidgetTester tester) async {
    //   PaymentStatusRemoteDataSourceImpl.setMock(GraphQlResponseMock(
    //       completion: Future.delayed(Duration(seconds: 1), () async {
    //         print("mock data");
    //         PaymentStatusRemoteDataSourceImpl.setMock(GraphQlResponseMock(
    //             result: jsonDecode(PaymentStatusMockDataSourceImpl
    //                 .getMockDataForPaymentStatus())));
    //       }),
    //       result: jsonDecode(PaymentStatusMockDataSourceImpl.getMockData())));
    //
    //   await tester.runAsync(() async {
    //     await tester.pumpWidget(MultiProvider(providers: [
    //       Provider(
    //         create: (BuildContext context) {
    //           return getHotelSuccessPaymentArgumentModel();
    //         },
    //       ),
    //       Provider(
    //         create: (BuildContext context) {
    //           return LandingPageViewModel();
    //         },
    //       ),
    //     ], child: _widget));
    //     await tester.pump();
    //     await tester.tap(find.text("press"));
    //     await Future.delayed(Duration(seconds: 2));
    //     await tester.pumpAndSettle();
    //   });
    // });

    testWidgets('Payment loading screen with negative case',
        (WidgetTester tester) async {
      PaymentStatusRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(exception: OperationException()));
      await tester.runAsync(() async {
        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.tap(find.text("press"));
        await tester.pump();
      });
    });
  });
}
