import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/car_rental/contact_information/repositories/update_customer_repository_impl.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';

/// Interface for Hotel addon services use cases.
abstract class UpdateCustomerUseCases {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, UpdateCustomerData>?> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData);
}

/// HotelServiceUseCasesImpl will contain the HotelServiceUseCases implementation.
class UpdateCustomerUseCasesImpl implements UpdateCustomerUseCases {
  UpdateCustomerRepository? updateCustomerRepository;

  /// Dependence injection via constructor
  UpdateCustomerUseCasesImpl({UpdateCustomerRepository? repository}) {
    if (repository == null) {
      updateCustomerRepository = UpdateCustomerRepositoryImpl();
    } else {
      updateCustomerRepository = repository;
    }
  }

  /// Call API to get the Hotel addon services Screen Details details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, UpdateCustomerData>?> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    return await updateCustomerRepository
        ?.updateCustomerData(contactInformationArgumentData);
  }
}
