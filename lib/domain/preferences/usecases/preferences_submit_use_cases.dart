import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';
import 'package:ota/domain/preferences/repositories/preferences_submit_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class PreferencesSubmitUseCases {
  /// Call API to submit the preferences Screen details.
  ///
  /// [preferencesSubmitArgument] to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, PreferencesSubmitModelDomain>?> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument);
}

/// PreferencesSubmitUseCasesImpl will contain the PreferencesSubmitUseCases implementation.
class PreferencesSubmitUseCasesImpl implements PreferencesSubmitUseCases {
  PreferencesSubmitRepository? preferencesSubmitRepository;

  /// Dependence injection via constructor
  PreferencesSubmitUseCasesImpl({PreferencesSubmitRepository? repository}) {
    if (repository == null) {
      preferencesSubmitRepository = PreferencesSubmitRepositoryImpl();
    } else {
      preferencesSubmitRepository = repository;
    }
  }

  /// Call API to submit the preference Screen Details details.
  ///
  /// [preferencesSubmitArgument] to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PreferencesSubmitModelDomain>?> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument) async {
    return await preferencesSubmitRepository
        ?.submitPreferencesData(preferencesSubmitArgument);
  }
}
