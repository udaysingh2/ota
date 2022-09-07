import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/data_sources/log_crashlytics_mock_data_source.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import 'package:ota/channels/log_crashlytics_invoke/repositories/log_crashlytics_repository.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/common/network/failures.dart';

class HotelServiceDataSourceFailureMock implements LogCrashlyticsDataSource {
  Future<LogCrashlyticsArgumentModelChannel> getLogCrashlytics(
      LogCrashlyticsArgumentModelChannel argument) {
    throw exp.ServerException(null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<SuccessResponse> invokeMethod(
      {required String methodName,
      required LogCrashlyticsArgumentModelChannel arguments}) {
    // TODO: implement invokeMethod
    throw UnimplementedError();
  }
}

void main() {
  LogCrashlyticsRegisterRepository? logCrashlyticsRepositoryMock;
  LogCrashlyticsRegisterRepository? logCrashlyticsRepositoryServerException;

  setUpAll(() async {
    logCrashlyticsRepositoryMock = LogCrashlyticsRepositoryImpl();

    logCrashlyticsRepositoryMock = LogCrashlyticsRepositoryImpl(
      remoteDataSource: LogCrashlyticsMockDataSourceImpl(),
    );

    logCrashlyticsRepositoryServerException = LogCrashlyticsRepositoryImpl(
      remoteDataSource: LogCrashlyticsMockDataSourceImpl(),
    );
  });

  test("Log Crashlytics Repository" 'With Success response', () async {
    LogCrashlyticsArgumentModelChannel argumentlog =
        LogCrashlyticsArgumentModelChannel(
            className: "", message: "", stackTrace: "");

    final result = await logCrashlyticsRepositoryMock!
        .invokeMethod(methodName: "", arguments: argumentlog);
    final SuccessResponse serviceData = result.right;

    expect(serviceData.name, "success");
  });

  test("Log Crashlytics Repository" 'With Server Exception response data',
      () async {
    LogCrashlyticsArgumentModelChannel argumentlog =
        LogCrashlyticsArgumentModelChannel(
            className: "", message: "", stackTrace: "");
    final result = await logCrashlyticsRepositoryServerException!
        .invokeMethod(methodName: "", arguments: argumentlog);
    expect(result.isLeft, false);
  });
}
