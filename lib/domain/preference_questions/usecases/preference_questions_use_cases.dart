import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/repositories/prefernce_questions_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class PreferenceQuestionsUseCases {
  /// Call API to submit the preferences Screen details.
  ///
  /// [preferencesSubmitArgument] to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
      getPreferenceData();
}

/// PreferencesSubmitUseCasesImpl will contain the PreferencesSubmitUseCases implementation.
class PreferenceQuestionsUseCasesImpl implements PreferenceQuestionsUseCases {
  PreferenceQuestionsRepository? preferenceQuestionsRepository;

  /// Dependence injection via constructor
  PreferenceQuestionsUseCasesImpl({PreferenceQuestionsRepository? repository}) {
    if (repository == null) {
      preferenceQuestionsRepository = PreferenceQuestionsRepositoryImpl();
    } else {
      preferenceQuestionsRepository = repository;
    }
  }

  /// Call API to get the preference data.
  ///
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>?>
      getPreferenceData() async {
    return await preferenceQuestionsRepository?.getPreferencesData();
  }
}
