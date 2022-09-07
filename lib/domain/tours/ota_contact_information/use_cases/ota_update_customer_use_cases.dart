import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import 'package:ota/domain/tours/ota_contact_information/repositories/ota_update_customer_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class OtaUpdateCustomerUseCases {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, OtaUpdateCustomerDetailsData>?> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData);
}

/// HotelServiceUseCasesImpl will contain the HotelServiceUseCases implementation.
class OtaUpdateCustomerUseCasesImpl implements OtaUpdateCustomerUseCases {
  OtaUpdateCustomerRepository? updateCustomerRepository;

  /// Dependence injection via constructor
  OtaUpdateCustomerUseCasesImpl({OtaUpdateCustomerRepository? repository}) {
    if (repository == null) {
      updateCustomerRepository = OtaUpdateCustomerRepositoryImpl();
    } else {
      updateCustomerRepository = repository;
    }
  }

  /// Call API to get the Hotel addon services Screen Details details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, OtaUpdateCustomerDetailsData>?> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData) async {
    return await updateCustomerRepository
        ?.updateCustomerDetails(contactInformationArgumentData);
  }
}
