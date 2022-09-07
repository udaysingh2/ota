import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/common/network/failures.dart';

class LogCrashlyticsMockDataSourceImpl implements LogCrashlyticsDataSource {
  LogCrashlyticsMockDataSourceImpl();

  @override
  Future<SuccessResponse> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments}) async {
    return SuccessResponse.success;
  }

  @override
  void dispose() {}
}
