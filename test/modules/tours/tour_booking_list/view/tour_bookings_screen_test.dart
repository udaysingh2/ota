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
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tours/tour_bookings/bloc/tour_bookings_bloc.dart';
import 'package:ota/modules/tours/tour_bookings/view/tour_bookings_screen.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_tile.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/material_wrapper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

void main() {
  final TourBookingsBloc tourBloc = TourBookingsBloc();
  final BookingListModelDomain modelDomain = BookingListModelDomain.fromMap(
      jsonDecode(fixture("tour/tour_bookings/tour_bookings.json")));

  List<BookingDetail> cancelledBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<BookingDetail> completedBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<BookingDetail> upcomingBooking =
      modelDomain.getBookingSummaryV2?.data?.bookingDetails ?? [];
  List<TourBookingViewModel> _getTourBookingsViewModel(
      List<BookingDetail> bookingModel) {
    return bookingModel
        .map((e) => TourBookingViewModel.fromBookingDetailsModel(
            e.tour!, e.serviceType!))
        .toList();
  }

  BookingListUseCasesImpl tourBookingListUseCases = BookingListUseCasesImpl(
      repository: BookingListRepositoryImpl(
          remoteDataSource: BookingListMockDataSourceImpl(),
          internetInfo: InternetSuccessMock()));

  group("Favourites Tour List", () {
    SharedPreferences.setMockInitialValues({"": ""});
    BookingListRepositoryImpl.setMockInternet(InternetSuccessMock());

    testWidgets('Tour Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        TourBookingsBloc bookingsBloc = TourBookingsBloc();
        bookingsBloc.bookingHistoryUseCases = tourBookingListUseCases;

        Widget widget =
            getMaterialWrapper(TourBookingsScreen(tourBloc: bookingsBloc));

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await bookingsBloc.getTourBookingHistoryData(type: "tyuyhijh");
        await tester.pumpWidget(widget);
        await tester.pump();
      });
    });

    testWidgets('Tour Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        TourBookingsBloc bookingsBloc = TourBookingsBloc();
        bookingsBloc.bookingHistoryUseCases = tourBookingListUseCases;

        Widget widget =
            getMaterialWrapper(TourBookingsScreen(tourBloc: bookingsBloc));

        await tester.pumpWidget(widget);
        await tester.pump();
        await tester.pump();
        await bookingsBloc.getTourBookingHistoryData(type: "tour_key");
        await tester.pumpWidget(widget);
        await tester.pump();
      });
    });

    testWidgets('Tour Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRepositoryImpl.setMockInternet(InternetFailureMock());
        Widget widget =
            getMaterialWrapper(TourBookingsScreen(tourBloc: tourBloc));

        await tester.pumpWidget(widget);
        tourBloc.state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.failureNetwork;
        tourBloc.emit(tourBloc.state);
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Tour Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              BookingListMockDataSourceImpl.getMockData(OtaServiceType.tour)),
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
              child: TourBookingsScreen(tourBloc: tourBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        await tourBloc.getTourBookingHistoryData(type: "tour_key");
        await tester.pumpWidget(widget);
        await tourBloc.resetTourBookingList();

        tourBloc.state.cancelledBookings =
            _getTourBookingsViewModel(cancelledBooking);
        tourBloc.state.ongoingBookings =
            _getTourBookingsViewModel(upcomingBooking);
        tourBloc.state.completedBookings =
            _getTourBookingsViewModel(completedBooking);
        tourBloc.state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.success;
        tourBloc.emit(tourBloc.state);
        await tester.pumpAndSettle();
        await tourBloc.updateTourBookingType(0);
        await tester.pump();
        await tester.pump();
        await tourBloc.updateTourBookingType(1);
        await tester.pump();
        await tester.pump();
        await tourBloc.updateTourBookingType(2);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(TourBookingTile).first);
        await tester.pump();
        await tester.pump();
      });
    });

    testWidgets('Tour Booking List Widget', (WidgetTester tester) async {
      await tester.runAsync(() async {
        BookingListRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              BookingListMockDataSourceImpl.getMockData(OtaServiceType.tour)),
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
              child: TourBookingsScreen(tourBloc: tourBloc),
            ),
          ),
        );
        await tester.pumpWidget(widget);
        tourBloc.getTourBookingHistoryData(type: "tour_key");
        await tester.pumpWidget(widget);
        tourBloc.resetTourBookingList();

        tourBloc.state.cancelledBookings =
            _getTourBookingsViewModel(cancelledBooking);
        tourBloc.state.ongoingBookings =
            _getTourBookingsViewModel(upcomingBooking);
        tourBloc.state.completedBookings =
            _getTourBookingsViewModel(completedBooking);
        tourBloc.state.tourBookingsHistoryViewModelState =
            TourBookingsHistoryViewModelState.success;
        tourBloc.emit(tourBloc.state);
        await tester.pumpAndSettle();
        await tourBloc.updateTourBookingType(0);
        await tester.pump();
        await tester.pump();
        await tourBloc.updateTourBookingType(1);
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(TourBookingTile).first);
        await tester.pump();
        await tester.pump();
      });
    });
  });
}
