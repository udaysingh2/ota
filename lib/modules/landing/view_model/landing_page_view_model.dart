import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';
import 'package:ota/modules/landing/view_model/preferences_view_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';

class LandingViewModel {
  LandingViewPageState pageState;
  LandingPageViewModel data;
  PreferenceScreenState preferenceScreenState;

  LandingViewModel({
    required this.pageState,
    required this.data,
    this.preferenceScreenState = PreferenceScreenState.dontshow,
  });
}

class LandingPageViewModel {
  String defaultCustomText;
  String previousSearchText;
  String backgroundUrl;
  String splashscreenUrl;
  List<BannerViewModel> bannerList;
  List<PopupViewModel> popupList;
  List<PreferencesViewModel> preferencesList;
  PopupViewModel? popup;
  int? popupIndex;
  String? userName;
  List<ServiceViewModel> serviceList;

  LandingPageViewModel(
      {this.defaultCustomText = "",
      this.previousSearchText = "",
      this.backgroundUrl = "",
      this.splashscreenUrl = "",
      this.bannerList = const [],
      this.popupList = const [],
      this.preferencesList = const [],
      this.popupIndex,
      this.popup,
      this.userName,
      this.serviceList = const []});

  factory LandingPageViewModel.mapFromLandingModelData(
      GetServiceCardData? data) {
    return LandingPageViewModel(
      backgroundUrl: data?.backgroundUrl ?? "",
      defaultCustomText: data?.defaultCustomText ?? "",
      // bannerList:LandingPageHelper.generateBannerList(data?.banner),
      // popupList:LandingPageHelper.generatePopupList(data?.popups),
      serviceList:
          LandingPageHelper.generateServiceList(data?.businessCards) ?? [],
      // preferencesList =
      //     LandingPageHelper.generatePreferencesList(data?.preferences),
      // userName:data?.userName,
    );
  }

  factory LandingPageViewModel.setDefault() {
    return LandingPageViewModel(
      backgroundUrl: "",
      bannerList: [],
      defaultCustomText: "",
      popupList: [],
      preferencesList: [],
      previousSearchText: "",
      serviceList: [],
      splashscreenUrl: "",
    );
  }

  void setPopup(int index) {
    popupIndex = index;
    popup = popupList[popupIndex!];
  }

  bool isPreferenceListAvailable() => preferencesList.isNotEmpty;
}

enum LandingViewPageState {
  initial,
  loading,
  failure,
  success,
  internetFailure,
}
enum PreferenceScreenState { show, dontshow }
