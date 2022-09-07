import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("search/ota_search_data_mock.json");
  OtaSearch otaSearch = OtaSearch.fromJson(json);

  test("OtaSearch Model", () {
    ///Convert into Model
    OtaSearch model = otaSearch;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaSearch mapFromModel = OtaSearch.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("OtaSearchData Model", () {
    ///Convert into Model
    OtaSearchData? model = otaSearch.data;
    expect(model?.getOtaSearchResult != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    OtaSearchData mapFromModel = OtaSearchData.fromMap(map);
    expect(mapFromModel.getOtaSearchResult != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetSearchDetail Model", () {
    ///Convert into Model
    GetOtaSearchResult? model = otaSearch.data?.getOtaSearchResult;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetOtaSearchResult mapFromModel = GetOtaSearchResult.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("GetSearchDetailData Model", () {
    ///Convert into Model
    GetOtaSearchResultData? model = otaSearch.data?.getOtaSearchResult?.data;
    expect(model?.flight != null, false);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetOtaSearchResultData mapFromModel = GetOtaSearchResultData.fromMap(map);
    expect(mapFromModel.flight != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });

  test("CarRental Model", () {
    ///Convert into Model
    CarRental? model = otaSearch.data?.getOtaSearchResult?.data?.car;
    expect(model != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    CarRental?.fromMap(map);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("TicketActivity", () {
    ///Convert into Model
    TicketActivity? model =
        otaSearch.data?.getOtaSearchResult?.data?.ticketActivity;
    expect(model != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    TicketActivity?.fromMap(map);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });

  test("TourActivity", () {
    ///Convert into Model
    TourActivity? model =
        otaSearch.data?.getOtaSearchResult?.data?.tourActivity;
    expect(model != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    TourActivity?.fromMap(map);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);
  });
}
