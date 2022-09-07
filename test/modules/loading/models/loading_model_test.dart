import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test("LoadingModel Model", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("loading/loading_graphql.json"));

    ///For LoadingModel
    LoadingModel loadingModel = LoadingModel.fromMap(jsonMap);
    String jsonStringLoadingModel = loadingModel.toJson();
    LoadingModel loadingModelJson =
        LoadingModel.fromJson(jsonStringLoadingModel);
    expect(loadingModelJson.data != null, true);

    ///For class LoadingModelData
    LoadingModelData? loadingModelData = loadingModel.data;
    String jsonStringData = loadingModelData!.toJson();
    LoadingModelData loadingModelDataJson =
        LoadingModelData.fromJson(jsonStringData);
    expect(loadingModelDataJson.getLoadScreen != null, true);

    ///For class GetLoadScreen
    GetLoadScreen? getLoadScreen = loadingModelData.getLoadScreen;
    String jsonStringLoadingModelScreen = getLoadScreen!.toJson();
    GetLoadScreen getLoadScreenJson =
        GetLoadScreen.fromJson(jsonStringLoadingModelScreen);
    expect(getLoadScreenJson.data != null, true);

    ///For class Data
    GetLoadScreenData? data = getLoadScreen.data;
    String dataString = data!.toJson();
    GetLoadScreenData? dataJson = GetLoadScreenData?.fromJson(dataString);
    expect(dataJson.loadScreenUrl != null, true);

    ///For class Status
    Status? status = getLoadScreen.status;
    String statusString = status!.toJson();
    Status? statusJson = Status?.fromJson(statusString);
    expect(statusJson.header != null, true);
  });
}
