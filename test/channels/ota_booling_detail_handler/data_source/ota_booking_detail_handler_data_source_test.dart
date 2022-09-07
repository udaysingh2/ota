import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/ota_booling_detail_handler/data_source/ota_booking_detail_handler_data_source.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  OtaChannel otaChannel = OtaChannelImpl();
  group("OTA booking detail handler data source group", () {
    test('OTA booking detail handler data source', () async {
      OtaBookingDetailHandlerDataSource otaBookingDetailHandlerDataSource =
          OtaBookingDetailHandlerDataSourceImpl(otaMethodChannel: otaChannel);
      // ignore: cancel_subscriptions
      final res = otaBookingDetailHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "bookingDetail");
      // ignore: unnecessary_null_comparison
      expect(res != null, true);
      OtaBookingDetailHandlerDataSourceImpl();
      OtaBookingDetailHandlerDataSourceImpl.setMock(otaChannel);
      otaBookingDetailHandlerDataSource.dispose();
    });
    test('booking handler data source', () async {
      OtaBookingDetailHandlerDataSource otaBookingDetailHandlerDataSource =
          OtaBookingDetailHandlerDataSourceImpl(otaMethodChannel: null);
      // ignore: cancel_subscriptions
      otaBookingDetailHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "bookingDetail");
    });

    test('booking handler data source', () async {
      OtaBookingDetailHandlerDataSource otaBookingDetailHandlerDataSource =
          OtaBookingDetailHandlerDataSourceImpl(
              otaMethodChannel: MockOtaChannel());
      // ignore: cancel_subscriptions
      otaBookingDetailHandlerDataSource.handleMethodChannel(
          nativeResponse: (p0) {}, methodName: "bookingDetail");
    });
  });
}

class MockOtaChannel implements OtaChannel {
  @override
  void dispose() {}

  @override
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic> p1) nativeResponse,
      bool? isDuplicateAllowed}) {
    throw UnimplementedError();
  }

  @override
  StreamSubscription handleNativeMethod(
      String methodName, Function(Map<String, dynamic>) nativeResponse) {
    nativeResponse({});
    return const Stream.empty().listen((event) {});
  }

  @override
  Future<Map<String, dynamic>> invokeNativeMethod(
      {required String methodName, required Map<String, dynamic> arguments}) {
    throw UnimplementedError();
  }
}
