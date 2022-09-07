import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/apply_promo/data_sources/apply_promo_remote_data_source.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';

abstract class ApplyPromoRepository {
  Future<Either<Failure, ApplyPromoModelDomain>> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain);
}

class ApplyPromoRepositoryImpl implements ApplyPromoRepository {
  ApplyPromoRemoteDataSource? applyPromoRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  ApplyPromoRepositoryImpl(
      {ApplyPromoRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      applyPromoRemoteDataSource = ApplyPromoRemoteDataSourceImpl();
    } else {
      applyPromoRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, ApplyPromoModelDomain>> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final applyPromoResult = await applyPromoRemoteDataSource
            ?.applyPromoCode(applyPromoArgumentDomain);
        return Right(applyPromoResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
