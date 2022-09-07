import 'dart:async';

import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_data_source.dart';
import 'package:ota/channels/booking_confirm_payment_handler/data_sources/booking_confirm_handler_mock_data_source.dart';
import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class BookingConfirmHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName});
}

class BookingConfirmHandlerRepositoryImpl
    implements BookingConfirmHandlerRepository {
  BookingConfirmHandlerDataSource? otaDataSource;

  BookingConfirmHandlerRepositoryImpl(
      {BookingConfirmHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? BookingConfirmHandlerDataSourceImpl()
          : BookingConfirmHandlerMockDataSourceImpl();
    } else {
      otaDataSource = remoteDataSource;
    }
  }

  @override
  void dispose() {
    otaDataSource?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
