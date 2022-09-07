import 'dart:async';

import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class RegisterConfirmBookingDataSource extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName});
}

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class RegisterConfirmBookingDataSourceImpl
    implements RegisterConfirmBookingDataSource {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannelMock;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannelMock = otaMockMethodChannel;
  }

  RegisterConfirmBookingDataSourceImpl({OtaChannel? otaMethodChannel}) {
    if (_otaMethodChannelMock != null) {
      this.otaMethodChannel = _otaMethodChannelMock;
    } else if (otaMethodChannel == null) {
      this.otaMethodChannel = OtaChannelImpl.handleNativeMethod();
    } else {
      this.otaMethodChannel = otaMethodChannel;
    }
  }

  ///Use [StreamSubscription] to cancel the listener
  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName}) {
    return otaMethodChannel!.handleNativeMethod(methodName, (data) {
      nativeResponse(RegisterConfirmBookingModelChannel.fromMap(data));
    });
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
