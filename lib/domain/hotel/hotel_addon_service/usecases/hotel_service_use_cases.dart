import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class HotelServiceUseCases {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelServiceResultModel>?> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument);
}

/// HotelServiceUseCasesImpl will contain the HotelServiceUseCases implementation.
class HotelServiceUseCasesImpl implements HotelServiceUseCases {
  HotelServiceRepository? hotelServiceRepository;

  /// Dependence injection via constructor
  HotelServiceUseCasesImpl({HotelServiceRepository? repository}) {
    if (repository == null) {
      hotelServiceRepository = HotelServiceRepositoryImpl();
    } else {
      hotelServiceRepository = repository;
    }
  }

  /// Call API to get the Hotel addon services Screen Details details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, HotelServiceResultModel>?> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    return await hotelServiceRepository
        ?.getHotelAddonServiceData(serviceDataArgument);
  }
}
