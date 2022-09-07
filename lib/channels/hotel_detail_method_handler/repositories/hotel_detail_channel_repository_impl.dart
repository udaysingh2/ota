import 'dart:async';

import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_data_source.dart';
import 'package:ota/channels/hotel_detail_method_handler/data_source/hotel_detail_channel_mock_data_source.dart';
import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class PropertyDetailHandlerRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(PropertyDetailHandlerModelChannel) nativeResponse,
      required String methodName});
}

class PropertyDetailHandlerRepositoryImpl
    implements PropertyDetailHandlerRepository {
  PropertyDetailHandlerDataSource? otaDataSource;

  PropertyDetailHandlerRepositoryImpl(
      {PropertyDetailHandlerDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaDataSource = OtaChannelConfig.isModule
          ? PropertyDetailHandlerDataSourceImpl()
          : PropertyDetailHandlerMockDataSourceImpl();
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
      {required Function(PropertyDetailHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
