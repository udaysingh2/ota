import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';

/// Interface for Gallery use cases.
abstract class CarSupplierUseCases {
  /// Call API to get the Car Supplier Screen details.
  ///
  /// [Either<Failure, CarSupplierModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, CarSupplierModelDomainData>?> getCarSupplierData({
    required CarSupplierArgumentModel argument,
  });
}

/// CarSupplierUseCasesImpl will contain the CarSupplierUseCases implementation.
class CarSupplierUseCasesImpl implements CarSupplierUseCases {
  CarSupplierRepository? carSupplierRepository;

  /// Dependence injection via constructor
  CarSupplierUseCasesImpl({CarSupplierRepository? repository}) {
    if (repository == null) {
      carSupplierRepository = CarSupplierRepositoryImpl();
    } else {
      carSupplierRepository = repository;
    }
  }

  /// Call API to get the Car Supplier Screen Details details.
  ///
  /// [Either<Failure, CarSupplierModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSupplierModelDomainData>?> getCarSupplierData({
    required CarSupplierArgumentModel argument,
  }) async {
    return await carSupplierRepository?.getCarSupplierData(argument);
  }
}
