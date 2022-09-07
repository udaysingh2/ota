import 'dart:convert';

import 'package:ota/core_components/ota_channel/ota_channel_config.dart';

import 'debug_helper_bloc.dart';
import 'debug_log_bloc.dart';

const bool _buildForDebug =
    String.fromEnvironment('BUILD_FOR_DEBUG', defaultValue: 'false') == 'y';
const bool _enablePerformanceTester = String.fromEnvironment(
        'ENABLE_PERFORMANCE_TESTER',
        defaultValue: 'false') ==
    'y';

/// This code will be the part of debugger and UI performance tester
/// No performance test needed or extensive review needed
class DebugUtils {
  static final TestBloc testBloc = TestBloc();
  static DebugLogBloc debugLogBloc = DebugLogBloc();
  static bool isBuildForDebug() {
    if (_buildForDebug) {
      return true;
    } else {
      if (OtaChannelConfig.isModule) {
        return false;
      }
      return true;
    }
  }

  static bool enablePerformanceTester() {
    return _enablePerformanceTester;
  }

  static String getMapToString(Map<String, dynamic>? data) {
    if (data == null) return "null";
    try {
      return jsonEncode(data);
    } catch (_) {
      return data.toString();
    }
  }
}
