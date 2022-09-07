import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/insurance/data_source/insurance_data_source.dart';
import 'package:ota/domain/insurance/models/insurance_argument_domain.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

abstract class InsuranceRepository {
  Future<Either<Failure, InsuranceModelDomain>> getInsuranceData(
      InsuranceArgumentDomain argumentModel);
}

class InsuranceRepositoryImpl implements InsuranceRepository {
  InsuranceRemoteDataSource? insuranceRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  InsuranceRepositoryImpl(
      {InsuranceRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      insuranceRemoteDataSource = InsuranceRemoteDataSourceImpl();
    } else {
      insuranceRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, InsuranceModelDomain>> getInsuranceData(
      InsuranceArgumentDomain argumentModel) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final insuranceResult =
            await insuranceRemoteDataSource?.getInsuranceData(argumentModel);
        return Right(insuranceResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}
