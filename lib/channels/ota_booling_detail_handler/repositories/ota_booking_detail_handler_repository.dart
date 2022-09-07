import 'dart:async';

import 'package:ota/channels/ota_booling_detail_handler/data_source/ota_booking_detail_handler_data_source.dart';
import 'package:ota/channels/ota_booling_detail_handler/data_source/ota_booking_handler_mock_data_source.dart';
import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaBookingDetailHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaBookingDetailHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaBookingDetailHandlerRepositoryImpl
    implements OtaBookingDetailHandlerRepository {
  OtaBookingDetailHandlerDataSource? otaDataSource;

  OtaBookingDetailHandlerRepositoryImpl(
      {OtaBookingDetailHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? OtaBookingDetailHandlerDataSourceImpl()
          : OtaBookingHandlerMockDataSourceImpl();
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
      {required Function(OtaBookingDetailHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
