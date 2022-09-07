import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';

class QueriesPreferences {
  static String submitPreferenceData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument) {
    return '''mutation {
                createPreference(
                  preferences: ${preferencesSubmitArgument.toMap()}
                ) {
                  status {
                    code
                    header
                    description
                  }
                }
              }
            ''';
  }
}
