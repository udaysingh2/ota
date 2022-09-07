import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/search/data_sources/ota_search_remote_data_source.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';

/// Interface for OtaSearchRepository repository.
abstract class OtaSearchRepository {
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  Future<Either<Failure, OtaSearchData>> getOtaSearchData(
      OtaSearchDataArgument argument);
}

/// OtaSearchRepositoryImpl will contain the OtaSearchRepository implementation.
class OtaSearchRepositoryImpl implements OtaSearchRepository {
  OtaSearchRemoteDataSource? _otaSearchRemoteDataSource;
  InternetConnectionInfo? _internetConnectionInfo;

  /// Dependence injection via constructor
  OtaSearchRepositoryImpl(
      {OtaSearchRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (otaSearchRemoteDataSource != null) {
      _otaSearchRemoteDataSource = otaSearchRemoteDataSource;
    } else if (remoteDataSource == null) {
      _otaSearchRemoteDataSource = OtaSearchRemoteDataSourceImpl();
    } else {
      _otaSearchRemoteDataSource = remoteDataSource;
    }
    if (internetConnectionInfo != null) {
      _internetConnectionInfo = internetConnectionInfo;
    } else if (internetInfo == null) {
      _internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      _internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the ota search details.
  ///
  /// [Either<Failure, OtaSearchData>] to handle the Failure or result data.
  @override
  Future<Either<Failure, OtaSearchData>> getOtaSearchData(
      OtaSearchDataArgument argument) async {
    if (await (_internetConnectionInfo?.isConnected) ?? false) {
      try {
        final otaSearchResult =
            await _otaSearchRemoteDataSource?.getOtaSearchData(argument);
        return Right(otaSearchResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

OtaSearchRemoteDataSource? otaSearchRemoteDataSource;
InternetConnectionInfo? internetConnectionInfo;
void mockOtaSearchData(
    {OtaSearchRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  otaSearchRemoteDataSource = remoteDataSource;
  internetConnectionInfo = internetInfo;
}
