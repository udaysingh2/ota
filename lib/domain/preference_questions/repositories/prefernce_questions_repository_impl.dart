import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/preference_questions/data_sources/preference_questions_remote_data_source.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';

/// Interface for PreferenceQuestionsRepository repository.
abstract class PreferenceQuestionsRepository {
  /// Call API to get the Preferences data.
  ///
  /// [Either<Failure, PreferenceQuestionsModelDomainData>] to handle the Failure or result data.
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>>
      getPreferencesData();
}

/// PreferencesSubmitRepositoryImpl will contain the PreferencesSubmitRepository implementation.
class PreferenceQuestionsRepositoryImpl
    implements PreferenceQuestionsRepository {
  PreferenceQuestionsRemoteDataSource? preferenceQuestionsRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PreferenceQuestionsRepositoryImpl(
      {PreferenceQuestionsRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      preferenceQuestionsRemoteDataSource =
          PreferenceQuestionsRemoteDataSourceImpl();
    } else {
      preferenceQuestionsRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Preferences Data.
  ///
  /// [Either<Failure, PreferenceQuestionsModelDomainData>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PreferenceQuestionsModelDomainData?>>
      getPreferencesData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final preferencesResult =
            await preferenceQuestionsRemoteDataSource?.getPreferencesData();
        return Right(preferencesResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
