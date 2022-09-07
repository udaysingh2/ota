import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/channels/super_app_to_booking_register.dart';
import 'package:ota/modules/insurance/bloc/insurance_bloc.dart';
import 'package:ota/modules/insurance/bloc/insurance_status_bar_bloc.dart';
import 'package:ota/modules/insurance/view/widgets/backgroud_image.dart';
import 'package:ota/modules/insurance/view/widgets/insurance_list_widget.dart';
import 'package:ota/modules/insurance/view/widgets/insurance_top_bar.dart';
import 'package:ota/modules/insurance/view_model/insurance_view_model.dart';

const double _kAppBarHeight = 89;
const double _kSliverBarTopPadding = 24;
const double _kDetailsBorder = 24;
const double _kTopHeight = 100;
const int footerMaxLine = 2;
const int headerMaxLine = 2;
const double _kExpandedHeight = 280;
const double _kElevation = 5;
int _kPageSize = 20;

const String actionType = "WEBVIEW";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kError1999 = "Error_1999";
const String _kErrorNetwork = "Error_Network";

class InsuranceLandingScreen extends StatefulWidget {
  const InsuranceLandingScreen({Key? key}) : super(key: key);

  @override
  State<InsuranceLandingScreen> createState() => _InsuranceLandingScreenState();
}

class _InsuranceLandingScreenState extends State<InsuranceLandingScreen> {
  int currentPage = 1;
  final InsuranceBloc insuranceBloc = InsuranceBloc();
  final InsuranceStatusBarBloc _statusBarBloc = InsuranceStatusBarBloc();
  final ScrollController _scrollController = ScrollController();
  final SuperAppToRegisterConfirmBooking superAppToRegisterConfirmBooking =
      SuperAppToRegisterConfirmBooking();
  int currentPageNumber = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? serviceType =
          ModalRoute.of(context)?.settings.arguments as String?;
      requestInsuranceData(serviceType: serviceType);
      superAppToRegisterConfirmBooking.handle(
          context: context, onHandleSuccess: waitForReplyFromSuperApp);
      insuranceBloc.stream.listen((event) {
        if (insuranceBloc.state.pageState ==
            InsuranceViewModelState.failureNetwork) {
          _showInternetFailureAlert();
        } else if (insuranceBloc.state.pageState ==
            InsuranceViewModelState.pullDownLoadingFailureNetwork) {
          _showInternetFailureAlert(isPullDownLoadingError: true);
        } else if (insuranceBloc.state.pageState ==
            InsuranceViewModelState.failure1899) {
          _showFailureAlert1899();
        } else if (insuranceBloc.state.pageState ==
            InsuranceViewModelState.failure1999) {
          _showFailureAlert1999();
        }
      });
    });
  }

  bool isNewDataRequired(int index) {
    int maxSize = currentPageNumber * _kPageSize;
    if (maxSize == index) return true;
    return false;
  }

  Future<void> requestInsuranceData(
      {String? serviceType,
      bool isRefresh = false,
      bool refreshData = false,
      int pageNumber = 1}) async {
    if (isRefresh || refreshData) {
      currentPageNumber = 1;
    }
    insuranceBloc.getInsuranceData(
        pageNumber: pageNumber,
        refreshData: refreshData,
        isRefresh: isRefresh,
        serviceType: serviceType);
  }

  Future<void> _showInternetFailureAlert(
          {bool isPullDownLoadingError = false}) async =>
      await OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.noInternet),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          if (currentPageNumber == 1 && !isPullDownLoadingError) {
            Navigator.popUntil(context,
                (route) => route.settings.name == AppRoutes.landingPage);
          }
        },
      ).showAlertDialog(context);

  Future<void> _showFailureAlert1899() async => await OtaAlertDialog(
        errorMessage: getTranslated(context, AppLocalizationsStrings.error1899),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          if (currentPageNumber == 1) {
            Navigator.popUntil(context,
                (route) => route.settings.name == AppRoutes.landingPage);
          }
        },
      ).showAlertDialog(context);

  Future<void> _showFailureAlert1999() async => await OtaAlertDialog(
        errorMessage: getTranslated(context, AppLocalizationsStrings.error1999),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          if (currentPageNumber == 1) {
            Navigator.popUntil(context,
                (route) => route.settings.name == AppRoutes.landingPage);
          }
        },
      ).showAlertDialog(context);

  @override
  void dispose() {
    insuranceBloc.dispose();
    superAppToRegisterConfirmBooking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: insuranceBloc,
        builder: () {
          if (currentPageNumber > 1 && insuranceBloc.showCachedData) {
            return successWidget();
          }
          switch (insuranceBloc.state.pageState) {
            case InsuranceViewModelState.loading:
              return loadIngWidget();
            case InsuranceViewModelState.failure:
              return failureState();
            case InsuranceViewModelState.failureNetwork:
            case InsuranceViewModelState.failure1899:
            case InsuranceViewModelState.failure1999:
              return networkFailureState();
            case InsuranceViewModelState.success:
            case InsuranceViewModelState.pullDownLoadingFailureNetwork:
            case InsuranceViewModelState.pullDownLoading:
              return successWidget();
            case InsuranceViewModelState.initial:
              return defaultWidget();
          }
        });
  }

  Widget successWidget() {
    final collapsedHeight = _kAppBarHeight - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSize92),
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarBrightness:
                          Platform.isIOS ? Brightness.light : Brightness.dark,
                      statusBarIconBrightness:
                          Platform.isIOS ? Brightness.light : Brightness.dark,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: BackgroundImage(
                          insuranceBloc.state.data?.serviceBackgroundUrl ?? ""),
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    expandedHeight: _kExpandedHeight,
                    toolbarHeight: collapsedHeight,
                    floating: false,
                    collapsedHeight: collapsedHeight,
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: Size.zero,
                      child: Container(
                        height: _kSliverBarTopPadding,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(_kDetailsBorder),
                            topLeft: Radius.circular(_kDetailsBorder),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: insuranceBloc.state.pageState ==
                      InsuranceViewModelState.pullDownLoading
                  ? const OTALoadingIndicator()
                  : successWidgetView(),
            ),
          ),
          _getTopBar(),
        ],
      ),
      bottomSheet: getBottomFooter(),
    );
  }

  Widget successWidgetView() {
    return OtaRefreshIndicator(
      displacement: 0,
      text: Text(getTranslated(context, AppLocalizationsStrings.loading)),
      onRefresh: () async => await requestInsuranceData(refreshData: true),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: kSize12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Builder(builder: (context) {
                if (insuranceBloc.state.data!.insuranceHeaderTitle != null) {
                  return _insuranceHeader(
                      insuranceBloc.state.data!.insuranceHeaderTitle!);
                } else {
                  return const SizedBox();
                }
              });
            } else {
              if (isNewDataRequired(index)) {
                currentPageNumber++;
                requestInsuranceData(pageNumber: currentPageNumber);
              }
              return _insuranceList(index - 1);
            }
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: kSize24,
            );
          },
          itemCount: 1 + insuranceBloc.state.data!.insurances!.length),
    );
  }

  Widget failureState() {
    return Scaffold(
        appBar: OtaAppBar(
            title: getTranslated(
                context, AppLocalizationsStrings.travelInsurance)),
        body: OtaNetworkErrorWidgetWithRefresh(
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () async => await requestInsuranceData(isRefresh: true),
        ));
  }

  Widget networkFailureState() {
    return const Scaffold(body: SizedBox());
  }

  Widget loadIngWidget() {
    return const Scaffold(
      body: OTALoadingIndicator(),
    );
  }

  Widget defaultWidget() {
    return const Scaffold(body: SizedBox());
  }

  void waitForReplyFromSuperApp(RegisterConfirmBookingModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    if (loginModel.userType == UserType.loggedInUser) {
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
    BookingCustomerRegisterUseCases landingCustomerRegisterUseCases =
        BookingCustomerRegisterUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "bookingCustomerRegister",
        arguments: BookingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  Widget _insuranceList(int index) {
    return Padding(
      padding: kPaddingHori24,
      child: InsuranceListWidget(
        insuranceName:
            insuranceBloc.state.data!.insurances![index].insuranceTitle,
        insuranceId: insuranceBloc.state.data!.insurances![index].insuranceId,
        insuranceSubtext:
            insuranceBloc.state.data!.insurances![index].insuranceDetail,
        offerText: insuranceBloc
            .state.data!.insurances![index].promotions?.promotionTextLine1,
        imageUrl: insuranceBloc.state.data!.insurances![index].insuranceImage,
        onTap: () {
          if (getLoginProvider().userType == UserType.loggedInUser) {
            onInsuranceServiceCardClicked(
                insuranceBloc.state.data!.insurances![index].popup!, index);
          } else {
            _showRegisterDialog();
          }
        },
      ),
    );
  }

  _showRegisterDialog() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kSize24),
            topRight: Radius.circular(kSize24),
          ),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.kLight100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kSize24),
                        topRight: Radius.circular(kSize24))),
                child: OtaAlertBottomSheet(
                  leftButtonText:
                      getTranslated(context, AppLocalizationsStrings.cancel),
                  rightButtonText: getTranslated(context,
                      AppLocalizationsStrings.registerPopupRegisterButton),
                  alertText: getTranslated(context,
                      AppLocalizationsStrings.registerToRobinhoodInsurnceAlert),
                  alertTitle: getTranslated(
                      context, AppLocalizationsStrings.registerPopupHeader),
                  onLeftButtonTap: () {
                    Navigator.pop(context);
                  },
                  onRightButtonTap: () {
                    Navigator.pop(context);
                    waitForSuperAppToPushLandingPage();
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget _insuranceHeader(String title) {
    return Padding(
      padding: kPaddingHori24,
      child: Text(
        title,
        style: AppTheme.kHeading1Medium,
        maxLines: headerMaxLine,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void onInsuranceServiceCardClicked(InsurancePopup deepLinkUrl, int index) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSize24),
          topRight: Radius.circular(kSize24),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.kLight100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kSize24),
                      topRight: Radius.circular(kSize24))),
              child: OtaAlertBottomSheet(
                leftButtonText: getTranslated(
                    context, AppLocalizationsStrings.insuranceAlertCancel),
                rightButtonText: getTranslated(
                    context, AppLocalizationsStrings.insuranceAlertOK),
                alertText:
                    insuranceBloc.state.data!.insurances![index].popup!.body!,
                alertTitle: getTranslated(
                    context, AppLocalizationsStrings.insuranceAlertHeader),
                onLeftButtonTap: () {
                  Navigator.pop(context);
                },
                onRightButtonTap: () {
                  if (insuranceBloc
                          .state.data!.insurances![index].popup!.actionType ==
                      actionType) {
                    String url = insuranceBloc
                        .state.data!.insurances![index].popup!.actionUrl!;
                    Navigator.pop(context);
                    _checkUrl(
                        url,
                        insuranceBloc
                            .state.data!.insurances![index].popup!.urlStatus);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _checkUrl(String url, bool? isValid) async {
    final connected = await _isInternetConnected();
    if (connected) {
      if (isValid == null || isValid) {
        Navigator.pushNamed(context, AppRoutes.webViewScreen, arguments: url);
      } else {
        Navigator.pushNamed(context, AppRoutes.insuranceErrorWebViewScreen,
            arguments: _kError1999);
      }
    } else {
      Navigator.pushNamed(context, AppRoutes.insuranceErrorWebViewScreen,
          arguments: _kErrorNetwork);
    }
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  getBottomFooter() {
    return BottomSheet(
      elevation: _kElevation,
      onClosing: () {},
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
              left: kSize24, right: kSize24, top: kSize16, bottom: kSize36),
          height: kSize92,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(
            insuranceBloc.state.data?.insuranceFooterTitle ?? "",
            maxLines: footerMaxLine,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey20),
          ),
        );
      },
    );
  }

  _getTopBar() {
    return InsuranceTopBar(
      statusBarBloc: _statusBarBloc,
      onBackTap: onBackClicked,
    );
  }

  void onBackClicked() {
    NavigatorHelper.shouldSystemPop(context);
  }
}
