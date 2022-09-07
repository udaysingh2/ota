import 'dart:async';

import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_data_source.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/data_source/ota_ereceipt_handler_mock_data_source.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaEReceiptHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaEReceiptHandlerRepositoryImpl implements OtaEReceiptHandlerRepository {
  OtaEReceiptHandlerDataSource? otaDataSource;

  OtaEReceiptHandlerRepositoryImpl(
      {OtaEReceiptHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? OtaEReceiptHandlerDataSourceImpl()
          : OtaEReceiptHandlerMockDataSourceImpl();
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
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
