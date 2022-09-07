import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/data_sources/hotel_booking_mailer_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking_mailer/models/hotel_booking_mailer_model_domain.dart';

///Interface for HotelBookingMailerRepository repository
abstract class HotelBookingMailerRepository {
  Future<Either<Failure, HotelBookingMailerModelDomain>> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument);
}

class HotelBookingMailerRepositoryImpl implements HotelBookingMailerRepository {
  HotelBookingMailerRemoteDataSource? hotelBookingMailerRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelBookingMailerRepositoryImpl(
      {HotelBookingMailerRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelBookingMailerRemoteDataSource =
          HotelBookingMailerRemoteDataSourceImpl();
    } else {
      hotelBookingMailerRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, HotelBookingMailerModelDomain>> sendHotelBookingMailer(
      HotelBookingMailerArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult = await hotelBookingMailerRemoteDataSource
            ?.sendHotelBookingMailer(argument);
        return Right(hotelResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
