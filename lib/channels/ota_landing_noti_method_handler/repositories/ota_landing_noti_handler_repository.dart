import 'dart:async';

import 'package:ota/channels/ota_landing_noti_method_handler/data_source/ota_landing_noti_handler_data_source.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/data_source/ota_landing_noti_handler_mock_data_source.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaLandingNotiHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaLandingNotiHandlerModelChannel) nativeResponse,
      required String methodName});
}

class OtaLandingNotiHandlerRepositoryImpl
    implements OtaLandingNotiHandlerRepository {
  OtaLandingNotiHandlerDataSource? otaDataSource;

  OtaLandingNotiHandlerRepositoryImpl(
      {OtaLandingNotiHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? OtaLandingNotiHandlerDataSourceImpl()
          : OtaLandingNotiHandlerMockDataSourceImpl();
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
      {required Function(OtaLandingNotiHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
