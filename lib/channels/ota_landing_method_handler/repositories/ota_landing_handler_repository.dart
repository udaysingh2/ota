import 'dart:async';

import 'package:ota/channels/ota_landing_method_handler/data_source/ota_landing_handler_data_source.dart';
import 'package:ota/channels/ota_landing_method_handler/data_source/ota_landing_handler_mock_data_source.dart';
import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaLandingHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaLandingHandlerRepositoryImpl implements OtaLandingHandlerRepository {
  OtaLandingHandlerDataSource? otaDataSource;

  OtaLandingHandlerRepositoryImpl(
      {OtaLandingHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? OtaLandingHandlerDataSourceImpl()
          : OtaLandingHandlerMockDataSourceImpl();
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
      {required Function(OtaLandingHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
