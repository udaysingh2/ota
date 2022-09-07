import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/core_pack/telemetry/firebase/firebase_handler.dart';
import 'package:ota/debug_helper/debug_log_bloc.dart';
import 'package:ota/debug_helper/debug_utilities.dart';

const MethodChannel _platform =
    MethodChannel("robinhood.flutter.ota/methodChannelName");

abstract class OtaChannel {
  Future<Map<String, dynamic>> invokeNativeMethod(
      {required String methodName, required Map<String, dynamic> arguments});
  void dispose();
  StreamSubscription handleNativeMethod(
      String methodName, Function(Map<String, dynamic>) nativeResponse);
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic>) nativeResponse,
      bool isDuplicateAllowed});
}

class OtaChannelHelper {
  OtaChannelHelper._internal() {
    _platform.setMethodCallHandler(_nativeCallHandler);
  }
  static OtaChannelHelper shared = OtaChannelHelper._internal();
  factory OtaChannelHelper() {
    return shared;
  }
  Future<dynamic> _nativeCallHandler(MethodCall methodCall) async {
    _streamController.sink.add(methodCall);
  }

  final StreamController _streamController =
      StreamController<MethodCall>.broadcast();

  dispose() {
    _streamController.close();
  }
}

class OtaChannelImpl implements OtaChannel {
  EventChannel? _eventChannel;
  Stream? _stream;
  OtaChannelImpl();
  OtaChannelImpl.handleNativeEventChannel(String eventChannelName) {
    _eventChannel = EventChannel(eventChannelName);
    _stream = _eventChannel!.receiveBroadcastStream();
  }
  OtaChannelImpl.handleNativeMethod();

  @override
  Future<Map<String, dynamic>> invokeNativeMethod(
      {required String methodName,
      required Map<String, dynamic> arguments}) async {
    DebugLog debugLog =
        DebugLog(logTitle: "Method invoke", dateTime: DateTime.now());
    DebugLog debugLogBeforeInovke =
        DebugLog(logTitle: "Method Before invoke", dateTime: DateTime.now());
    try {
      if (DebugUtils.isBuildForDebug()) {
        debugLog.logStrings.add(DebugLogString(
            logTitle: "method Name", logsDescription: methodName));
        debugLogBeforeInovke.logStrings.add(DebugLogString(
            logTitle: "method Name", logsDescription: methodName));
        debugLogBeforeInovke.logStrings.add(DebugLogString(
            logTitle: "method arguments",
            logsDescription: jsonEncode(arguments)));
        debugLogBeforeInovke.setAsYellow();
        DebugUtils.debugLogBloc.addDebugLog(debugLogBeforeInovke);
      }
      printDebug("--------");
      printDebug(jsonEncode(arguments));
      printDebug("--------");
      String response =
          await _platform.invokeMethod(methodName, jsonEncode(arguments));
      if (DebugUtils.isBuildForDebug()) {
        debugLog.logStrings.add(DebugLogString(
            logTitle: "method response", logsDescription: response.toString()));
        debugLog.setAsBlue();
        DebugUtils.debugLogBloc.addDebugLog(debugLog);
      }
      return jsonDecode(response);
    } on Exception catch (e) {
      if (methodName != "logCrashlytics") {
        FirebaseCrashlytics.shared.pushResultChannelReportInvoke(exception: e);
      }
      if (DebugUtils.isBuildForDebug()) {
        debugLog.logStrings.add(DebugLogString(
            logTitle: "Exception", logsDescription: e.toString()));
        debugLog.setAsBlue();
        DebugUtils.debugLogBloc.addDebugLog(debugLog);
      }
      rethrow;
    }
  }

  @override
  StreamSubscription handleEventChannel(
      {required Function(Map<String, dynamic>) nativeResponse,
      bool isDuplicateAllowed = true}) {
    if (isDuplicateAllowed) {
      return _stream!.listen((event) {
        Map<String, dynamic> result = Map<String, dynamic>.from(event);
        nativeResponse(result);
      });
    } else {
      return _stream!.distinct().listen((event) {
        Map<String, dynamic> result = Map<String, dynamic>.from(event);
        nativeResponse(result);
      });
    }
  }

  StreamSubscription? nativeMethod;
  @override
  StreamSubscription handleNativeMethod(
      String methodName, Function(Map<String, dynamic>) nativeResponse) {
    DebugLog debugLog =
        DebugLog(logTitle: "Method handler", dateTime: DateTime.now());
    printDebug("--->MNAME :$methodName");
    if (DebugUtils.isBuildForDebug()) {
      debugLog.logStrings.add(
          DebugLogString(logTitle: "method Name", logsDescription: methodName));
    }
    nativeMethod =
        OtaChannelHelper.shared._streamController.stream.listen((event) {
      if (event.method == methodName) {
        String methodData = event.arguments;
        printDebug("--------");
        printDebug(methodData);
        printDebug("--------");
        try {
          Map<String, dynamic> result =
              Map<String, dynamic>.from(jsonDecode(methodData));
          nativeResponse(result);
          if (DebugUtils.isBuildForDebug()) {
            debugLog.logStrings.add(DebugLogString(
                logTitle: "method Data", logsDescription: methodData));
            debugLog.setAsBlue();
            DebugUtils.debugLogBloc.addDebugLog(debugLog);
          }
        } on Exception catch (e) {
          FirebaseCrashlytics.shared
              .pushResultChannelReportHandler(exception: e);
          if (DebugUtils.isBuildForDebug()) {
            debugLog.logStrings.add(DebugLogString(
                logTitle: "Exception", logsDescription: e.toString()));
            debugLog.setAsBlue();
            DebugUtils.debugLogBloc.addDebugLog(debugLog);
          }
        }
      }
    });
    return nativeMethod!;
  }

  @override
  void dispose() {
    nativeMethod?.cancel();
  }
}
