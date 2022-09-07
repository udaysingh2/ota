import 'dart:async';

import 'package:ota/channels/examplemethodhandler/data_source/example_channel_data_source.dart';
import 'package:ota/channels/examplemethodhandler/models/example_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class ExampleRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(ExampleResponseModelChannel) nativeResponse,
      required String methodName});
}

class ExampleRepositoryImpl implements ExampleRepository {
  ExampleMethodHandlerDataSource? exampleChannelDataSource;

  ExampleRepositoryImpl({ExampleMethodHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      exampleChannelDataSource = OtaChannelConfig.isModule
          ? ExampleMethodHandlerDataSourceImpl()
          : ExampleMethodHandlerDataSourceImpl();
    } else {
      exampleChannelDataSource = remoteDataSource;
    }
  }

  @override
  void dispose() {
    exampleChannelDataSource?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(ExampleResponseModelChannel) nativeResponse,
      required String methodName}) {
    return exampleChannelDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
