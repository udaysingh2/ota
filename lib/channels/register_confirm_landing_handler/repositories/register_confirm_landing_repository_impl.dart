import 'dart:async';

import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_data_source.dart';
import 'package:ota/channels/register_confirm_landing_handler/data_source/register_confirm_landing_mock_data_source.dart';
import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class RegisterConfirmLandingRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmLandingModelChannel) nativeResponse,
      required String methodName});
}

class RegisterConfirmLandingRepositoryImpl
    implements RegisterConfirmLandingRepository {
  RegisterConfirmLandingDataSource? registerConfirmLandingDataSource;

  RegisterConfirmLandingRepositoryImpl(
      {RegisterConfirmLandingDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      registerConfirmLandingDataSource = OtaChannelConfig.isModule
          ? RegisterConfirmLandingDataSourceImpl()
          : RegisterConfirmLandingMockDataSourceImpl();
    } else {
      registerConfirmLandingDataSource = remoteDataSource;
    }
  }

  @override
  void dispose() {
    registerConfirmLandingDataSource?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmLandingModelChannel) nativeResponse,
      required String methodName}) {
    return registerConfirmLandingDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
