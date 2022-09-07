import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/debug_helper/debug_utilities.dart';

//This code will be the part of debugger // No performance test needed or
//Extensive review needed
class DebugLogBloc extends Bloc<DebugLogs> {
  @override
  DebugLogs initDefaultValue() {
    return DebugLogs();
  }

  void addDebugLog(DebugLog debugLog) {
    if (!DebugUtils.isBuildForDebug()) return;
    state.logs.add(debugLog);
    emit(state);
  }

  void clearAll() {
    if (!DebugUtils.isBuildForDebug()) return;
    state.logs.clear();
    emit(state);
  }
}

class SingleDebugLogBloc extends Bloc<List<DebugLogString>> {
  @override
  List<DebugLogString> initDefaultValue() {
    return [];
  }

  void setData(List<DebugLogString> data) {
    emit(data);
  }

  void toggleBasedOnIndex(int index) {
    state.elementAt(index).isExpanded = !state.elementAt(index).isExpanded;
    emit(state);
  }
}

class DebugLogs {
  List<DebugLog> logs = [];
}

class DebugLog {
  DateTime? dateTime;
  DebugLogBannerType debugLogBannerType;
  String logTitle;
  List<DebugLogString> logStrings = [];
  DebugLog({
    required this.logTitle,
    this.debugLogBannerType = DebugLogBannerType.happy,
    this.dateTime,
  });

  void setAsSad() {
    debugLogBannerType = DebugLogBannerType.danger;
  }

  void setAsBlue() {
    debugLogBannerType = DebugLogBannerType.blue;
  }

  void setAsYellow() {
    debugLogBannerType = DebugLogBannerType.yellow;
  }
}

class DebugLogString {
  String logTitle;
  String logsDescription;
  bool isExpanded;
  DebugLogString(
      {required this.logTitle,
      required this.logsDescription,
      this.isExpanded = false});
}

enum DebugLogBannerType {
  danger,
  happy,
  blue,
  yellow,
}
