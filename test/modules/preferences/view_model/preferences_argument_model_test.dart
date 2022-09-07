import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view_model/preferences_view_model.dart';
import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';

void main() {
  group('For class PreferencesArgumentModel group test', () {
    test('For class PreferencesArgumentModel test', () {
      final actual = _model();

      expect(actual.options?.isNotEmpty, true);
      expect(actual.multiChoice, true);
    });

    test('For class PreferencesArgumentModel If List Empty test', () {
      final actual = PreferencesArgumentModel.fromViewModel(
        PreferencesViewModel(
          options: [],
        ),
      );

      expect(actual.options?.isEmpty, true);
    });

    test('For class PreferencesArgumentModel test', () {
      final actual =
          PreferencesArgumentModel.fromViewModel(_preferencesViewModel());

      expect(actual.multiChoice, true);
      expect(actual.options?.isNotEmpty, true);
    });
  });
}

PreferencesArgumentModel _model() => PreferencesArgumentModel(
      questionId: 'questionId',
      description1: 'description1',
      description2: 'description2',
      backgroundImageUrl: 'backgroundImageUrl',
      multiChoice: true,
      options: [
        OptionArgumentModel(
          imageUrl: 'imageUrl',
          optionCode: 'optionCode',
          optionDesc: 'optionDesc',
        ),
      ],
    );

PreferencesViewModel _preferencesViewModel() => PreferencesViewModel(
      questionId: 'questionId',
      description1: 'description1',
      description2: 'description2',
      backgroundImageUrl: 'backgroundImageUrl',
      multiChoice: true,
      options: [
        OptionViewModel(
          imageUrl: 'imageUrl',
          optionCode: 'optionCode',
          optionDesc: 'optionDesc',
        ),
      ],
    );
