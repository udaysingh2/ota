import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/search/data_source/tour_save_search_history_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';

abstract class TourSaveSearchHistoryRepository {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, TourSaveSearchHistoryModelDomain>>
      saveTourSearchHistoryData(TourSaveSearchHistoryArgumentDomain argument);
}

/// TourSaveSearchHistoryRepositoryImpl will contain the TourSaveSearchHistoryRepository implementation.
class TourSaveSearchHistoryRepositoryImpl
    implements TourSaveSearchHistoryRepository {
  TourSaveSearchHistoryRemoteDataSource? tourSaveSearchHistoryRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourSaveSearchHistoryRepositoryImpl(
      {TourSaveSearchHistoryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourSaveSearchHistoryRemoteDataSource =
          TourSaveSearchHistoryRemoteDataSourceImpl();
    } else {
      tourSaveSearchHistoryRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Search Suggestions.
  ///
  /// [Either<Failure, TourSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSaveSearchHistoryModelDomain>>
      saveTourSearchHistoryData(
          TourSaveSearchHistoryArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult =
            await tourSaveSearchHistoryRemoteDataSource
                ?.saveTourSearchHistoryData(argument);
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
