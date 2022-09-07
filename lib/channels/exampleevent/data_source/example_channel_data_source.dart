import 'dart:async';
import 'package:ota/common/network/disposer.dart';
import 'package:ota/core_components/ota_channel/ota_channel.dart';

abstract class ExampleEventChannelDataSource extends Disposer {
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic>) nativeResponse,
      bool isDuplicateAllowed});
}

///Class will be singleton always so event channel will be always active
///Add listener or remove listeners based on subscription
class ExampleEventChannelDataSourceImpl
    implements ExampleEventChannelDataSource {
  OtaChannel? otaMethodChannel =
      OtaChannelImpl.handleNativeEventChannel("Channel Name");
  static ExampleEventChannelDataSourceImpl shared =
      ExampleEventChannelDataSourceImpl._private();

  setMock(OtaChannel? otaMockMethodChannel) {
    otaMethodChannel = otaMockMethodChannel;
  }

  ExampleEventChannelDataSourceImpl._private();

  factory ExampleEventChannelDataSourceImpl() {
    return shared;
  }

  @override
  void dispose() {
    otaMethodChannel?.dispose();
  }

  ///Use [StreamSubscription] to cancel the listener
  ///Use [isDuplicateAllowed] will check for redundancy in stream data. true is default
  ///[isDuplicateAllowed] will get the distinct value if there is any duplicate in data.
  @override
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic>) nativeResponse,
      bool? isDuplicateAllowed}) {
    return otaMethodChannel!.handleEventChannel(
        nativeResponse: nativeResponse,
        isDuplicateAllowed: isDuplicateAllowed ?? true);
  }
}
