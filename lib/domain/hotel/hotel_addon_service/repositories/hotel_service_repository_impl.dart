import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';

/// Interface for HotelServiceRepository repository.
abstract class HotelServiceRepository {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelServiceResultModel>> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument);
}

/// HotelServiceRepositoryImpl will contain the HotelServiceRepository implementation.
class HotelServiceRepositoryImpl implements HotelServiceRepository {
  HotelServiceRemoteDataSource? hotelServiceRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelServiceRepositoryImpl(
      {HotelServiceRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelServiceRemoteDataSource =
          HotelServiceRemoteDataSourceImpl(); //HotelServicelMockDataSourceImpl();
    } else {
      hotelServiceRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, HotelServiceResultModel>> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final addonServiceResult = await hotelServiceRemoteDataSource
            ?.getHotelAddonServiceData(serviceDataArgument);
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
