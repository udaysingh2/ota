import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';

Widget getMaterialWrapper(Widget child, {int languageIndex = 1}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Kanit',
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(languageIndex);
        },
        home: Material(child: child)),
  );
}

Widget getMaterialWrapperWithArguments(
    Widget child, String routeName, dynamic argument) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: MaterialApp(
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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Kanit',
        ),
        localeResolutionCallback: (locale, supportedLocales) {
          return supportedLocales.elementAt(1);
        },
        home: Material(
            child: TestArgumentWidget(
          routeName: routeName,
          argument: argument,
          child: child,
        ))),
  );
}

class TestArgumentWidget extends StatelessWidget {
  final String routeName;
  final dynamic argument;
  final Widget child;

  const TestArgumentWidget(
      {Key? key, required this.routeName, this.argument, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      Navigator.of(context).pushNamed(routeName, arguments: argument);
    });
    return Container();
  }
}
