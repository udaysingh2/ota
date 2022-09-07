import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_mock_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/channels/log_crashlytics_invoke/repositories/log_crashlytics_repository.dart';
import 'package:ota/channels/log_crashlytics_invoke/usecases/log_crashlytics_use_cases.dart';
import 'package:ota/common/network/failures.dart';

void main() {
  LogCrashlyticsUseCases? logCrashlyticsUseCases;
  LogCrashlyticsArgumentModelChannel argument =
      LogCrashlyticsArgumentModelChannel(
          className: "", message: "", stackTrace: "");
  setUpAll(() async {
    logCrashlyticsUseCases = LogCrashlyticsUseCasesImpl();
    logCrashlyticsUseCases = LogCrashlyticsUseCasesImpl(
        repository: LogCrashlyticsRepositoryImpl(
            remoteDataSource: LogCrashlyticsMockDataSourceImpl()));
  });
  test('LogCrashlytics UseCases ', () async {
    /// Consent user cases impl
    final logCrashlyticsResult = await logCrashlyticsUseCases!
        .invokeMethod(methodName: "", arguments: argument);

    /// Get model from mock data.
    final SuccessResponse model = logCrashlyticsResult.right;

    expect(model, logCrashlyticsResult.right);
  });
}
