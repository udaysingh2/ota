import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/splash/models/splash_model.dart';

import '../../mocks/fixture_reader.dart';

void main() {
  test("Splalsh Model", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("splash/splash_model.json"));

    ///For Splash
    Splash splash = Splash.fromMap(jsonMap);
    String jsonStringSplash = splash.toJson();
    Splash splashJson = Splash.fromJson(jsonStringSplash);
    expect(splashJson.data != null, true);

    ///For class SplashModel
    SplashModel? splashModel = splash.data;
    String jsonStringData = splashModel!.toJson();
    SplashModel splashModelJson = SplashModel.fromJson(jsonStringData);
    expect(splashModelJson.getSplashScreen != null, true);

    ///For class GetSplashScreen
    GetSplashScreen? getSplashScreen = splashModel.getSplashScreen;
    String jsonStringSplashScreen = getSplashScreen!.toJson();
    GetSplashScreen getSplashScreenJson =
        GetSplashScreen.fromJson(jsonStringSplashScreen);
    expect(getSplashScreenJson.data != null, true);

    ///For class Data
    GetSplashScreenData? data = getSplashScreen.data;
    String dataString = data!.toJson();
    GetSplashScreenData? dataJson = GetSplashScreenData?.fromJson(dataString);
    expect(dataJson.splashScreenUrl != null, true);

    ///For class Status
    Status? status = getSplashScreen.status;
    String statusString = status!.toJson();
    Status? statusJson = Status?.fromJson(statusString);
    expect(statusJson.header != null, true);
  });
}
