import 'dart:async';

import 'package:ota/channels/ota_property_method_handler/data_source/ota_property_channel_data_source.dart';
import 'package:ota/channels/ota_property_method_handler/data_source/ota_property_channel_mock_data_source.dart';
import 'package:ota/channels/ota_property_method_handler/models/ota_property_reponse_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaPropertyHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaPropertyHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaPropertyHandlerRepositoryImpl implements OtaPropertyHandlerRepository {
  OtaPropertyHandlerDataSource? otaDataSource;

  OtaPropertyHandlerRepositoryImpl(
      {OtaPropertyHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? OtaPropertyHandlerDataSourceImpl()
          : OtaPropertyHandlerMockDataSourceImpl();
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
      {required Function(OtaPropertyHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
