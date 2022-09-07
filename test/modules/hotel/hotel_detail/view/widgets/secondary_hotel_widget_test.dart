import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/secondary_hotel_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view/room_detail_screen.dart';

import '../../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  testWidgets('SecondaryHotelView has a text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        "secondary": (context) => Card(
              child: SecondaryHotelView(
                secondaryViewModel: SecondaryViewModel(
                  supplierId: '123',
                  supplierName: 'Mark All Services Co., Ltd',
                  roomCode: "fdc",
                  roomType: "room",
                  roomName: "name",
                  nightPrice: 100,
                  totalPrice: 1200.00,
                  roomOffer: RoomOffers(
                    breakfast: 1,
                    payNow: '100',
                    cancellationPolicy: 'yes',
                  ),
                  facilityList: {
                    kWifi: '1',
                  },
                  supplier: '',
                ),
              ),
            ),
        '/roomDetails': (context) => const RoomDetailScreen(),
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
            onPressed: () => Navigator.pushNamed(context, "secondary",
                arguments: getHotelDetailArgumentMock()),
          );
        }),
      ),
    ));
    await tester.pump();
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(OtaNextButton));
  });
}
