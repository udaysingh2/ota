import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/search/data_source/tour_search_suggestions_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_search_suggestions_model_domain.dart';

abstract class TourSearchSuggestionsRepository {
  /// Call API to get the Search History.
  ///
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, TourSearchSuggestionsModelDomain>>
      getTourSearchSuggestionsData(
          TourSearchSuggestionsArgumentDomain argument);
}

/// TourSearchSuggestionsRepositoryImpl will contain the TourSearchSuggestionsRepository implementation.
class TourSearchSuggestionsRepositoryImpl
    implements TourSearchSuggestionsRepository {
  TourSearchSuggestionsRemoteDataSource? searchSuggestionsRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourSearchSuggestionsRepositoryImpl(
      {TourSearchSuggestionsRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      searchSuggestionsRemoteDataSource =
          TourSearchSuggestionsRemoteDataSourceImpl();
    } else {
      searchSuggestionsRemoteDataSource = remoteDataSource;
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
  /// [Either<Failure, TourSearchSuggestionsModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourSearchSuggestionsModelDomain>>
      getTourSearchSuggestionsData(
          TourSearchSuggestionsArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult = await searchSuggestionsRemoteDataSource
            ?.getTourSearchSuggestionsData(argument);
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
