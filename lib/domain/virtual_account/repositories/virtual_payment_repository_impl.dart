import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/virtual_account/data_sources/virtual_payment_remote_data_source.dart';
import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';

abstract class VirtualPaymentRepository {
  Future<Either<Failure, VirtualPaymentModelDomain>> getVirtualWalletBalance();
}

class VirtualPaymentRepositoryImpl implements VirtualPaymentRepository {
  VirtualPaymentRemoteDataSource? virtualPaymentRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  VirtualPaymentRepositoryImpl(
      {VirtualPaymentRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      virtualPaymentRemoteDataSource = VirtualPaymentRemoteDataSourceImpl();
    } else {
      virtualPaymentRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, VirtualPaymentModelDomain>>
      getVirtualWalletBalance() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final walletPaymentResult =
            await virtualPaymentRemoteDataSource?.getVirtualWalletBalance();
        return Right(walletPaymentResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
