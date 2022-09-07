import 'dart:async';

import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class BookingConfirmHandlerDataSource extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName});
}

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class BookingConfirmHandlerDataSourceImpl
    implements BookingConfirmHandlerDataSource {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannelMock;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannelMock = otaMockMethodChannel;
  }

  BookingConfirmHandlerDataSourceImpl({OtaChannel? otaMethodChannel}) {
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
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaMethodChannel!.handleNativeMethod(methodName, (data) {
      nativeResponse(BookingConfirmHandlerModelChannel.fromMap(data));
    });
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
