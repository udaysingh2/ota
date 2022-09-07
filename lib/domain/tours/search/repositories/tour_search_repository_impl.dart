import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/search/data_source/tour_search_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_search_history_model_domain.dart';

abstract class TourSearchRepository {
  /// Call API to get the Search History.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  Future<Either<Failure, TourSearchHistoryModelDomain>>
      getTourSearchHistoryData();
}

/// TourSearchHistoryRepositoryImpl will contain the TourSearchHistoryRepository implementation.
class TourSearchRepositoryImpl implements TourSearchRepository {
  TourSearchRemoteDataSource? searchRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourSearchRepositoryImpl(
      {TourSearchRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      searchRemoteDataSource = TourSearchRemoteDataSourceImpl();
      // searchRemoteDataSource = TourSearchMockDataSourceImpl();
    } else {
      searchRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Search History.
  ///
  /// [Either<Failure, TourAndTicketRecentSearchesModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSearchHistoryModelDomain>>
      getTourSearchHistoryData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult =
            await searchRemoteDataSource?.getTourSearchHistoryData();
        return Right(searchSuggestionResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
