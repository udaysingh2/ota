import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import '../fixture_reader.dart';

class PreferenceQuestionsRemoteDataSourceImplSuccessMock
    implements PreferenceQuestionsRemoteDataSource {
  Future<PreferenceQuestionsModelDomain> getTourServiceCards(
      PreferenceQuestionsModelDomain argument) async {
    String json =
        fixture("preference_questions/preference_questions_mock.json");

    ///Convert into Model
    PreferenceQuestionsModelDomain model =
        PreferenceQuestionsModelDomain.fromJson(json);
    return model;
  }

  @override
  Future<PreferenceQuestionsModelDomainData> getPreferencesData() {
    throw UnimplementedError();
  }
}
