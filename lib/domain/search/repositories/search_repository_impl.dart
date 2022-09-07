import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/search/data_sources/search_remote_data_source.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/domain/search/models/search_service_type.dart';
import 'package:ota/domain/search/models/search_suggestion_model.dart';
import 'package:ota/domain/search/models/suggestion_data_argument.dart';

abstract class SearchRepository {
  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [suggestionDataArgurmnt] to get the Search Suggestion Data for users.
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  Future<Either<Failure, SearchSuggestionModel>> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt);

  Future<Either<Failure, SearchRecommendationModel>>
      getSearchRecommendationData(SearchServiceType serviceType);

  Future<Either<Failure, HotelRecommendationModelDomain>>
      getHotelSearchRecommendationData(
          HotelRecommendationArgDomain recommendationArgument);
}

/// SearchRepositoryImpl will contain the SearchRepository implementation.
class SearchRepositoryImpl implements SearchRepository {
  SearchRemoteDataSource? searchRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  SearchRepositoryImpl(
      {SearchRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_searchRemoteDataSource != null) {
      searchRemoteDataSource = _searchRemoteDataSource;
    } else if (remoteDataSource == null) {
      searchRemoteDataSource = SearchRemoteDataSourceImpl();
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

  /// Call API to get the Search Suggestion Screen details.
  ///
  /// [suggestionDataArgurmnt] to get the Search Suggestion Data for users.
  /// [Either<Failure, SearchSuggestionModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, SearchSuggestionModel>> getSearchSuggestionData(
      SuggestionDataArgument suggestionDataArgurmnt) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult = await searchRemoteDataSource
            ?.getSearchSuggestionData(suggestionDataArgurmnt);
        return Right(searchSuggestionResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, SearchRecommendationModel>>
      getSearchRecommendationData(SearchServiceType serviceType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult = await searchRemoteDataSource
            ?.getSearchRecommendationData(serviceType);
        return Right(searchSuggestionResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, HotelRecommendationModelDomain>>
      getHotelSearchRecommendationData(
          HotelRecommendationArgDomain recommendationArgument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult = await searchRemoteDataSource
            ?.getHotelSearchRecommendationData(recommendationArgument);
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

SearchRemoteDataSource? _searchRemoteDataSource;
InternetConnectionInfo? internetConnectionInfo;

void mockSearchData(
    {SearchRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _searchRemoteDataSource = remoteDataSource;
  internetConnectionInfo = internetInfo;
}
