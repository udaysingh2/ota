import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preferences/data_sources/preferences_mock_data_sources.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';

void main() {
  PreferencesMockDataSourceImpl impl = PreferencesMockDataSourceImpl();

  test('For PreferencesMockDataSourceImpl ==> getMockData', () {
    final actual = PreferencesMockDataSourceImpl.getMockData();

    expect(actual.isNotEmpty, true);
  });

  test('For PreferencesMockDataSourceImpl ==> getMockData', () {
    final model = PreferencesSubmitModelDomain.fromJson(
        PreferencesMockDataSourceImpl.getMockData());

    expect(model.createPreference != null, true);
    expect(model.createPreference?.status != null, true);
    expect(model.createPreference?.status?.code, '1000');
  });

  test('For PreferencesMockDataSourceImpl ==> submitPreferencesData', () {
    final actual = impl.submitPreferencesData(args());

    expect(actual, isA<Future<PreferencesSubmitModelDomain>>());
  });
}

PreferencesSubmitArgumentDomain args() => PreferencesSubmitArgumentDomain(
      preferences: [
        PreferencesSubmitModel(
          questionId: 'questionId',
          description: 'description',
          answers: [
            PreferencesAnswerModel(
              optionCode: 'optionCode',
              optionDesc: 'optionDesc',
            ),
          ],
        ),
      ],
    );
