import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/usecases/preference_questions_use_cases.dart';

class PreferenceQuestionsUseCasesSuccessMock
    extends PreferenceQuestionsUseCasesImpl {
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
      getPreferenceData() async {
    return Right(
      PreferenceQuestionsModelDomainData(
        getPreferences: GetPreferences(
          data: GetPreferencesData(
            preferences: [
              Preference(),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceQuestionsUseCasesPreferencesNULLMock
    extends PreferenceQuestionsUseCasesImpl {
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
  getPreferenceData() async {
    return Right(
      PreferenceQuestionsModelDomainData(
        getPreferences: null,
      ),
    );
  }
}

class PreferenceQuestionsUseCasesAllPreferencesNULLMock
    extends PreferenceQuestionsUseCasesImpl {
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
  getPreferenceData() async {
    return Right(
      PreferenceQuestionsModelDomainData(
        getPreferences: GetPreferences(
          data: GetPreferencesData(
            preferences: null,
          ),
        ),
      ),
    );
  }
}

class PreferenceQuestionsUseCasesFailureMock
    extends PreferenceQuestionsUseCasesImpl {
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
      getPreferenceData() async {
    return Left(
      InternetFailure(),
    );
  }
}
