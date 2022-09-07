import 'package:either_dart/either.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/domain/car_rental/car_supplier/repositories/car_supplier_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class CarSupplierRepositoryImplSuccessMock
    implements CarSupplierRepositoryImpl {
  @override
  CarSupplierRemoteDataSource? carSupplierRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarSupplierModelDomainData>> getCarSupplierData(
      CarSupplierArgumentModel argument) async {
    String json = fixture("car_supplier/car_supplier.json");
    CarSupplierModelDomainData model =
        CarSupplierModelDomainData.fromJson(json);
    printDebug(model.getCarRentalSupplier?.data?.promotionList?.length);
    return Right(model);
    //throw UnimplementedError();
  }
}
