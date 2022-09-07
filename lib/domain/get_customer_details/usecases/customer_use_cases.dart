import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';

/// Interface for Hotel addon services use cases.
abstract class CustomerUseCases {
  /// Call API to get the Hotel addon services Screen details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  Future<Either<Failure, CustomerData>?> getCustomerData();
}

/// HotelServiceUseCasesImpl will contain the HotelServiceUseCases implementation.
class CustomerUseCasesImpl implements CustomerUseCases {
  CustomerRepository? customerRepository;

  /// Dependence injection via constructor
  CustomerUseCasesImpl({CustomerRepository? repository}) {
    if (repository == null) {
      customerRepository = CustomerRepositoryImpl();
    } else {
      customerRepository = repository;
    }
  }

  /// Call API to get the Hotel addon services Screen Details details.
  ///
  /// [serviceDataArgument] to get the Hotel addon services Data for users.
  /// [Either<Failure, HotelServiceResultModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CustomerData>?> getCustomerData() async {
    return await customerRepository?.getCustomerData();
  }
}
