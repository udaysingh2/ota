import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preferences/data_sources/preferences_mock_data_sources.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';

void main() {
  PreferencesSubmitModelDomain model = PreferencesSubmitModelDomain.fromJson(
      PreferencesMockDataSourceImpl.getMockData());

  group('For PreferencesSubmitModelDomain Test', () {
    test('To check createPreference Test', () {
      final actual = model;

      expect(actual.createPreference != null, true);
    });

    test('For ToJson and toMap Test', () {
      ///convert into toMap
      Map<String, dynamic> map = model.toMap();

      PreferencesSubmitModelDomain modelDomain =
          PreferencesSubmitModelDomain.fromMap(map);

      expect(modelDomain.createPreference != null, true);

      ///For ToJson
      final toJson = PreferencesSubmitModelDomain().toJson();

      expect(toJson.isNotEmpty, true);
    });
  });

  group('For CreatePreference Test', () {
    test('If CreatePreference fromJson then', () {
      final fromJson = CreatePreference.fromJson(
          PreferencesMockDataSourceImpl.getMockData());

      expect(fromJson, isA<CreatePreference>());
    });

    test('For toMap and toJson Test', () {
      ///convert into map
      Map<String, dynamic>? map = model.createPreference?.toMap();
      CreatePreference preference = CreatePreference.fromMap(map!);
      expect(preference, isA<CreatePreference>());

      ///For ToJson
      final toJson = CreatePreference().toJson();
      expect(toJson.isNotEmpty, true);
    });
  });

  group('For Status Test', () {
    test('If Status fromJson then', () {
      final fromJson =
          Status.fromJson(PreferencesMockDataSourceImpl.getMockData());

      expect(fromJson.code, null);
    });

    test('For toMap and toJson Test', () {
      ///convert into map
      Map<String, dynamic>? map = model.createPreference?.status?.toMap();
      Status status = Status.fromMap(map!);
      expect(status.code?.isNotEmpty, true);

      ///For TOJson
      final toJson = Status().toJson();
      expect(toJson.isNotEmpty, true);
    });
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
