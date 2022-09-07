import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_controller.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_model.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_widget.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';

void main() {
  PopupController controller = PopupController();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  testWidgets('Popup Widget test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
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
            body: BlocBuilder(
                bloc: controller,
                builder: () {
                  return PopupDialog(
                    popupViewModel: PopupDataModel(
                      id: '1',
                      deepLinkUrl: "",
                      imageUrl:
                          "https://manage.robinhood.in.th/ImageData/Hotel/amora_neoluxe_bangkok-general1.jpg",
                    ),
                  );
                }),
          )));
      await tester.pumpAndSettle();
      await tester.pump();
      expect(controller.state, PopupModelState.initial);
    });
  });
}
