import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/search_filter/data_sources/tour_search_filter_remote_data_source.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';

abstract class TourSearchFilterRepository {
  Future<Either<Failure, TourSearchFilterModelDomain>?> getTourSearchFilterData(
      String serviceType);
}

class TourSearchFilterRepositoryImpl implements TourSearchFilterRepository {
  TourSearchFilterRemoteDataSource? tourSearchFilterRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  TourSearchFilterRepositoryImpl(
      {TourSearchFilterRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourSearchFilterRemoteDataSource =
          TourSearchFilterRemoteDataSourceImpl();
    } else {
      tourSearchFilterRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourSearchFilterModelDomain>?> getTourSearchFilterData(
      serviceType) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchFilter = await tourSearchFilterRemoteDataSource
            ?.getTourSearchFilterData(serviceType);
        return Right(searchFilter!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
