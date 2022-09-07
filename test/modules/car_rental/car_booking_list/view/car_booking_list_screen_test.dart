import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/localization.dart';
import 'package:ota/domain/managed_booking/data_sources/booking_list_remote_data_source.dart';
import 'package:ota/domain/managed_booking/data_sources/booking_list_remote_mock.dart';
import 'package:ota/domain/managed_booking/models/booking_list_model_domain.dart';
import 'package:ota/domain/managed_booking/repositories/booking_list_repository_impl.dart';
import 'package:ota/domain/managed_booking/usecases/booking_list_use_cases.dart';
import 'package:ota/modules/car_rental/car_booking_list/bloc/car_booking_list_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_list/view/car_booking_list_screen.dart';
import 'package:ota/modules/car_rental/car_booking_list/view/widgets/car_booking_list_tile_widget.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/ota_common/view/ota_booking_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../helper/material_wrapper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  final CarBookingListBloc carBloc = CarBookingListBloc();
  final BookingListModelDomain modelDomain = BookingListModelDomain.fromMap(
      jsonDecode(fixture("car_booking_list/car_booking_list.json")));

  List<BookingDetail> cancelledBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<BookingDetail> completedBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<BookingDetail> upcomingBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<CarBookingViewModel> _getCarBookingsViewModel(
      List<BookingDetail> bookingModel) {
    return bookingModel.map((e) => CarBookingViewModel.fromModel(e)).toList();
  }

  BookingListUseCasesImpl carBookingListUseCases = BookingListUseCasesImpl(
    repository: BookingListRepositoryImpl(
      remoteDataSource: BookingListMockDataSourceImpl(),
      internetInfo: InternetSuccessMock(),
    ),
  );

  group("Car booking list test...", () {
    SharedPreferences.setMockInitialValues({"": ""});
    BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());

    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        CarBookingListBloc bookingsBloc = CarBookingListBloc();
        bookingsBloc.bookingHistoryUseCases = carBookingListUseCases;

        Widget widget =
            getMaterialWrapper(CarBookingsScreen(carBloc: bookingsBloc));

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await bookingsBloc.getCarBookingHistoryData(type: "abc");
        await tester.pumpWidget(widget);
        await tester.pump();
      });
    });

    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        CarBookingListBloc bookingsBloc = CarBookingListBloc();
        bookingsBloc.bookingHistoryUseCases = carBookingListUseCases;

        Widget widget =
            getMaterialWrapper(CarBookingsScreen(carBloc: bookingsBloc));

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await bookingsBloc.getCarBookingHistoryData(type: "car_key");
        await tester.pumpWidget(widget);
        await tester.pump();
      });
    });

    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());
        Widget widget = getMaterialWrapper(CarBookingsScreen(carBloc: carBloc));

        await tester.pumpWidget(widget);
        carBloc.state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.failureNetwork;
        carBloc.emit(carBloc.state);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(BookingListMockDataSourceImpl.getMockData(
              OtaServiceType.carRental)),
        ));
        Widget widget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
              return supportedLocales.elementAt(0);
            },
            routes: AppRoutes.getRoutes(),
            home: Material(
              child: CarBookingsScreen(carBloc: carBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        await carBloc.getCarBookingHistoryData(type: "car_key");
        await tester.pumpWidget(widget);
        await carBloc.resetCarBookingList();

        carBloc.state.cancelledBookings =
            _getCarBookingsViewModel(cancelledBooking);
        carBloc.state.ongoingBookings =
            _getCarBookingsViewModel(upcomingBooking);
        carBloc.state.completedBookings =
            _getCarBookingsViewModel(completedBooking);
        carBloc.state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.success;
        carBloc.emit(carBloc.state);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(OtaChipBooking).first);
        await tester.pumpAndSettle();
        await carBloc.updateCarBookingType(0);
        await tester.pump();
        await tester.pump();
        await carBloc.updateCarBookingType(1);
        await tester.pump();
        await tester.pump();
        await carBloc.updateCarBookingType(2);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(CarBookingListTile).first);
        await tester.pump();
        await tester.pump();
      });
    });

    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(BookingListMockDataSourceImpl.getMockData(
              OtaServiceType.carRental)),
        ));
        Widget widget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
              return supportedLocales.elementAt(0);
            },
            routes: AppRoutes.getRoutes(),
            home: Material(
              child: CarBookingsScreen(carBloc: carBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        carBloc.getCarBookingHistoryData(type: "car_key");
        await tester.pumpWidget(widget);
        carBloc.resetCarBookingList();

        carBloc.state.cancelledBookings =
            _getCarBookingsViewModel(cancelledBooking);
        carBloc.state.ongoingBookings =
            _getCarBookingsViewModel(upcomingBooking);
        carBloc.state.completedBookings =
            _getCarBookingsViewModel(completedBooking);
        carBloc.state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.success;
        carBloc.emit(carBloc.state);
        await tester.pumpAndSettle();
        await carBloc.updateCarBookingType(0);
        await tester.pump();
        await tester.pump();
        await carBloc.updateCarBookingType(1);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(CarBookingListTile).first);
        await tester.pump();
        await tester.pump();
      });
    });
    testWidgets('Car Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(BookingListMockDataSourceImpl.getMockData(
              OtaServiceType.carRental)),
        ));
        Widget widget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
              return supportedLocales.elementAt(0);
            },
            routes: AppRoutes.getRoutes(),
            home: Material(
              child: CarBookingsScreen(carBloc: carBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        carBloc.getCarBookingHistoryData(type: "car_key");
        await tester.pumpWidget(widget);
        carBloc.resetCarBookingList();

        carBloc.state.cancelledBookings =
            _getCarBookingsViewModel(cancelledBooking);
        carBloc.state.ongoingBookings =
            _getCarBookingsViewModel(upcomingBooking);
        carBloc.state.completedBookings =
            _getCarBookingsViewModel(completedBooking);
        carBloc.state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.success;
        carBloc.emit(carBloc.state);
        await tester.pumpAndSettle();
        await carBloc.updateCarBookingType(0);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(CarBookingListTile).last);
        await tester.pump();
        await tester.pump();
      });
    });
    testWidgets('Car Booking List Widget Null', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(_responseMockCar),
        ));
        Widget widget = MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            supportedLocales: [
              Locale(LanguageCodes.english.code,
                  LanguageCodes.english.countryCode),
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
              return supportedLocales.elementAt(0);
            },
            routes: AppRoutes.getRoutes(),
            home: Material(
              child: CarBookingsScreen(carBloc: carBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        carBloc.getCarBookingHistoryData(type: "car_key");
        await tester.pumpWidget(widget);
        carBloc.resetCarBookingList();

        carBloc.state.cancelledBookings =
            _getCarBookingsViewModel(cancelledBooking);
        carBloc.state.ongoingBookings =
            _getCarBookingsViewModel(upcomingBooking);
        carBloc.state.completedBookings =
            _getCarBookingsViewModel(completedBooking);
        carBloc.state.carBookingsHistoryViewModelState =
            CarBookingsHistoryViewModelState.success;
        carBloc.emit(carBloc.state);
        await tester.pumpAndSettle();
        await carBloc.updateCarBookingType(0);
        await tester.pump();
        await tester.pump();
        await carBloc.updateCarBookingType(1);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(CarBookingListTile).first);
        await tester.pump();
        await tester.pump();
      });
    });
  });
}

String _responseMockCar = '''{
	"getBookingSummaryV2": {
		"data": null,
		"status": {
			"code": "1899",
			"header": "Failure",
			"description": null
		}
	}
}''';
