import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/data_sources/car_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_argument_domain.dart';
import 'package:ota/domain/car_rental/car_booking_mailer/models/car_booking_mailer_model_domain.dart';

///Interface for CarBookingMailerRepository repository
abstract class CarBookingMailerRepository {
  Future<Either<Failure, CarBookingMailerModelDomain>> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument);
}

class CarBookingMailerRepositoryImpl implements CarBookingMailerRepository {
  CarBookingMailerRemoteDataSource? carBookingMailerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarBookingMailerRepositoryImpl(
      {CarBookingMailerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carBookingMailerRemoteDataSource = CarBookingMailerRemoteDataSourceImpl();
    } else {
      carBookingMailerRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, CarBookingMailerModelDomain>> sendCarBookingMailer(
      CarBookingMailerArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carResult = await carBookingMailerRemoteDataSource
            ?.sendCarBookingMailer(argument);
        return Right(carResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
