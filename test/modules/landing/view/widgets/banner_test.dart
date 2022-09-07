import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view/widgets/progress_indicator/ota_dot_progess_bloc.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';

void main() {
  testWidgets('Banner Widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
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
          body: BannerWidget(
            bannerList: [
              BannerDataModel(bannerId: "id", deepLinkUrl: "url", imageUrl: ''),
              BannerDataModel(
                  bannerId: "id",
                  deepLinkUrl:
                      "https://www.bing.com/images/search?view=detailV2&ccid=PNnF2OIa&id=77BE606262E02400393B57BC9C4BBE62B6E484EF&thid=OIP.PNnF2OIab7LEdexQyfPW_wHaEK&mediaurl=https%3a%2f%2fmiro.medium.com%2fmax%2f2560%2f1*i_BK998hTB3ohG011Iy5bg.png&exph=720&expw=1280&q=flutter+unit+test&simid=607987809559193392&FORM=IRPRST&ck=1D1BB4DB0E99672BD4F7CBBCAF65D60A&selectedIndex=2",
                  imageUrl:
                      'https://www.bing.com/images/search?view=detailV2&ccid=PNnF2OIa&id=77BE606262E02400393B57BC9C4BBE62B6E484EF&thid=OIP.PNnF2OIab7LEdexQyfPW_wHaEK&mediaurl=https%3a%2f%2fmiro.medium.com%2fmax%2f2560%2f1*i_BK998hTB3ohG011Iy5bg.png&exph=720&expw=1280&q=flutter+unit+test&simid=607987809559193392&FORM=IRPRST&ck=1D1BB4DB0E99672BD4F7CBBCAF65D60A&selectedIndex=2')
            ],
            launchBannerInApp: true,
            onBannerTap: (index) {},
          ),
        )));
    await tester.pump();
    await tester.tap(find.byKey(const Key('banner')).first);
    await tester.pump();
    final gesture = await tester
        .startGesture(const Offset(0, 300)); //Position of the scrollview
    await gesture.moveBy(const Offset(0, -300)); //How much to scroll by
    await tester.pump();
  });
  test("Progress indicator bloc test", () {
    OtaProgressBloc otaProgressBloc = OtaProgressBloc();
    otaProgressBloc.setSelected(1);
    expect(otaProgressBloc.getSelectedIndex(), 1);
  });
}
