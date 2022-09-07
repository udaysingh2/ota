import 'package:ota/domain/car_rental/car_supplier/data_source/car_supplier_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_argument_model.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class CarSupplierRemoteDataSourceImplSuccessMock
    implements CarSupplierRemoteDataSource {
  @override
  Future<CarSupplierModelDomainData> getCarSupplierData(
      CarSupplierArgumentModel argument) async {
    String json = fixture("car_supplier/car_supplier.json");

    ///Convert into Model
    CarSupplierModelDomainData model =
        CarSupplierModelDomainData.fromJson(json);
    return model;
    //throw UnimplementedError();
  }
}
