import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/tour_booking_detail/data_sources/tour_booking_details_remote_data_source.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_argument_model.dart';
import 'package:ota/domain/tours/tour_booking_detail/models/tours_booking_details_model_domain.dart';

///Interface for TourBookingDetailRepository repository
abstract class TourBookingDetailRepository {
  Future<Either<Failure, TourBookingDetailModelDomain>> getTourBookingDetail(
      TourBookingDetailArgumentDomain argument);
}

class TourBookingDetailRepositoryImpl implements TourBookingDetailRepository {
  TourBookingDetailRemoteDataSource? tourBookingDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  TourBookingDetailRepositoryImpl(
      {TourBookingDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      tourBookingDetailRemoteDataSource =
          TourBookingDetailRemoteDataSourceImpl();
    } else {
      tourBookingDetailRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourBookingDetailModelDomain>> getTourBookingDetail(
      TourBookingDetailArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult = await tourBookingDetailRemoteDataSource
            ?.getTourBookingDetail(argument);
        return Right(tourResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
