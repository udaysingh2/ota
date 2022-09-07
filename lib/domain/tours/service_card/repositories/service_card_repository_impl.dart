import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

/// Interface for ServiceCardRepository repository.
abstract class ServiceCardRepository {
  Future<Either<Failure, ServiceCardModelDomain?>> getServiceCardData();
}

class ServiceCardRepositoryImpl implements ServiceCardRepository {
  ServiceCardRemoteDataSource? serviceCardRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  ServiceCardRepositoryImpl(
      {ServiceCardRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      serviceCardRemoteDataSource = ServiceCardRemoteDataSourceImpl();
    } else {
      serviceCardRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, ServiceCardModelDomain?>> getServiceCardData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final serviceResult =
            await serviceCardRemoteDataSource?.getServiceCardData();
        return Right(serviceResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
