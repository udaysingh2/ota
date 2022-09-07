import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/confi_api/models/config_result_model.dart';
import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("config/config_result_model.json");

  GetConfigDetails getConfigDetails = GetConfigDetails.fromJson(json);

  Datum datum = Datum.fromJson(json);

  Status status = Status.fromJson(json);

  test("ConfigResult Model", () {
    ///Convert into Model
    ConfigResultModel model = ConfigResultModel.fromJson(json);
    expect(model.getConfigDetails != null, true);

    expect(model.getConfigDetails!.data != null, true);

    //convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    ConfigResultModel mapFromModel = ConfigResultModel.fromMap(map);

    expect(mapFromModel.getConfigDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetConfig  test ", () {
    ///Convert into Model
    GetConfigDetails model = getConfigDetails;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetConfigDetails mapFromModel = GetConfigDetails.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Datum  test ", () {
    ///Convert into Model
    Datum model = datum;
    expect(model.name == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Datum mapFromModel = Datum.fromMap(map);
    expect(mapFromModel.name == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Status  test ", () {
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
}
