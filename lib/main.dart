import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/debug_helper/debug_widget.dart';
import 'common/helpers/navigator_helper.dart';
import 'common/helpers/print_helper.dart';
import 'common/utils/consts.dart';
import 'common/utils/navigation_helper.dart';
import 'common/utils/platform_specifics_helper.dart';
import 'core/app_config.dart';
import 'core/app_routes.dart';
import 'core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/widget/localizations.dart';
import 'core_pack/i18n/language_codes.dart';
import 'core_pack/i18n/localization.dart';
import 'core_pack/persistence/hive/boxes.dart';
import 'debug_helper/debug_utilities.dart';
import 'modules/authentication/helper/auth_navigtor_helper.dart';
import 'modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CarRecentSearchDataAdapter());
  await Hive.openBox<CarRecentSearchData>(BoxKeys.kRecentSearchBox);
  runZonedGuarded(
    () async {
      await PlatformSpecificsHelper.checkForMaterialYou();
      runApp(const MyApp());
    },
    (error, stackTrace) {
      printDebug(stackTrace);
      printDebug(error);
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
        if (kDebugMode) {
          parent.print(zone, message);
        }
      },
    ),
  );
  FlutterError.onError = (FlutterErrorDetails details) {
    printDebug(details.exception);
    printDebug(details.stack);
  };
}

final _kThaiLocale =
    Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode);
final _kEngLocale =
    Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }

  static Locale getLocal(BuildContext context) {
    final state = context.findAncestorStateOfType<MyAppState>();
    return state?.getLocale ??
        Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode);
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;
  Locale? get getLocale => _locale;

  setLocale(Locale locale) {
    AppConfig().appLocale = locale;
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    // getLocale().then((locale) {
    //   setState(() {
    //     this._locale = locale;
    //   });
    // });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _locale ??= _kThaiLocale;
    // WidgetsBinding.instance?.addPostFrameCallback((_) async {
    //   _getConfigData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderInitializer(getMaterialApp());
  }

  Widget getMaterialApp() {
    return MaterialApp(
      navigatorKey: GlobalKeys.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'OTA App',
      locale: _locale,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: 1,
          ), // To ignore mobile's text scaling settings
          child: (DebugUtils.isBuildForDebug())
              ? Stack(
                  children: [
                    child ?? Container(),
                    Overlay(
                      initialEntries: [
                        OverlayEntry(
                          builder: (context) => const DebugWidget(),
                        ),
                      ],
                    ),
                  ],
                )
              : child ?? Container(),
        );
      },
      supportedLocales: [_kEngLocale, _kThaiLocale],
      localizationsDelegates: const [
        Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: PlatformSpecificsHelper.useMaterialYouUi,
        primarySwatch: Colors.purple,
        fontFamily: kFontFamily,
        canvasColor: AppColors.kLight100,
        splashColor: AppColors.kSecondarySplash,
        hoverColor: AppColors.kSecondarySplash,
        highlightColor: AppColors.kSecondarySplash,
      ),
      localeResolutionCallback: (locale, supportedLocales) {
        return _locale;
      },
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.getRoutes(),
      navigatorObservers: [MyNavigatorObserver()],
    );
  }
}
