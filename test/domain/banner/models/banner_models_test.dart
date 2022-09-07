import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("banner/banner.json");
  LandingBannerModelDomain landingBannerModelDomain =
      LandingBannerModelDomain.fromJson(json);
  GetBanners getBanners = GetBanners.fromJson(json);
  Banner banner = Banner.fromJson(json);

  test("service card Result Model Domain", () {
    ///Convert into Model
    LandingBannerModelDomain model = landingBannerModelDomain;
    expect(model.getBanners != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    LandingBannerModelDomain mapFromModel =
        LandingBannerModelDomain.fromMap(map);
    expect(mapFromModel.getBanners != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    GetBanners model = getBanners;
    expect(model.data != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    GetBanners mapFromModel = GetBanners.fromMap(map);
    expect(mapFromModel.data != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("confirm booking Result Model Domain", () {
    ///Convert into Model
    Banner model = banner;
    expect(model.deeplinkUrl != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    Banner mapFromModel = Banner.fromMap(map);
    expect(mapFromModel.deeplinkUrl != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
