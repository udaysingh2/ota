import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/preference_questions/data_sources/preference_questions_mock_data_source.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/repositories/prefernce_questions_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class PreferenceQuestionsRemoteDataSourceFailureMock
    implements PreferenceQuestionsRemoteDataSource {
  Future<PreferenceQuestionsModelDomain> getPreferenceCards(
      PreferenceQuestionsModelDomain argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<PreferenceQuestionsModelDomainData> getPreferencesData() {
    throw UnimplementedError();
  }
}

void main() {
  PreferenceQuestionsRepository? preferenceQuestionsRepositoryMock;
  PreferenceQuestionsRepository? preferenceQuestionsRepositoryServerException;

  setUpAll(() async {
    preferenceQuestionsRepositoryMock = PreferenceQuestionsRepositoryImpl();

    preferenceQuestionsRepositoryMock = PreferenceQuestionsRepositoryImpl(
        remoteDataSource: PreferenceQuestionsMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    preferenceQuestionsRepositoryServerException =
        PreferenceQuestionsRepositoryImpl(
            remoteDataSource: PreferenceQuestionsMockDataSourceImpl(),
            internetInfo: InternetFailureMock());
  });

  test("Preference Questions Repository" 'With Success response', () async {
    final result =
        await preferenceQuestionsRepositoryMock!.getPreferencesData();
    final PreferenceQuestionsModelDomainData? serviceData = result.right;
    expect(serviceData!.getPreferences != null, true);
  });

  test("Preference Questions Repository" 'With Server Exception response data',
      () async {
    final result = await preferenceQuestionsRepositoryServerException!
        .getPreferencesData();
    expect(result.isLeft, true);
  });
}
