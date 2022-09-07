import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/promo_engine/promo_search/data_sources/promo_code_search_remote_data_source.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';

abstract class PromoCodeSearchRepository {
  Future<Either<Failure, PromoCodeSearchModelDomain>> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain);
}

class PromoCodeSearchRepositoryImpl implements PromoCodeSearchRepository {
  PromoCodeSearchRemoteDataSource? promoCodeSearchRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  PromoCodeSearchRepositoryImpl(
      {PromoCodeSearchRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      promoCodeSearchRemoteDataSource = PromoCodeSearchRemoteDataSourceImpl();
    } else {
      promoCodeSearchRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, PromoCodeSearchModelDomain>> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final promoCodeSearchResult = await promoCodeSearchRemoteDataSource
            ?.searchPromoCode(promoCodeArgumentDomain);
        return Right(promoCodeSearchResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
