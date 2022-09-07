import 'dart:async';

import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class OtaEReceiptHandlerDataSource extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName});
}

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class OtaEReceiptHandlerDataSourceImpl implements OtaEReceiptHandlerDataSource {
  OtaChannel? otaMethodChannel;
  static OtaChannel? _otaMethodChannelMock;

  static setMock(OtaChannel? otaMockMethodChannel) {
    _otaMethodChannelMock = otaMockMethodChannel;
  }

  OtaEReceiptHandlerDataSourceImpl({OtaChannel? otaMethodChannel}) {
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
      {required Function(OtaEReceiptHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaMethodChannel!.handleNativeMethod(methodName, (data) {
      nativeResponse(OtaEReceiptHandlerModelChannel.fromMap(data));
    });
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }
}
