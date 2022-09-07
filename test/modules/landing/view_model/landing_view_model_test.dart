import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  String json = fixture("landing/landing_data.json");
  GetServiceCardData? landingModelData =
      ServiceCardModelDomainData.fromJson(json).getServiceCard?.data;
  test("Landing Page View Model", () {
    LandingPageViewModel landingPageViewModel =
        LandingPageViewModel.mapFromLandingModelData(landingModelData);
    LandingViewModel landingViewModel = LandingViewModel(
        pageState: LandingViewPageState.success, data: landingPageViewModel);
    expect(landingViewModel.pageState, LandingViewPageState.success);
    landingPageViewModel = LandingPageViewModel(defaultCustomText: "");
    //landingViewModel.data.setPopup(0);
    // expect(landingViewModel.data.popupIndex, 0);
  });
}
