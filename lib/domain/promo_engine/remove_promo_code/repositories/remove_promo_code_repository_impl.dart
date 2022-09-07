import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';

abstract class RemovePromoCodeRepository {
  Future<Either<Failure, RemovePromoCodeModelDomain>?> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain);
}

class RemovePromoCodeRepositoryImpl implements RemovePromoCodeRepository {
  RemovePromoCodeRemoteDataSource? removePromoCodeRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  RemovePromoCodeRepositoryImpl(
      {RemovePromoCodeRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      removePromoCodeRemoteDataSource = RemovePromoCodeRemoteDataSourceImpl();
    } else {
      removePromoCodeRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, RemovePromoCodeModelDomain>?> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await removePromoCodeRemoteDataSource
            ?.removePromoCodeData(argumentDomain);
        return Right(result!);
      } on ServerException catch (err) {
        return Left(ServerFailure(exception: err.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
