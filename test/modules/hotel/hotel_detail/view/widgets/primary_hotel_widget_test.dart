import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/primary_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';

import '../../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  testWidgets('PrimaryHotelView has a text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        "primary": (context) => Card(
              child: PrimaryHotelView(
                primaryViewModel: PrimaryViewModel(
                    secondaryViewState: SecondaryViewState.initial,
                    children: [],
                    nightPrice: 1200,
                    roomName: 'Superior one bed'),
              ),
            ),
      },
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
            onPressed: () => Navigator.pushNamed(context, "primary",
                arguments: getHotelDetailArgumentMock()),
          );
        }),
      ),
    ));
    await tester.pump();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
  });

  testWidgets('PrimaryHotelView with children > 1',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        "primary": (context) => Card(
              child: PrimaryHotelView(
                primaryViewModel: PrimaryViewModel(
                    secondaryViewState: SecondaryViewState.initial,
                    children: [
                      SecondaryViewModel(
                          supplierId: '123',
                          supplierName: 'Mark All Services Co., Ltd',
                          roomName: "roomName",
                          roomType: "roomType",
                          nightPrice: 1200,
                          totalPrice: 1200,
                          roomCode: "roomCode",
                          supplier: ''),
                      SecondaryViewModel(
                          supplierId: '123',
                          supplierName: 'Mark All Services Co., Ltd',
                          roomName: "roomName",
                          roomType: "roomType",
                          nightPrice: 1200,
                          totalPrice: 1200,
                          roomCode: "roomCode",
                          supplier: ''),
                    ],
                    nightPrice: 1200,
                    roomName: 'Superior one bed'),
              ),
            ),
      },
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
            onPressed: () => Navigator.pushNamed(context, "primary",
                arguments: getHotelDetailArgumentMock()),
          );
        }),
      ),
    ));
    await tester.pump();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
  });

  testWidgets('PrimaryHotelView with expanded init state',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        "primary": (context) => SingleChildScrollView(
              child: Card(
                child: PrimaryHotelView(
                  primaryViewModel: PrimaryViewModel(
                      secondaryViewState: SecondaryViewState.expanded,
                      children: [
                        SecondaryViewModel(
                            supplierId: '123',
                            supplierName: 'Mark All Services Co., Ltd',
                            roomName: "roomName",
                            roomType: "roomType",
                            nightPrice: 1200,
                            totalPrice: 1200,
                            roomCode: "roomCode",
                            supplier: ''),
                      ],
                      nightPrice: 1200,
                      roomName: 'Superior one bed'),
                ),
              ),
            ),
      },
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
            onPressed: () => Navigator.pushNamed(context, "primary",
                arguments: getHotelDetailArgumentMock()),
          );
        }),
      ),
    ));
    await tester.pump();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
  });
}
