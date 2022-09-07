import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_mock_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/repositories/prefernce_questions_repository_impl.dart';
import 'package:ota/domain/preference_questions/usecases/preference_questions_use_cases.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';

void main() {
  PreferenceQuestionsUseCases? preferenceQuestionsUseCases;
  setUpAll(() async {
    preferenceQuestionsUseCases = PreferenceQuestionsUseCasesImpl(
        repository: PreferenceQuestionsRepositoryImpl(
            internetInfo: InternetSuccessMock(),
            remoteDataSource: PreferenceQuestionsMockDataSourceImpl()));
  });
  test('Preference Questions UseCases ', () async {
    /// Consent user cases impl
    final preferenceQuestionsResult =
        await preferenceQuestionsUseCases!.getPreferenceData();

    /// Get model from mock data.
    final PreferenceQuestionsModelDomainData? model =
        preferenceQuestionsResult!.right;

    expect(model!.getPreferences != null, true);
  });
}
