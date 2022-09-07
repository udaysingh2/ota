import 'dart:async';

import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_data_source.dart';
import 'package:ota/channels/register_confirm_booking_handler/data_source/register_confirm_booking_mock_data_source.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

/// Interface for ExampleRepository repository.
abstract class RegisterConfirmBookingRepository extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName});
}

class RegisterConfirmBookingRepositoryImpl
    implements RegisterConfirmBookingRepository {
  RegisterConfirmBookingDataSource? registerConfirmBookingDataSource;

  RegisterConfirmBookingRepositoryImpl(
      {RegisterConfirmBookingDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      registerConfirmBookingDataSource = OtaChannelConfig.isModule
          ? RegisterConfirmBookingDataSourceImpl()
          : RegisterConfirmBookingMockDataSourceImpl();
    } else {
      registerConfirmBookingDataSource = remoteDataSource;
    }
  }

  @override
  void dispose() {
    registerConfirmBookingDataSource?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName}) {
    return registerConfirmBookingDataSource!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
