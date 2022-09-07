import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("car_supplier/car_supplier.json");

  CarSupplierModelDomainData carSupplierModelDomainData =
      CarSupplierModelDomainData.fromJson(json);
  GetCarRentalSupplier getCarRentalSupplier =
      GetCarRentalSupplier.fromJson(json);
  GetCarRentalSupplierData getCarRentalSupplierData =
      GetCarRentalSupplierData.fromJson(json);

  test("car supplier Result Model Domain", () {
    ///Convert into Model
    CarSupplierModelDomainData model = carSupplierModelDomainData;
    expect(model.getCarRentalSupplier != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CarSupplierModelDomainData mapFromModel =
        CarSupplierModelDomainData.fromMap(map);
    expect(mapFromModel.getCarRentalSupplier != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car supplier Result Model Domain", () {
    ///Convert into Model
    GetCarRentalSupplier model = getCarRentalSupplier;
    expect(model.data != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetCarRentalSupplier mapFromModel = GetCarRentalSupplier.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car supplier Result Model Domain", () {
    ///Convert into Model
    GetCarRentalSupplierData model = getCarRentalSupplierData;
    expect(model.promotionList != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetCarRentalSupplierData mapFromModel =
        GetCarRentalSupplierData.fromMap(map);
    expect(mapFromModel.promotionList != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
