import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import '../../../mocks/fixture_reader.dart';

void main() {
  String jsonString =
      fixture("hotel/hotel_addon_service/hotel_service_mock.json");
  HotelServiceResultModel hotelServiceResultModel =
      HotelServiceResultModel.fromJson(jsonString);
  Status status = Status.fromJson(jsonString);
  HotelEnhancement hotelEnhancement = HotelEnhancement.fromJson(jsonString);
  GetAddonServices getAddonServices = GetAddonServices.fromJson(jsonString);

  test("Hotel Service Models", () {
    //Convert into Model
    expect(hotelServiceResultModel.getAddonServices != null, true);

    //convert into map
    Map<String, dynamic> map = hotelServiceResultModel.toMap();

    ///Check map conversion
    HotelServiceResultModel mapFromModel = HotelServiceResultModel.fromMap(map);

    expect(mapFromModel.getAddonServices != null, true);

    ///Convert to String
    String stringData = hotelServiceResultModel.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = hotelServiceResultModel.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("data", () {
    Data data =
        Data.fromJson(hotelServiceResultModel.getAddonServices!.data!.toJson());
    //convert into map
    Map<String, dynamic> map = data.toMap();
    expect(map.isNotEmpty, true);

    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.hotelEnhancements != null, true);

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

  test("Hotel Enhancement test ", () {
    ///Convert into Model
    HotelEnhancement model = hotelEnhancement;
    expect(model.currency == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    HotelEnhancement mapFromModel = HotelEnhancement.fromMap(map);
    expect(mapFromModel.currency == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });

  test("Addon Service test ", () {
    ///Convert into Model
    GetAddonServices model = getAddonServices;
    expect(model.data == null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetAddonServices mapFromModel = GetAddonServices.fromMap(map);
    expect(mapFromModel.data == null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
