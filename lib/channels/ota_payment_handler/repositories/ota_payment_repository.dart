import 'dart:async';

import 'package:ota/channels/ota_payment_handler/data_source/ota_payment_data_source.dart';
import 'package:ota/channels/ota_payment_handler/data_source/ota_payment_mock_data_source.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class OtaPaymentRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel) nativeResponse,
      required String methodName});
}

class OtaPaymentRepositoryImpl implements OtaPaymentRepository {
  OtaPaymentDataSource? otaPaymentDataSource;

  OtaPaymentRepositoryImpl({OtaPaymentDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      otaPaymentDataSource = OtaChannelConfig.isModule
          ? OtaPaymentDataSourceImpl()
          : OtaPaymentMockDataSourceImpl();
    } else {
      otaPaymentDataSource = remoteDataSource;
    }
  }

  @override
  void dispose() {
    otaPaymentDataSource?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(OtaPaymentModelChannel) nativeResponse,
      required String methodName}) {
    return otaPaymentDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
