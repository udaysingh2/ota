import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/payment_method/view_model/payment_method_argument_model.dart';

const String _kTextKey = 'press';
const String _kPaymentMethodTileKey = 'payment_method_tile';

void main() {
  getMaterialApp({List<PaymentMethodArgumentModel>? screenArgs}) {
    return MaterialApp(
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
            child: const Text(_kTextKey),
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.paymentMethodListScreen,
              arguments: screenArgs,
            ),
          );
        }),
      ),
    );
  }

  testWidgets('payment method list screen ...', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        getMaterialApp(
          screenArgs: [
            PaymentMethodArgumentModel(
              paymentMethodId: '1AB23456C7890123D',
              nickname: 'My Visa',
              paymentMethodType: PaymentMethodType.visa,
              cardMask: '***3456',
              isDefault: true,
            ),
            PaymentMethodArgumentModel(
              paymentMethodId: 'DE523456C7890123D',
              nickname: 'My Jcb',
              paymentMethodType: PaymentMethodType.jcb,
              cardMask: '***8739',
              isDefault: false,
            )
          ],
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(_kTextKey));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key(_kPaymentMethodTileKey)).first);
      await tester.pumpAndSettle();
    });
  });

  testWidgets('payment method list screen with empty payment methods...',
      (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(getMaterialApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text(_kTextKey));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });
}
