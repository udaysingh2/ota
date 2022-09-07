import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/search_result/data_sources/tour_search_result_remote_data_source.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';

abstract class TourSearchResultRepository {
  Future<Either<Failure, TourSearchResultModelDomain>?> getTourSearchResultData(
      TourSearchResultArgumentDomain argument);
}

class TourSearchResultRepositoryImpl implements TourSearchResultRepository {
  TourSearchResultRemoteDataSource? tourSearchResultRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  TourSearchResultRepositoryImpl(
      {TourSearchResultRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourSearchResultRemoteDataSource =
          TourSearchResultRemoteDataSourceImpl();
    } else {
      tourSearchResultRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }
  @override
  Future<Either<Failure, TourSearchResultModelDomain>?> getTourSearchResultData(
      argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchResult = await tourSearchResultRemoteDataSource
            ?.getTourSearchResultData(argument);
        return Right(searchResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
