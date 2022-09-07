import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/repositories/prefernce_questions_repository_impl.dart';
import '../fixture_reader.dart';

class PreferenceQuestionsRepositoryImplSuccessMock
    implements PreferenceQuestionsRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  PreferenceQuestionsRemoteDataSource? preferenceQuestionRemoteDataSource;

  Future<Either<Failure, PreferenceQuestionsModelDomain>?> getTourServiceCards(
      PreferenceQuestionsModelDomain argument) async {
    String json =
        fixture("preference_questions/preference_questions_mock.json");

    ///Convert into Model
    PreferenceQuestionsModelDomain model =
        PreferenceQuestionsModelDomain.fromJson(json);
    return Right(model);
  }

  @override
  PreferenceQuestionsRemoteDataSource? preferenceQuestionsRemoteDataSource;

  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>>
      getPreferencesData() {
    throw UnimplementedError();
  }
}
