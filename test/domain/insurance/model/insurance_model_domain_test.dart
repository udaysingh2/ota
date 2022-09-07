import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString = fixture("insurance/insurance_mock.json");
  InsuranceModelDomain insuranceResultModel =
      InsuranceModelDomain.fromJson(jsonString);
  GetInsurance getInsurance = GetInsurance.fromJson(jsonString);
  Status status = Status.fromJson(jsonString);

  test("Insurance Models", () {
    //Convert into Model
    expect(insuranceResultModel.getInsurance != null, true);

    //convert into map
    Map<String, dynamic> map = insuranceResultModel.toMap();

    ///Check map conversion
    InsuranceModelDomain mapFromModel = InsuranceModelDomain.fromMap(map);

    expect(mapFromModel.getInsurance != null, true);

    ///Convert to String
    String stringData = insuranceResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = insuranceResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data =
        Data.fromJson(insuranceResultModel.getInsurance!.data!.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.insurances != null, true);

    ///Convert to String
    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = mapFromModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("Status test ", () {
    ///Convert into Model
    Status model = status;
    expect(model.code == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Status mapFromModel = Status.fromMap(map);
    expect(mapFromModel.code == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("GetInsurance test ", () {
    ///Convert into Model
    GetInsurance model = getInsurance;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetInsurance mapFromModel = GetInsurance.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
