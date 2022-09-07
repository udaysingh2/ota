import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/ota_booking_mailer/data_sources/ota_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_argument_domain.dart';
import 'package:ota/domain/ota_booking_mailer/models/ota_booking_mailer_model_domain.dart';

///Interface for OtaBookingMailerRepository repository
abstract class OtaBookingMailerRepository {
  Future<Either<Failure, OtaBookingMailerModelDomain>> sendOtaBookingMailer(
      OtaBookingMailerArgumentDomain argument);
}

class OtaBookingMailerRepositoryImpl implements OtaBookingMailerRepository {
  OtaBookingMailerRemoteDataSource? otaBookingMailerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  OtaBookingMailerRepositoryImpl(
      {OtaBookingMailerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      otaBookingMailerRemoteDataSource = OtaBookingMailerRemoteDataSourceImpl();
    } else {
      otaBookingMailerRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, OtaBookingMailerModelDomain>> sendOtaBookingMailer(
      OtaBookingMailerArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final otaResult = await otaBookingMailerRemoteDataSource
            ?.sendOtaBookingMailer(argument);
        return Right(otaResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
