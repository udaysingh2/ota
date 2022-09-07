import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/details/models/tour_detail_argument_domain.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/models/tour_package_details_argument_domain.dart';
import 'package:ota/domain/tours/details/repositories/tours_details_repository_impl.dart';

/// Interface for ToursAttraction use cases.
abstract class TourDetailsUseCases {
  Future<Either<Failure, TourDetail>?> getToursDetails(
      TourDetailArgumentDomain argument);

  Future<Either<Failure, TourDetail>?> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument);
}

class TourDetailsUseCasesImpl implements TourDetailsUseCases {
  ToursDetailsRepository? tourDetailsRepository;

  /// Dependence injection via constructor
  TourDetailsUseCasesImpl({ToursDetailsRepository? repository}) {
    if (repository == null) {
      tourDetailsRepository = ToursDetailsRepositoryImpl();
    } else {
      tourDetailsRepository = repository;
    }
  }

  @override
  Future<Either<Failure, TourDetail>?> getToursDetails(
      TourDetailArgumentDomain argument) async {
    return await tourDetailsRepository?.getTourDetails(argument);
  }

  @override
  Future<Either<Failure, TourDetail>?> getTourPackageDetails(
      TourPackageDetailsArgumentDomain argument) async {
    return await tourDetailsRepository?.getTourPackageDetails(argument);
  }
}
