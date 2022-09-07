import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/log_crashlytics_invoke/models/log_crashlytics_argument_model_channel.dart';
import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString =
      fixture("channels/log_crashlytics_invoke/log_crashlytics_invoke.json");
  LogCrashlyticsArgumentModelChannel logCrashlyticsModel =
      LogCrashlyticsArgumentModelChannel.fromJson(jsonString);

  test("Log Crashlytics Models", () {
    //Convert into Model
    expect(logCrashlyticsModel.className == null, false);

    //convert into map
    Map<String, dynamic> map = logCrashlyticsModel.toMap();

    ///Check map conversion
    LogCrashlyticsArgumentModelChannel mapFromModel =
        LogCrashlyticsArgumentModelChannel.fromMap(map);

    expect(mapFromModel.className == null, false);

    ///Convert to String
    String stringData = logCrashlyticsModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = logCrashlyticsModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
