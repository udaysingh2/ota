import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart'
    as banner_model;
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/popup/models/popup_models.dart' as popup_model;
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  banner_model.GetBannersData getBannersData = banner_model.GetBannersData(
      banner: [
        banner_model.Banner(
            bannerId: "id", imageFilename: "url", deeplinkUrl: 'url')
      ]);
  popup_model.GetPopupsData getPopupsData = popup_model.GetPopupsData(popups: [
    popup_model.Popup(popupId: "id", imageFilename: "url", deeplinkUrl: 'url')
  ]);
  List<BusinessCard> serviceList = [
    BusinessCard(
        serviceText: "Hotels",
        title: "more than 1,000",
        description: "100,000+ Hotels",
        imageUrl:
            "https://static-dev.alp-robinhood.com/ota/serviceCard/image/1",
        largeImageUrl:
            "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1",
        serviceBackgroundUrl:
            "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1",
        sortSeq: "1",
        service: "HOTEL",
        deeplinkUrl: "https://robinhood/")
  ];

  test("landing page helper", () async {
    SharedPreferences.setMockInitialValues({});
    expect(LandingPageHelper.generateBannerList(getBannersData) != null, true);
    expect(LandingPageHelper.generatePopupList(getPopupsData) != null, true);
    expect(LandingPageHelper.generateServiceList(serviceList) != null, true);
    expect(BannerDataModel().getDummyData().isNotEmpty, true);
    expect(LandingPageHelper.getIntentType(true), "BLOCK");
  });
}
