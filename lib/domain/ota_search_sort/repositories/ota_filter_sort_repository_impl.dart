import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/ota_search_sort/data_source/otasearchsort_remote_data_source.dart';
import 'package:ota/domain/ota_search_sort/models/ota_filter_sort.dart';

abstract class OtaSearchSortRepository {
  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  Future<Either<Failure, OtaFilterSort>> getOtaSearchSortData();
}

/// OtaSearchSortRepositoryImpl will contain the OtaSearchSortRepository implementation.
class OtaSearchSortRepositoryImpl implements OtaSearchSortRepository {
  OtaSearchSortRemoteDataSource? otaSearchSortRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  OtaSearchSortRepositoryImpl(
      {OtaSearchSortRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      otaSearchSortRemoteDataSource = OtaSearchSortRemoteDataSourceImpl();
    } else {
      otaSearchSortRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the OtaSearchSort Screen details.
  ///
  /// [Either<Failure, OtaFilterSort>] to handle the Failure or result data.
  @override
  Future<Either<Failure, OtaFilterSort>> getOtaSearchSortData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final otaSearchSortResult =
            await otaSearchSortRemoteDataSource?.getOtaSearchSortData();
        return Right(otaSearchSortResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
