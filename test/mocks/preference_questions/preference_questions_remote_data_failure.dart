import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';

class PreferenceQuestionsRemoteDataSourceFailureMock
    implements PreferenceQuestionsRemoteDataSource {
  Future<PreferenceQuestionsModelDomain> getTourServiceCards(
      PreferenceQuestionsModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<PreferenceQuestionsModelDomainData> getPreferencesData() {
    throw UnimplementedError();
  }
}
