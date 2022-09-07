import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/data_sources/tour_booking_cancellation_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_cancellation/repositories/tour_booking_cancellation_repository_impl.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view_model/tour_booking_cancellation_argument_view_model.dart';

import '../../../../helper.dart';
import '../../../../mocks/fixture_reader.dart';
import '../../../hotel/repositories/internet_success_mock.dart';

const _kOtaCancelTextWidgetKey = "OtaTextWidgetKey";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => HttpOverrides.global = null);
  Map<String, dynamic> fullData = json.decode(fixture(
      "tour/tour_booking_cancellation/tour_booking_cancellation_success_mock.json"));
  TourBookingCancellationArgumentViewModel argument =
      TourBookingCancellationArgumentViewModel(
    bookingStatus: "CONFIRMED",
    bookingUrn: "TR220329-AA-0024",
    confirmNo: "confirmNo",
    cancellationPolicyList: "cancellationPolicyList",
    bookingDate: "2022-05-05",
    confirmationDate: "2022-05-02",
  );
  group("Tour Booking Cancel Screen", () {
    testWidgets('Tour Booking Cancel Screen', (WidgetTester tester) async {
      await tester.runAsync(() async {
        TourBookingCancellationRepositoryImpl.setMockInternet(
            InternetSuccessMock());
        TourBookingCancellationRemoteDataSourceImpl.setMock(
            GraphQlResponseMock(result: fullData));
        Widget widget = getMaterialWrapperWithPressButton(
          AppRoutes.tourBookingCancellationScreen,
          argument,
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();
        await tester.tap(find.text("press"));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key(_kOtaCancelTextWidgetKey)).first);
        await tester.pumpAndSettle();
        await tester
            .tap(find.byKey(const Key("CancelReservationButton")).first);
        await tester.pumpAndSettle();
      });
    });
  });
}
