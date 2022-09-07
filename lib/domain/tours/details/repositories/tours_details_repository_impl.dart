import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/tours/details/data_sources/tours_details_remote_data_source.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';

/// Interface for ToursDetailsRepository repository.
abstract class ToursDetailsRepository {
  Future<Either<Failure, TourDetail>> getTourDetails(
      TourDetailArgumentDomain argument);

  Future<Either<Failure, TourDetail>> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument);
}

class ToursDetailsRepositoryImpl implements ToursDetailsRepository {
  TourDetailsRemoteDataSource? remoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  ToursDetailsRepositoryImpl(
      {TourDetailsRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      this.remoteDataSource = TourDetailsRemoteDataSourceImpl();
    } else {
      this.remoteDataSource = remoteDataSource;
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
  Future<Either<Failure, TourDetail>> getTourDetails(
      TourDetailArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult = await remoteDataSource?.getTourDetails(argument);
        return Right(tourResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, TourDetail>> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final tourResult =
            await remoteDataSource?.getTourPackageDetails(argument);
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
