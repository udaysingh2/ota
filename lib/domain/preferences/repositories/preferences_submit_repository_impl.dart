import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/preferences/data_sources/preferences_remote_data_sources.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';

/// Interface for PreferencesSubmitRepository repository.
abstract class PreferencesSubmitRepository {
  /// Call API to submit the Preferences Screen details.
  ///
  /// [preferencesSubmitArgument] to submit the preferences data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, PreferencesSubmitModelDomain>> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument);
}

/// PreferencesSubmitRepositoryImpl will contain the PreferencesSubmitRepository implementation.
class PreferencesSubmitRepositoryImpl implements PreferencesSubmitRepository {
  PreferencesSubmitRemoteDataSource? preferencesSubmitRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PreferencesSubmitRepositoryImpl(
      {PreferencesSubmitRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      preferencesSubmitRemoteDataSource =
          PreferencesSubmitRemoteDataSourceImpl();
    } else {
      preferencesSubmitRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to submit the Preferences Screen details.
  ///
  /// [preferencesSubmitArgument] to submit the Preferences Data of users.
  /// [Either<Failure, PreferencesSubmitModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, PreferencesSubmitModelDomain>> submitPreferencesData(
      PreferencesSubmitArgumentDomain preferencesSubmitArgument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final preferencesSubmitResult = await preferencesSubmitRemoteDataSource
            ?.submitPreferencesData(preferencesSubmitArgument);
        return Right(preferencesSubmitResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
