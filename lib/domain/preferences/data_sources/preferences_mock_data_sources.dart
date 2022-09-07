import 'package:ota/domain/preferences/data_sources/preferences_remote_data_sources.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';

class PreferencesMockDataSourceImpl
    implements PreferencesSubmitRemoteDataSource {
  PreferencesMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<PreferencesSubmitModelDomain> submitPreferencesData(
      PreferencesSubmitArgumentDomain serviceDataArgument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return PreferencesSubmitModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
    "createPreference": {
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
  }''';
