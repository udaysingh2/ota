import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/popup/models/popup_models.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("popup/popup.json");
  PopupModelDomain popupModelDomain = PopupModelDomain.fromJson(json);

  test("popup Model Domain", () {
    ///Convert into Model
    PopupModelDomain model = popupModelDomain;
    expect(model.getPopups != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    PopupModelDomain mapFromModel = PopupModelDomain.fromMap(map);
    expect(mapFromModel.getPopups != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    PopupModelDomain modelFromJson = PopupModelDomain.fromJson(jsondata);
    expect(modelFromJson.getPopups != null, true);
  });
  test("popup Model Domain", () {
    ///Convert into Model
    GetPopups? model = popupModelDomain.getPopups;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetPopups mapFromModel = GetPopups.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetPopups modelFromJson = GetPopups.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });

  test("popup Model Domain", () {
    ///Convert into Model
    GetPopupsData? model = popupModelDomain.getPopups?.data;
    expect(model?.popups != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetPopupsData mapFromModel = GetPopupsData.fromMap(map);
    expect(mapFromModel.popups != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetPopupsData modelFromJson = GetPopupsData.fromJson(jsondata);
    expect(modelFromJson.popups != null, true);
  });
  test("popup Model Domain", () {
    ///Convert into Model
    Popup? model = popupModelDomain.getPopups?.data?.popups?.first;
    expect(model?.deeplinkUrl != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Popup mapFromModel = Popup.fromMap(map);
    expect(mapFromModel.deeplinkUrl != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    Popup modelFromJson = Popup.fromJson(jsondata);
    expect(modelFromJson.deeplinkUrl != null, true);
  });
}
