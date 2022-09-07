import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/public_promo/data_source/public_promotiom_remote_data_source.dart';
import 'package:ota/domain/promo_engine/public_promo/models/promo_engine_argument_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';

/// Interface for ServiceCardRepository repository.
abstract class PublicPromotionRepository {
  Future<Either<Failure, PublicPromotionModelDomain?>> getPublicPromotionData(
      PublicPromotionArgumentDomain argument);
}

class PublicPromotionRepositoryImpl implements PublicPromotionRepository {
  PublicPromotionRemoteDataSource? availablePublicPromotionRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  PublicPromotionRepositoryImpl(
      {PublicPromotionRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      availablePublicPromotionRemoteDataSource =
          PublicPromotionRemoteDataSourceImpl();
    } else {
      availablePublicPromotionRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, PublicPromotionModelDomain?>> getPublicPromotionData(
      PublicPromotionArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final availablePublicPromotionResult =
            await availablePublicPromotionRemoteDataSource
                ?.getPublicPromotionData(argument);
        return Right(availablePublicPromotionResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
