import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';

/// Interface for CarSupplierRepository repository.
abstract class CarSupplierRepository {
  /// Call API to get the Gallery Screen details.
  ///
  /// [Either<Failure, CarSupplierModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, CarSupplierModelDomainData>> getCarSupplierData(
      CarSupplierArgumentModel argument);
}

/// CarSupplierRepositoryImpl will contain the CarSupplierRepository implementation.
class CarSupplierRepositoryImpl implements CarSupplierRepository {
  CarSupplierRemoteDataSource? carSupplierRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarSupplierRepositoryImpl(
      {CarSupplierRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carSupplierRemoteDataSource = CarSupplierRemoteDataSourceImpl();
      // carSupplierRemoteDataSource = CarSupplierMockDataSourceImpl();
    } else {
      carSupplierRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Car Supplier Screen details.
  ///
  /// [Either<Failure, CarSupplierModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSupplierModelDomainData>> getCarSupplierData(
      CarSupplierArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carSupplierResult =
            await carSupplierRemoteDataSource?.getCarSupplierData(argument);
        return Right(carSupplierResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
