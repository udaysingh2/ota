import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/loading/data_sources/tour_loading_remote_data_source.dart';
import 'package:ota/domain/tours/loading/models/tour_loading_model.dart';

/// Interface for HotelServiceRepository repository.
abstract class TourLoadingRepository {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, TourLoadingData>> getLoadingData();
}

/// HotelServiceRepositoryImpl will contain the HotelServiceRepository implementation.
class TourLoadingRepositoryImpl implements TourLoadingRepository {
  TourLoadingRemoteDataSource? tourLoadingRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourLoadingRepositoryImpl(
      {TourLoadingRemoteDataSource? remoteDataSource,
        InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourLoadingRemoteDataSource =
          TourLoadingRemoteDataSourceImpl(); //HotelServiceRemoteDataSourceImpl();
    } else {
      tourLoadingRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, TourLoadingData>> getLoadingData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final addonServiceResult = await tourLoadingRemoteDataSource
            ?.getTourLoadingData();
        return Right(addonServiceResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
