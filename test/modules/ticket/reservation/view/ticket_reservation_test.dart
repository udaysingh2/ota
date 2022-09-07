import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_mock.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';
import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source.dart';
import 'package:ota/domain/tickets/review_reservation/data_source/ticket_review_reservation_remote_data_source_mock.dart';
import 'package:ota/domain/tickets/review_reservation/repositories/ticket_review_reservation_repository_impl.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source.dart';
import 'package:ota/domain/tours/review_reservation/data_sources/pickup_point_remote_data_source_mock.dart';
import 'package:ota/domain/tours/review_reservation/repositories/pickup_point_repository_impl.dart';
import 'package:ota/modules/tickets/reservation/bloc/ticket_review_reservation_bloc.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_argument.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_model.dart';
import 'package:ota/modules/tickets/reservation/view_model/ticket_review_reservation_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_view_model.dart';
import 'package:ota/modules/tours/reservation/bloc/pickup_point_bloc.dart';

import '../../../../helper.dart';
import '../../../hotel/repositories/Internet_success_mock.dart';
import '../../../hotel/repositories/internet_failure_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  TicketReviewReservationModel args = _getTicketReservationDetail();
  group("TicketReservation Screen", () {
    testWidgets('TicketReservation Screen', (WidgetTester tester) async {
      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              TicketReviewReservationMockDataSourceImpl.getMockData())));
      await tester.runAsync(() async {
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pump();
        await tester.pump();
        await tester.tap(find.byType(GestureDetector).first,
            warnIfMissed: false);
        await tester.pump();
      });
    });

    testWidgets('TicketReservation Screen failure',
        (WidgetTester tester) async {
      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetFailureMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetFailureMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              TicketReviewReservationMockDataSourceImpl.getMockData())));
      await tester.runAsync(() async {
        Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen,
          args,
        );

        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
      });
    });

    testWidgets('Ticket reservation Screen Test none', (tester) async {
      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              TicketReviewReservationMockDataSourceImpl.getMockData())));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      bloc.initDefaultValue();

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });

    testWidgets('Ticket reservation Screen Test init', (tester) async {
      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              TicketReviewReservationMockDataSourceImpl.getMockData())));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      bloc.initDetails(args.data);

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });

    testWidgets('Ticket reservation Screen Test initiate', (tester) async {
      final TicketReviewReservationArgument argument =
          TicketReviewReservationArgument(
              bookingDate: DateTime.now(),
              serviceType: 'SIC',
              startTime: '10:00',
              countryId: 'MA05110001',
              ticketReservationArgument: _ticketArgumentList(),
              refCode: 'CL213',
              rateKey: 'TUEyMTExMDAwMDQw',
              zoneId: 'MA21110028',
              price: 1211.5,
              cityId: 'MA05110041',
              serviceId: 'MA21110305',
              timeOfDay: 'AM',
              currency: 'TBH',
              ticketId: 'MA2111000168');

      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(
              TicketReviewReservationMockDataSourceImpl.getMockData())));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      PickUpPointBloc pickUpPointBloc = PickUpPointBloc();
      pickUpPointBloc.getPickUpPointDetail('MA21110028');
      bloc.initiateTicketBooking(argument);

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pump();
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });

    testWidgets('Ticket reservation Screen Test failureUnavailable',
        (tester) async {
      final TicketReviewReservationArgument argument =
          TicketReviewReservationArgument(
              bookingDate: DateTime.now(),
              serviceType: 'SIC',
              startTime: '10:00',
              countryId: 'MA05110001',
              ticketReservationArgument: _ticketArgumentList(),
              refCode: 'CL213',
              rateKey: 'TUEyMTExMDAwMDQw',
              zoneId: 'MA21110028',
              price: 1211.5,
              cityId: 'MA05110041',
              serviceId: 'MA21110305',
              timeOfDay: 'AM',
              currency: 'TBH',
              ticketId: 'MA2111000168');

      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: jsonDecode(_blankMock)));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      bloc.initiateTicketBooking(argument);

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });

    testWidgets('Ticket reservation Screen Test no data', (tester) async {
      final TicketReviewReservationArgument argument =
          TicketReviewReservationArgument(
              bookingDate: DateTime.now(),
              serviceType: 'SIC',
              startTime: '10:00',
              countryId: 'MA05110001',
              ticketReservationArgument: _ticketArgumentList(),
              refCode: 'CL213',
              rateKey: 'TUEyMTExMDAwMDQw',
              zoneId: 'MA21110028',
              price: 1211.5,
              cityId: 'MA05110041',
              serviceId: 'MA21110305',
              timeOfDay: 'AM',
              currency: 'TBH',
              ticketId: 'MA2111000168');

      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: jsonDecode(_errorMock)));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      bloc.initiateTicketBooking(argument);

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });

    testWidgets('Ticket reservation Screen Test no package', (tester) async {
      final TicketReviewReservationArgument argument =
          TicketReviewReservationArgument(
              bookingDate: DateTime.now(),
              serviceType: 'SIC',
              startTime: '10:00',
              countryId: 'MA05110001',
              ticketReservationArgument: _ticketArgumentList(),
              refCode: 'CL213',
              rateKey: 'TUEyMTExMDAwMDQw',
              zoneId: 'MA21110028',
              price: 1211.5,
              cityId: 'MA05110041',
              serviceId: 'MA21110305',
              timeOfDay: 'AM',
              currency: 'TBH',
              ticketId: 'MA2111000168');

      PickUpPointRepositoryImpl.setMockInternet(InternetSuccessMock());
      PickUpPointRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(PickUpPointMockDataSourceImpl.getMockData())));
      CustomerRepositoryImpl.setMockInternet(InternetSuccessMock());
      CustomerRemoteDataSourceImpl.setMock(GraphQlResponseMock(
          result: jsonDecode(CustomerMockDataSourceImpl.getMockData())));
      TicketsReviewReservationRepositoryImpl.setMockInternet(
          InternetSuccessMock());
      TicketReviewReservationRemoteDataSourceImpl.setMock(
          GraphQlResponseMock(result: jsonDecode(_noPackageMock)));
      TicketReviewReservationBloc bloc = TicketReviewReservationBloc();
      bloc.initiateTicketBooking(argument);

      Widget widget = getWidgetPressButtonWithProvider(
          AppRoutes.ticketReservationScreen, args);

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.text("press"));
      await tester.pumpAndSettle();
    });
  });
}

TicketReviewReservationModel _getTicketReservationDetail() {
  return TicketReviewReservationModel(
      argument: TicketReviewReservationArgument(
          bookingDate: DateTime.now(),
          price: 1200.00,
          countryId: 'MA05110001',
          refCode: '1000',
          ticketReservationArgument: _ticketArgumentList(),
          cityId: 'MA05110041',
          rateKey: '123',
          serviceId: '123',
          currency: 'INR',
          zoneId: '123',
          ticketId: 'MA2111000168',
          timeOfDay: "AM",
          startTime: "10:00",
          serviceType: "SIC"),
      data: TicketReviewReservationViewModel(
          ticketPackage: _ticketPackageViewModelData(),
          ticketId: 'MA2111000168',
          totalSelectedTicket: 2,
          lastPrice: 1200.00,
          ticketImage:
              'https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg',
          promotionData: [
            OtaFreeFoodPromotionModel(
              headerText: "Free food delivery",
              subHeaderText: "Free food",
              deepLinkUrl: "www.google.com",
              headerIcon:
                  "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg",
              promotionCode: "tcvgsxksdh",
              line1: "Free food delivery",
            )
          ],
          bookingUrn: 'TT220120-AA-0026',
          totalPrice: 1200.00,
          ticketName: 'abc'),
      ticketTypes: _ticketList(),
      lastPrice: 1200.00);
}

List<TicketTypes> _ticketList() {
  List<TicketTypes> list = [];
  list.add(TicketTypes(
      name: "ผู้ใหญ่",
      paxId: "MA21110021",
      price: 100,
      minimum: 2,
      available: 4,
      ticketCount: 2));
  return list;
}

List<TicketReservationArgument> _ticketArgumentList() {
  List<TicketReservationArgument> list = [];
  list.add(TicketReservationArgument(
      paxId: 'MA21110020', name: 'เด็ก 4-11 ปี', noOfTickets: 1, price: 50));
  return list;
}

TicketPackageViewModel _ticketPackageViewModelData() {
  return TicketPackageViewModel(
      name: 'test',
      ticketHighlights: _ticketHighlightList(),
      cancellationPolicy:
          'You have to cancel 2 day(s) prior to the service date., Otherwise cancellation charge of Full Charge from Grand total will be applied..',
      cancellationHeader: 'abc',
      currency: 'INR',
      refCode: '123',
      serviceId: '123',
      rateKey: '123',
      durationText: '8 hours ',
      duration: '8',
      zoneId: '123',
      requireInfo: _ticketInfoData(),
      ticketTypeList: _ticketTypeData());
}

List<TicketHighlight> _ticketHighlightList() {
  List<TicketHighlight> list = [];
  list.add(TicketHighlight(
      key: 'ticketTime', value: 'Full day tour starts at 09:00 AM'));
  return list;
}

List<TicketTypeViewModel> _ticketTypeData() {
  List<TicketTypeViewModel> list = [];
  list.add(TicketTypeViewModel(
      paxId: 'MA21110020', name: 'เด็ก 4-11 ปี', noOfTickets: 1, price: 50));
  return list;
}

TicketRequireInfoViewModel _ticketInfoData() {
  return TicketRequireInfoViewModel(
      weight: true,
      allName: true,
      guestName: true,
      passportId: true,
      dateOfBirth: true,
      passportCountry: true,
      passportValidDate: true,
      passportCountryIssue: true);
}

var _blankMock = '''
{
  "getTicketBookingInitiateDetails": {
    "data": {
      
    },
    "status": {
      "code": "1899",
      "header": "member_login_failure",
      "description": null
    }
  }
}
	''';

var _errorMock = '''
{
  "getTicketBookingInitiateDetails": {
    "data": {
      
    },
    "status": {
      "code": "1899",
      "header": "not_found",
      "description": null
    }
  }
}
	''';

var _noPackageMock = '''
{
  "getTicketBookingInitiateDetails": {
    "data": {
      "bookingUrn": "TT211230-AA-0009",
      "totalPrice": 1000.20,
      "ticketName": " บัตรเข้าสวนสนุกดรีมเวิลด์ (Dream World)(Hello We Sell Tour & Ticket)",
      "ticketImage": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/dream-world--ma2111000168-general1.jpeg",
      "promotionList": [
        {
          "productType": "TICKET",
          "promotionCode": "FREEDELIVERY",
          "title": "Free Food Delivery",
          "description": "Book Now! Free Robinhood Delivery. Unlimited deliveries up to 7 days! Reserve from Now - 30 September 2022",
          "web": "https://cms.robinhood.in.th/archives/2869"
        }
      ]
    }
  },
  "status": {
    "code": "1000",
    "header": "Success",
    "description": null
  }
}
	''';
