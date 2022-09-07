import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confi_api/models/config_constant.dart';
import 'package:ota/domain/confi_api/models/config_model.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test('config model Tests', () async {
    String json = fixture("config/config_result_model.json");
    ConfigResultModel result = ConfigResultModel.fromJson(json);
    ConfigModel configModel =
        ConfigModel.fromModel(result.getConfigDetails?.data ?? []);
    expect(configModel.splashScreenDuration, ConfigConst.splashScreenDuration);

    configModel = ConfigModel.defaultValue();
    expect(configModel.maxChildAge, ConfigConst.maxChildAge);
  });
}
