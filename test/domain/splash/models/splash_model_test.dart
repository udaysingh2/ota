import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/splash/models/splash_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("splash/splash_model.json");
  Splash splash = Splash.fromJson(json);

  test("splash Model Domain", () {
    ///Convert into Model
    Splash model = splash;
    expect(model.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Splash mapFromModel = Splash.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);

    Splash modelFromJson = Splash.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });
  test("splash Model Domain", () {
    ///Convert into Model
    SplashModel? model = splash.data;
    expect(model?.getSplashScreen != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    SplashModel mapFromModel = SplashModel.fromMap(map);
    expect(mapFromModel.getSplashScreen != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    SplashModel modelFromJson = SplashModel.fromJson(jsondata);
    expect(modelFromJson.getSplashScreen != null, true);
  });

  test("splash Model Domain", () {
    ///Convert into Model
    GetSplashScreen? model = splash.data?.getSplashScreen;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetSplashScreen mapFromModel = GetSplashScreen.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetSplashScreen modelFromJson = GetSplashScreen.fromJson(jsondata);
    expect(modelFromJson.data != null, true);
  });
  test("splash Model Domain", () {
    ///Convert into Model
    GetSplashScreenData? model = splash.data?.getSplashScreen?.data;
    expect(model?.splashScreenUrl != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetSplashScreenData mapFromModel = GetSplashScreenData.fromMap(map);
    expect(mapFromModel.splashScreenUrl != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
    GetSplashScreenData modelFromJson = GetSplashScreenData.fromJson(jsondata);
    expect(modelFromJson.splashScreenUrl != null, true);
  });
}
