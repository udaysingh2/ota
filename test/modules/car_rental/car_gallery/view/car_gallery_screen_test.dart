import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_data_source_mock.dart';
import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_gallery/repositories/car_gallery_repository_impl.dart';

import 'package:ota/modules/car_rental/car_gallery/bloc/car_gallery_bloc.dart';
import 'package:ota/modules/car_rental/car_gallery/view/car_gallery_screen.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

import '../../../../helper/material_wrapper.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

String imgurl =
    'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg';

void main() {
  testWidgets('Car Gallery Screen ...', (tester) async {
    GlobalKey<CarGalleryScreenState> key = GlobalKey();
    final CarGalleryArgumentModel argument =
        CarGalleryArgumentModel(carId: "2");
    Widget widget = getMaterialWrapperWithArguments(
        CarGalleryScreen(
          key: key,
        ),
        AppRoutes.carGalleryScreen,
        argument);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    CarGalleryBloc carGalleryBloc = key.currentState?.bloc ?? CarGalleryBloc();
    carGalleryBloc.state.galleryList = [];
    carGalleryBloc.emit(CarGalleryViewModel(
        galleryList: [],
        galleryListViewModelState: CarGalleryViewModelState.loading));
    await tester.pump();
    key.currentState?.scrollListener();
    expect(find.byType(OtaAppBar), findsOneWidget);
    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(OtaRefreshIndicator), findsWidgets);
    await tester.pump();
    carGalleryBloc.emit(CarGalleryViewModel(
        galleryList: [],
        galleryListViewModelState: CarGalleryViewModelState.success));
    await tester.pump();
    carGalleryBloc.emit(CarGalleryViewModel(galleryList: [
      CarGalleryModel(
        full: imgurl,
        thumb: imgurl,
      ),
      CarGalleryModel(
        full: imgurl,
        thumb: '',
      ),
      CarGalleryModel(
        full: '',
        thumb: imgurl,
      ),
      CarGalleryModel(
        full: imgurl,
        thumb: imgurl,
      ),
      CarGalleryModel(
        full: imgurl,
        thumb: imgurl,
      ),
      CarGalleryModel(
        full: imgurl,
        thumb: imgurl,
      ),
    ], galleryListViewModelState: CarGalleryViewModelState.loading));
    await tester.pump();
    await tester.pumpAndSettle();

    carGalleryBloc.emit(CarGalleryViewModel(galleryList: [
      CarGalleryModel(
        full:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jg',
        thumb:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jg',
      ),
      CarGalleryModel(
        full:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jg',
        thumb:
            'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.pg',
      ),
    ], galleryListViewModelState: CarGalleryViewModelState.success));
    await tester.pump();

    carGalleryBloc.emit(CarGalleryViewModel(galleryList: [
      CarGalleryModel(thumb: "", full: ""),
      CarGalleryModel(thumb: "", full: ""),
    ], galleryListViewModelState: CarGalleryViewModelState.failure));
    await tester.pump();
    carGalleryBloc.emit(CarGalleryViewModel(
        galleryList: [],
        galleryListViewModelState: CarGalleryViewModelState.success));
    await tester.pump();
  });

  CarGalleryRepositoryImpl.setMockInternet(InternetSuccessMock());
  testWidgets("Car Gallery 2", (WidgetTester tester) async {
    Map<String, dynamic> map =
        jsonDecode(CarGalleryMockDataSourceImpl.getMockData());
    Map<String, dynamic> fullData = {"getAllCarRentalImages": map};

    CarGalleryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: fullData,
    ));
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
        body: Builder(builder: (context) {
          return TextButton(
            child: const Text("press"),
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.carGalleryScreen,
                arguments: CarGalleryArgumentModel(carId: '2')),
          );
        }),
      ),
    ));
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
  });

  testWidgets("Car Gallery 2 failure", (WidgetTester tester) async {
    Map<String, dynamic> map =
        jsonDecode(CarGalleryMockDataSourceImpl.getNoRespMockData());
    Map<String, dynamic> fullData = {"getAllCarRentalImages": map};

    CarGalleryRemoteDataSourceImpl.setMock(GraphQlResponseMock(
      result: fullData,
    ));
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
        body: Builder(builder: (context) {
          return TextButton(
            child: const Text("press"),
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.carGalleryScreen,
                arguments: CarGalleryArgumentModel(carId: '2')),
          );
        }),
      ),
    ));
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text("press"));
    await tester.pumpAndSettle();
  });
}
