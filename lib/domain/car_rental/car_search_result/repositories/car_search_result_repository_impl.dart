import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_result/data_sources/car_search_result_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';

import '../../../../modules/car_rental/car_landing/view_model/car_landing_view_model.dart';

abstract class CarSearchResultRepository {
  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  Future<Either<Failure, CarSearchResultDomainModel>> getCarSearchResultData(
      CarSearchResultDomainArgumentModel argument,
      int pageNumber,
      int pageSize,
      LocationModel? pickupLocation,
      LocationModel? dropLocation,
      String dataSearchType,
      bool isSearchSave);
}

/// CarSearchResultRepositoryImpl will contain the CarSearchResultRepository implementation.
class CarSearchResultRepositoryImpl implements CarSearchResultRepository {
  CarSearchResultRemoteDataSource? carSearchResultDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarSearchResultRepositoryImpl(
      {CarSearchResultRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carSearchResultDataSource = CarSearchResultRemoteDataSourceImpl();
      //  carSearchResultDataSource = CarSearchResultMockDataSourceImpl();
    } else {
      carSearchResultDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Car Search result Data.
  ///
  /// [Either<Failure, CarSearchResultDomainModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSearchResultDomainModel>> getCarSearchResultData(
      CarSearchResultDomainArgumentModel argument,
      int pageNumber,
      int pageSize,
      LocationModel? pickupLocation,
      LocationModel? dropLocation,
      String dataSearchType,
      bool isSearchSave) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await carSearchResultDataSource?.getCarSearchResultData(
            argument,
            pageNumber,
            pageSize,
            pickupLocation,
            dropLocation,
            dataSearchType,
            isSearchSave);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
