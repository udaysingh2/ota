import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/channels/landing_customer_register_invoke/models/landing_customer_register_argument_model_channel.dart';
import 'package:ota/channels/landing_customer_register_invoke/usecases/landing_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core/user_location.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_banner_parameters.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_common_parameters.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_common_values.dart';
import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
import 'package:ota/domain/playlist/models/playlist_data_argument.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_landing/helpers/recent_search_db_helper.dart';
import 'package:ota/modules/landing/bloc/banner_bloc.dart';
import 'package:ota/modules/landing/bloc/dynamic_playlist_bloc.dart';
import 'package:ota/modules/landing/bloc/ota_static_playlist_bloc.dart';
import 'package:ota/modules/landing/bloc/popup_bloc.dart';
import 'package:ota/modules/landing/bloc/preference_questions_bloc.dart';
import 'package:ota/modules/landing/bloc/service_card_bloc.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';
import 'package:ota/modules/landing/bloc/sync_car_recent_search_bloc.dart';
import 'package:ota/modules/landing/channels/super_app_to_landing_register.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_bottom_bar_unregistered_user.dart';
import 'package:ota/modules/landing/view/widgets/landing_background_image.dart';
import 'package:ota/modules/landing/view/widgets/landing_playlist_widget.dart';
import 'package:ota/modules/landing/view/widgets/landing_sliders_tip.dart';
import 'package:ota/modules/landing/view/widgets/landing_top_bar_widget.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_widget.dart';
import 'package:ota/modules/landing/view/widgets/search_text_widget.dart';
import 'package:ota/modules/landing/view/widgets/service_card_widget.dart';
import 'package:ota/modules/landing/view/widgets/static_playlist_widget.dart';
import 'package:ota/modules/landing/view/widgets/wrapped_grid_view_widget.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/playlist_view_model.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';
import 'package:ota/modules/landing/view_model/preference_list_view_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/landing/view_model/static_playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/static_playlist_view_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import 'package:ota/modules/preferences/helpers/preferences_helper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../common/utils/app_theme.dart';
import 'widgets/fab_icon_widget/fab_widget.dart';
import 'widgets/fab_icon_widget/fab_widget_controller.dart';

const double _kExpandableMaxHeight = 193;
const double _kAppBarHeight = 89;
const double _kDetailsBorder = 24;
const double _kSliverBarTopPadding = 22;
const double _kServiceCardLeftMargin = 21;
const double _kServiceCardRightMargin = 22;
const double _kOverflowBorderValue = 1;
const double _kGreetingLeftPadding = 24;
const double _kSize193 = 193;
const double _kErrorWidgetGap = 300;
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kBannerType = "OTA_LANDING";
const String _kDynamic = 'dynamic';
const String _kStatic = 'static';
const String _kDefaultServiceName = 'OTA';
const int _kDefaultOffset = 0;
const int _kDefaultLimit = 20;
const double _kServiceCardPadding = 75;
const String _searchKey = "null";
const bool _searchAvailableApi = true;
const String _kSuccessCode = "1000";

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final StatusBarBloc _statusBarBloc = StatusBarBloc();
  final DynamicPlayListBloc _dynamicPlayListBloc = DynamicPlayListBloc();
  final OtaStaticPlayListBloc _staticPlayListBloc = OtaStaticPlayListBloc();
  final BannerBloc _bannerBloc = BannerBloc();
  final PopupBloc _popupBloc = PopupBloc();
  PlayListDataArgument? playListDataArgument;
  StaticPlaylistArgumentDomain? staticPlayListDataArgument;
  DynamicPlayListDataArgumentModelDomain? dynamicPlayListDataArgument;

  final ScrollController _scrollController = ScrollController();
  final ServiceCardBloc _serviceCardBloc = ServiceCardBloc();
  final PreferenceQuestionsBloc _preferenceQuestionsBloc =
      PreferenceQuestionsBloc();
  final SuperAppToRegisterConfirmLanding superAppToRegisterConfirmLanding =
      SuperAppToRegisterConfirmLanding();
  StreamSubscription? _streamSubscription;

  final SyncCarRecentSearchBloc syncCarRecentSearchBloc =
      SyncCarRecentSearchBloc();

  @override
  void initState() {
    UserLocation().getUserLocationFromChannel();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
    });
    if (getLoginProvider().isLoggedIn()) {
      _preferenceQuestionsBloc.getPreferencesData();
    }
    _serviceCardBloc.stream.listen(
      (event) {
        if (_serviceCardBloc.state.pageState ==
            LandingViewPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      },
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      makeApiCall(false);
      superAppToRegisterConfirmLanding.handle(
          context: context, onHandleSuccess: waitForSuperAppReply);
    });

    _preferenceQuestionsBloc.stream.listen((event) {
      if (_preferenceQuestionsBloc.shouldShowPreferenceScreen &&
          _preferenceQuestionsBloc.state.preferencesListViewModelState ==
              PreferencesListViewModelState.success &&
          getLoginProvider().userType == UserType.loggedInUser) {
        _openPreferenceScreen();
      } else if (_preferenceQuestionsBloc.state.preferencesListViewModelState ==
          PreferencesListViewModelState.failure) {
        _streamSubscription?.cancel();
      }
    });
    _syncRecentSearchData();
  }

  void setNavigatorCallbackBlocListener() {
    if (_streamSubscription != null) {
      _streamSubscription?.cancel();
    }
    _streamSubscription = NavigatorCallbackBloc.shared.stream.listen((event) {
      if (event.isNotEmpty &&
          event.last.settings.name == AppRoutes.landingPage &&
          _preferenceQuestionsBloc.shouldShowPreferenceScreen &&
          getLoginProvider().userType == UserType.loggedInUser) {
        _openPreferenceScreen();
      }
    });
  }

  Future<void> requestPopupData() {
    return _popupBloc.getPopupData();
  }

  Future<void> requestBannerData() {
    return _bannerBloc.getBannerData(_kBannerType);
  }

  Future<void> requestStaticPlayListData(String source) async {
    staticPlayListDataArgument =
        StaticPlaylistArgumentDomain.getDefaultInitialArguments(
            offset: _kDefaultOffset,
            limit: _kDefaultLimit,
            serviceName: _kDefaultServiceName,
            enabledServices: AppConfig().configModel.otaSearchServicesEnabled);
    return _staticPlayListBloc.getPlayListData(
        argument: staticPlayListDataArgument);
  }

  Future<void> requestDynamicPlayListData(String source) async {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);

    playListDataArgument = PlayListDataArgument.getDefaultInitialArguments(
        loginModel.userId, source);
    return _dynamicPlayListBloc.getDynamicPlayListData(
        argument: playListDataArgument);
  }

  @override
  void dispose() {
    superAppToRegisterConfirmLanding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collapsedHeight = _kAppBarHeight - MediaQuery.of(context).padding.top;
    _statusBarBloc.setDynamicCardHeadOffset(collapsedHeight);
    return getLoginProviderWidget(
      builder: () {
        return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            body: Stack(children: [
              Padding(
                padding: getLoginProvider().isLoggedIn()
                    ? const EdgeInsets.only(bottom: kSize0)
                    : const EdgeInsets.only(bottom: kSize82),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        statusBarBrightness:
                            Platform.isIOS ? Brightness.light : Brightness.dark,
                        statusBarIconBrightness:
                            Platform.isIOS ? Brightness.light : Brightness.dark,
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding:
                            const EdgeInsets.only(left: _kGreetingLeftPadding),
                        collapseMode: CollapseMode.pin,
                        title: Align(
                          alignment: Alignment.bottomLeft,
                          child: BlocBuilder(
                              bloc: _serviceCardBloc,
                              builder: () {
                                return BlocBuilder(
                                    bloc: _statusBarBloc,
                                    builder: () {
                                      if (_statusBarBloc
                                              .state.statusBarBlocState ==
                                          StatusBarBlocState.opened) {
                                        return FittedBox(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SearchTextWidget(
                                                searchCustomText:
                                                    _getSearchText(),
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    _kSize193,
                                                onTap: onSearchClicked,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                getTranslated(
                                                    context,
                                                    AppLocalizationsStrings
                                                        .landingText),
                                                style: AppTheme.kSmallerRegular
                                                    .copyWith(
                                                        color: AppColors
                                                            .kLight100),
                                              ),
                                              const SizedBox(
                                                height: kSize24,
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    });
                              }),
                        ),
                        background: BlocBuilder(
                            bloc: _serviceCardBloc,
                            builder: () {
                              return LandingBackgroundImage(
                                  _serviceCardBloc.state.data.backgroundUrl);
                            }),
                      ),
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      expandedHeight: _kExpandableMaxHeight,
                      toolbarHeight: collapsedHeight,
                      shadowColor: AppColors.kShadowAppBar,
                      floating: false,
                      collapsedHeight: collapsedHeight,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.zero,
                        child: Column(
                          children: [
                            LandingSlidersTip(
                              statusBarBloc: _statusBarBloc,
                            ),
                            const SizedBox(
                              height: kSize4,
                            ),
                            Container(
                              height: _kSliverBarTopPadding,
                              transform: Matrix4.translationValues(
                                  Offset.zero.dx,
                                  _kOverflowBorderValue,
                                  Offset.zero.dy),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(_kDetailsBorder),
                                  topLeft: Radius.circular(_kDetailsBorder),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return getPagedata();
                      },
                      childCount: 1,
                    )),
                  ],
                ),
              ),
              LandingTopBar(
                statusBarBloc: _statusBarBloc,
                onSearchTap: onSearchClicked,
                onBackTap: onBackPressed,
              ),
              getLoginProvider().isLoggedIn()
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: OTAFabWidget(
                        fabWidgetController: FabWidgetController(),
                      ),
                    )
                  : OtaFabIconUnregistered(
                      onTap: () {
                        waitForSuperAppToPushLandingPage();
                      },
                    ),
              BlocBuilder(
                  bloc: _popupBloc,
                  builder: () {
                    return _popupBloc.state.popupViewModelState ==
                            PopupViewModelState.success
                        ? _getPopup()
                        : const SizedBox();
                  }),
            ]),
          ),
        );
      },
    );
  }

  Widget getLoginProviderWidget({required Widget Function() builder}) {
    return Selector<LoginModel, bool>(
      selector: (p0, p1) {
        return getLoginProvider().userType == UserType.loggedInUser;
      },
      builder: (context, text, subchild) {
        return builder();
      },
    );
  }

  Future<bool> onWillPop() async {
    NavigatorHelper.shouldSystemPop(context);
    return false;
  }

  void onBackPressed() {
    NavigatorHelper.shouldSystemPop(context);
  }

  Widget getPagedata() {
    return Container(
      margin: const EdgeInsets.only(left: 0),
      child: BlocBuilder(
          bloc: _serviceCardBloc,
          builder: () {
            switch (_serviceCardBloc.state.pageState) {
              case LandingViewPageState.failure:
              case LandingViewPageState.internetFailure:
                return failureState();
              case LandingViewPageState.success:
                return _getSuccessWidget();
              default:
                return const SizedBox();
            }
          }),
    );
  }

  Widget failureState() {
    return Material(
      child: OtaNetworkErrorWidgetWithRefresh(
        height: MediaQuery.of(context).size.height -
            _kAppBarHeight -
            _kErrorWidgetGap,
        onRefresh: () async => makeApiCall(true),
      ),
    );
  }

  void makeApiCall(bool isRefresh) {
    _triggerFirebaseEvent();
    _serviceCardBloc.getServiceCardData(isRefresh);
    if (getLoginProvider().isLoggedIn()) {
      requestPopupData();
    }
    requestBannerData();
    requestDynamicPlayListData(_kDynamic);
    requestStaticPlayListData(_kStatic);
  }

  Widget _getPopup() {
    return PopupDialog(popupViewModel: _popupBloc.state.data);
  }

  void waitForSuperAppReply(RegisterConfirmLandingModelChannel data) async {
    if (getLoginProvider().userType == UserType.loggedInUser) {
      _preferenceQuestionsBloc.getPreferencesData();
      if (data.existingCust.toString().toLowerCase() == "no") {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
            context,
            AppLocalizationsStrings.successRegistration,
          ),
          AppColors.kBannerCSuccessColor,
          _kTickIcon,
        );
      }
    }
  }

  void waitForSuperAppToPushLandingPage() {
    LandingCustomerRegisterUseCases landingCustomerRegisterUseCases =
        LandingCustomerRegisterUseCasesImpl();
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "landingCustomerRegister",
        arguments: LandingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  Widget _getSuccessWidget() {
    Provider.of<LandingPageViewModel>(context).serviceList =
        _serviceCardBloc.state.data.serviceList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _getserviceCards(_serviceCardBloc.state.data.serviceList.length),
        _getBanners(),
        _buildDynamicPlaylistWidget(),
        _buildStaticPlaylistWidget(),
      ],
    );
  }

  Widget _getserviceCards(final int countServiceCards) {
    if (countServiceCards == 0) {
      return failureState();
    } else {
      return Container(
          padding: const EdgeInsets.only(
              left: _kServiceCardLeftMargin, right: _kServiceCardRightMargin),
          child: WrappedGridView(
              listOfWidget: _getChildrenServiceCards(countServiceCards)));
    }
  }

  List<Widget> _getChildrenServiceCards(final int countServiceCards) {
    List<Widget> childrenServiceCard = [];
    List<ServiceViewModel> serviceViewModel =
        _serviceCardBloc.state.data.serviceList;
    for (var item = 0; item < countServiceCards; item++) {
      childrenServiceCard.add(ServiceCardWidget(
        footerText: serviceViewModel[item].title,
        headerText: serviceViewModel[item].serviceText,
        imageUrl: isLarge(item, countServiceCards)
            ? (serviceViewModel[item].largeImageUrl)
            : (serviceViewModel[item].imageUrl),
        width: isLarge(item, countServiceCards)
            ? double.infinity
            : (MediaQuery.of(context).size.width - _kServiceCardPadding) / 3,
        onTap: () => onServiceCardClicked(item, serviceViewModel[item]),
        serviceViewModelService: ServiceViewModelServiceExtension.fromString(
            serviceViewModel[item].service),
      ));
    }
    return childrenServiceCard;
  }

  Widget _buildDynamicPlaylistWidget() {
    return BlocBuilder(
      bloc: _dynamicPlayListBloc,
      builder: () {
        return Container(
          child: _dynamicPlayListBloc.state.playListViewModelState ==
                  PlayListViewModelState.success
              ? ListView(
                  padding: const EdgeInsets.only(top: kSize0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildListView(
                        _dynamicPlayListBloc.state.dynamicPlaylist, false),
                  ],
                )
              : const SizedBox(),
        );
      },
    );
  }

  Widget _buildStaticPlaylistWidget() {
    return BlocBuilder(
      bloc: _staticPlayListBloc,
      builder: () {
        return Container(
          child: _staticPlayListBloc.state.playListViewModelState ==
                  StaticPlayListViewModelState.success
              ? ListView(
                  padding: const EdgeInsets.only(top: kSize0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildStaticListView(
                        _staticPlayListBloc.state.staticPlaylist),
                  ],
                )
              : const SizedBox(),
        );
      },
    );
  }

  Widget _buildStaticListView(StaticPlayListDataViewModel playList) {
    return _getStaticPlayCardListWidget(
        playList.playList, playList.serviceName!);
  }

  Widget _buildListView(PlayListDataViewModel playList, bool isStatic) {
    return _getPlayCardListWidget(
      playList.playList,
      playList.source,
      playList.serviceName,
      isStatic,
    );
  }

  Widget _getPlayCardListWidget(List<OtaLandingPlayListModel> playList,
      String source, String serviceName, bool isStatic) {
    return LandingPlayListWidget(
      isStatic: isStatic,
      playList: playList,
      onTitleArrowClick: (title, playlistId) {
        final argument = PlaylistViewArgument.fromPlaylistDataArguments(
          playListDataArgument,
          isStatic ? _kStatic : _kDynamic,
          serviceName,
          isStatic,
          playlistId,
        );
        argument.playlistName = title;
        Navigator.pushNamed(context, AppRoutes.playlistScreen,
            arguments: argument);
      },
    );
  }

  Widget _getStaticPlayCardListWidget(
      List<OtaLandingStaticPlayListModel> playList, String serviceName) {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    return StaticPlayListWidget(
      playList: playList,
      onTitleArrowClick: (String id, String name) {
        final argument =
            OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
                StaticPlaylistArgumentDomain.getDefaultArguments(
                    userId: loginModel.userId,
                    source: _kStatic,
                    id: id,
                    enabledServices:
                        AppConfig().configModel.otaSearchServicesEnabled),
                name);
        Navigator.pushNamed(context, AppRoutes.otaVerticalPlaylistScreen,
            arguments: argument);
      },
    );
  }

  bool isLarge(int currentIndex, int count) {
    if (count % 3 == 1) {
      if (currentIndex == count - 1) {
        return true;
      }
    }
    return false;
  }

  void onSearchClicked() async {
    final String previousSearchText =
        _serviceCardBloc.state.data.previousSearchText;
    var data = await Navigator.pushNamed(context, AppRoutes.otaSearchScreen,
        arguments: previousSearchText);

    _serviceCardBloc.updateSearchString(data != null ? data as String : null);
  }

  void onServiceCardClicked(
      int serviceCardIndex, ServiceViewModel serviceCard) {
    switch (ServiceViewModelServiceExtension.fromString(serviceCard.service)) {
      case ServiceViewModelService.hotel:
        Navigator.pushNamed(context, AppRoutes.hotelLandingScreen);
        break;
      case ServiceViewModelService.tour:
        if (OtaServiceEnabledHelper.isTourEnabled()) {
          Navigator.pushNamed(context, AppRoutes.toursLandingScreen);
        }
        break;
      case ServiceViewModelService.carRental:
        if (OtaServiceEnabledHelper.isCarEnabled()) {
          Navigator.pushNamed(context, AppRoutes.carLandingScreen);
        }
        break;
      case ServiceViewModelService.insurance:
        Navigator.pushNamed(
          context,
          AppRoutes.insuranceLandingScreen,
        );
        break;
      default:
        if (!OtaChannelConfig.isModule) {
          if (serviceCard.service == "FLIGHT") {
            Navigator.pushNamed(context, AppRoutes.demoScreen);
          }
        }
        break;
    }
  }

  void onInsuranceServiceCardClicked(String deepLinkUrl) {
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.insuranceAlertMessage),
        errorTitle: getTranslated(
            context, AppLocalizationsStrings.insuranceAlertHeader),
        buttonTitle: getTranslated(
            context, AppLocalizationsStrings.insuranceAlertCancel),
        button2: true,
        button2Title:
            getTranslated(context, AppLocalizationsStrings.insuranceAlertOK),
        onPressedButton2: () {
          Navigator.of(context).pop();
          _openDeepLinkUrl(deepLinkUrl);
        },
        onPressed: () {
          Navigator.of(context).pop();
        }).showAlertDialog(context);
  }

  void _openDeepLinkUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  }

  void _openPreferenceScreen() async {
    _streamSubscription?.cancel();
    bool isSuccess = await Navigator.pushNamed(
      context,
      AppRoutes.preferencesScreen,
      arguments: PreferencesHelper.getPreferenceArgumentList(
          _preferenceQuestionsBloc.state.preferencesList),
    ) as bool;
    if (isSuccess) {
      _preferenceQuestionsBloc.setPreferenceSubmitSuccess();
    } else {
      setNavigatorCallbackBlocListener();
    }
  }

  String _getSearchText() {
    final previousText = _serviceCardBloc.state.data.previousSearchText;
    final defaultText = _serviceCardBloc.state.data.defaultCustomText;
    return (previousText.isNotEmpty)
        ? previousText
        : (defaultText.isEmpty)
            ? getTranslated(context, AppLocalizationsStrings.landingSearchText)
            : defaultText;
  }

  Widget _getBanners() {
    return BlocBuilder(
        bloc: _bannerBloc,
        builder: () {
          return _bannerBloc.state.bannerViewModelState ==
                  BannerViewModelState.success
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: kSize13),
                  child: BannerWidget(
                    bannerList: _bannerBloc.state.data,
                    launchBannerInApp: false,
                    onBannerTap: (index) {
                      _getBannerFirebaseEvents(_bannerBloc.state.data[index],
                          FirebaseEvent.otaBanner, index);
                    },
                  ))
              : const SizedBox(
                  height: kSize5,
                );
        });
  }

  /*_syncRecentData() async {
    int count = 0;
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    final dataList = CarSearchDBHelper.getCarRecentSearchData();
    if (loginModel.userType == UserType.loggedInUser && dataList.isNotEmpty) {
      ReceivePort port = ReceivePort();
      final isolate = await Isolate.spawn<List<dynamic>>(
          _syncRecentSearchData, [port.sendPort, dataList]);
      port.listen((message) {
        if (message == "Success") {
          count++;
        }
        if (count == dataList.length) {
          isolate.kill(priority: Isolate.immediate);
          CarSearchDBHelper.removeAll();
        }
      });
    }
  }

  void _syncRecentSearchData(List<dynamic> list) {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);

    SendPort sendPort = list[0];
    for (var element in list[1]) {
      syncCarRecentSearchBloc
          .syncRecentDataForGuestUser(element, loginModel.userId, searchKey,
              latitude, longitude, pageNumber, pageSize, searchAvailableApi)
          .then((value) {
        if (value == _kSuccessCode) {
          sendPort.send("Success");
        } else {
          sendPort.send("Error");
        }
      });
    }
  }*/

  void _syncRecentSearchData() async {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);

    if (loginModel.userType == UserType.loggedInUser &&
        CarSearchDBHelper.getCarRecentSearchData().isNotEmpty) {
      var value = await syncCarRecentSearchBloc.syncRecentDataForGuestUser(
          CarSearchDBHelper.getCarRecentSearchDataForSync(),
          loginModel.userId,
          _searchKey,
          _searchAvailableApi,
          true);
      if (value == _kSuccessCode) {
        CarSearchDBHelper.removeAll();
      }
    }
  }

  void _triggerFirebaseEvent() {
    FirebaseLogger fbLogger = FirebaseLogger();

    fbLogger.addUserId();
    fbLogger.addUserLocation();
    fbLogger.addKeyValue(
        key: OtaCommonParameters.travelCardId,
        value: OtaCommonValues.travelCardIdOta);
    fbLogger.addKeyValue(
        key: OtaCommonParameters.travelCardName,
        value: OtaCommonValues.travelCardNameOta);

    fbLogger.publishToSuperApp(FirebaseEvent.otaLanding);
  }

  _getBannerFirebaseEvents(
      BannerDataModel bannerDataModel, String eventName, int index) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: bannerDataModel.bannerId, key: OtaBannerParameters.bannerId);
    logger.addKeyValue(
        value: bannerDataModel.function,
        key: OtaBannerParameters.bannerSection);
    logger.addIntValue(
        value: index + 1, key: OtaBannerParameters.bannerSequence);
    logger.addKeyValue(
        value: bannerDataModel.imageUrl, key: OtaBannerParameters.bannerName);
    logger.addKeyValue(
        value: bannerDataModel.deepLinkUrl, key: OtaBannerParameters.bannerUrl);
    logger.addKeyValue(
        value: bannerDataModel.deepLinkUrl, key: OtaBannerParameters.bannerUrl);
    logger.addCommaSeparatedList(
        value: _bannerBloc.state.data.map((e) => e.bannerId).toList(),
        key: OtaBannerParameters.allBannerIdSequence);
    logger.publishToSuperApp(eventName);
  }
}
