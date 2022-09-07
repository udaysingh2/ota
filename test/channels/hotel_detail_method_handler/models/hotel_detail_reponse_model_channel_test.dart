import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture(
      "channels/hotel_detail_method_handler/hotel_detail_method_handler.json");

  PropertyDetailHandlerModelChannel propertyDetailHandlerModelChannel =
      PropertyDetailHandlerModelChannel.fromJson(json);

  test("ota booking handler Model", () {
    ///Convert into Model
    PropertyDetailHandlerModelChannel model = propertyDetailHandlerModelChannel;
    expect(model.cityId != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    PropertyDetailHandlerModelChannel mapFromModel =
        PropertyDetailHandlerModelChannel.fromMap(map);
    expect(mapFromModel.cityId != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    ///Check map conversion
    PropertyDetailHandlerModelChannel modelFromJson =
        PropertyDetailHandlerModelChannel.fromJson(jsondata);
    expect(modelFromJson.cityId != null, true);
  });
}
