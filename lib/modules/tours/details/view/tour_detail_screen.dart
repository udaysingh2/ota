import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tours_detail_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_cover_image.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selection_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_detail_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_favourite_limit_error.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_share_function.dart';
import 'package:ota/core_pack/custom_widgets/ota_slider_bottom.dart';
import 'package:ota/core_pack/custom_widgets/ota_slider_top.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_heart_details_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_select_parameter.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_share_details_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_view_activitydetail_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_view_details_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_tickets_view_gallery_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/favourites/bloc/ota_favourite_service_bloc.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_argument_model.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_service_type.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_view_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/tours/details/bloc/tour_card_head_bloc.dart';
import 'package:ota/modules/tours/details/bloc/tour_detail_bloc.dart';
import 'package:ota/modules/tours/details/view/widgets/tour_package_option_view.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_view_model.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/helpers/ota_dialog_helper.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view_model/tour_booking_calendar_argument.dart';
import 'package:ota/modules/tours/package_detail/channels/ota_super_app_to_booking_register.dart';
import 'package:provider/provider.dart';

const double _kExpandableMaxHeight = 388.0;
const double _kAppBarHeight = 89;
const double _kDetailsBorder = 24;
const double _kStickyWidgetHeight = 64.0;
const _kTourIcon = 'assets/images/icons/tour_icon.svg';
const _kArrowIcon = "assets/images/icons/arrow_gradient_right.svg";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kServiceType = 'Tour';

class TourDetailScreen extends StatefulWidget {
  const TourDetailScreen({Key? key}) : super(key: key);

  @override
  TourDetailScreenState createState() => TourDetailScreenState();
}

class TourDetailScreenState extends State<TourDetailScreen> {
  final StatusBarBloc _statusBarBloc = StatusBarBloc();
  final ScrollController _scrollController = ScrollController();
  final TourDetailBloc _tourDetailBloc = TourDetailBloc();
  final HeartButtonController _heartButtonController = HeartButtonController();
  final OtaFavouriteServiceBloc _otaFavouriteServiceBloc =
      OtaFavouriteServiceBloc();
  final OtaSuperAppToRegisterConfirmBooking
      tourSuperAppToRegisterConfirmBooking =
      OtaSuperAppToRegisterConfirmBooking();
  final TourCardHeadBloc _cardHeadBloc = TourCardHeadBloc();
  TourDetailArgument? argument;
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
      _cardHeadBloc.setStatusOnScroll(_scrollController);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseHelper.startCapturingEvent(FirebaseEvent.activitySelect);
      argument =
          ModalRoute.of(context)?.settings.arguments as TourDetailArgument;
      requestTourData();
      _otaFavouriteServiceBloc.stream.listen((event) {
        _setHeartButtonState();
        _handleProgressHandler();
      });
      _tourDetailBloc.stream.listen(
        (event) {
          if (_tourDetailBloc.state.pageState ==
              TourDetailScreenPageState.internetFailure) {
            OtaNoInternetAlertDialog().showAlertDialog(context);
          }
          if (_tourDetailBloc.state.pageState ==
                  TourDetailScreenPageState.success &&
              argument!.userType == TourDetailUserType.loggedInUser) {
            _otaFavouriteServiceBloc.checkFavorite(
                serviceName: OtaFavouriteServiceType.tour,
                serviceId: argument!.tourId);
          }
          if (_tourDetailBloc.state.pageState ==
              TourDetailScreenPageState.success) {
            _getAppFlyerData();
            _getFirebaseData();
            _getTourIdTourName();
          }
        },
      );
      tourSuperAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
  }

  Future<void> requestTourData({bool isRefresh = false}) async {
    _tourDetailBloc.getTourDetail(argument, isRefresh);
  }

  void _openTourDateSelectionScreen() async {
    var selectedDate = await Navigator.pushNamed(
        context, AppRoutes.otaDateSelectionScreen,
        arguments: argument?.tourDateTime);
    if (selectedDate != null) {
      final selectedDateTime = selectedDate as DateTime;
      argument?.tourDate = Helpers.getYYYYmmddFromDateTime(selectedDateTime);
      requestTourData();
    }
  }

  @override
  void dispose() {
    tourSuperAppToRegisterConfirmBooking.dispose();
    _scrollController.dispose();
    _otaFavouriteServiceBloc.dispose();
    _tourDetailBloc.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    NavigatorHelper.shouldSystemPop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final collapsedHeight = _kAppBarHeight - MediaQuery.of(context).padding.top;
    final appBarHeight = _kAppBarHeight + MediaQuery.of(context).padding.top;
    _cardHeadBloc.setDynamicCardHeadOffset(appBarHeight);
    _statusBarBloc.setDynamicCardHeadOffset(collapsedHeight);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        body: Stack(
          children: [
            CustomScrollView(
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
                    background: BlocBuilder(
                        bloc: _tourDetailBloc,
                        builder: () {
                          return OtaCoverImage(
                            key: const Key("tourCoverImage"),
                            imageUrl: _tourDetailBloc.state.data?.imageUrl,
                          );
                        }),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  expandedHeight: _kExpandableMaxHeight,
                  toolbarHeight: collapsedHeight,
                  floating: false,
                  collapsedHeight: collapsedHeight,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: Size.zero,
                    child: OtaSliderBottom(
                      statusBarBloc: _statusBarBloc,
                      detailsBorder: _kDetailsBorder,
                      onGalleryClicked: () {
                        _publishFirebaseViewGalleryData();
                        onGalleryButtonClicked(context);
                      },
                      galleryButtonText: getTranslated(context,
                          AppLocalizationsStrings.galleryTourButtonText),
                    ),
                  ),
                ),
                BlocBuilder(
                    bloc: _tourDetailBloc,
                    builder: () {
                      switch (_tourDetailBloc.state.pageState) {
                        case TourDetailScreenPageState.loading:
                          return loadIngWidget();
                        case TourDetailScreenPageState.failure:
                        case TourDetailScreenPageState.failure1899:
                        case TourDetailScreenPageState.failure1999:
                        case TourDetailScreenPageState.internetFailure:
                          return failureState();
                        case TourDetailScreenPageState.success:
                          return successWidget();
                        default:
                          return defaultWidget();
                      }
                    }),
              ],
            ),
            getSliderTop(),
            getCardHeadSelectedDate(false),
          ],
        ),
      ),
    );
  }

  Widget getCardHeadSelectedDate(bool isNotSticky) {
    return BlocBuilder(
        bloc: _cardHeadBloc,
        builder: () {
          if (_cardHeadBloc.state.cardHeadBlocState ==
              TourCardHeadBlocState.sticky) {
            return const SizedBox();
          }
          return Container(
              color: AppColors.kLight100,
              height: _kStickyWidgetHeight,
              margin: const EdgeInsets.only(top: _kAppBarHeight),
              child: _buildSelectDate(isNotSticky));
        });
  }

  Widget getSliderTop() {
    return BlocBuilder(
        bloc: _tourDetailBloc,
        builder: () {
          return BlocBuilder(
              bloc: _statusBarBloc,
              builder: () {
                return BlocBuilder(
                    bloc: _otaFavouriteServiceBloc,
                    builder: () {
                      return OtaSliderTop(
                        statusBarBloc: _statusBarBloc,
                        onBackClicked: onBackClicked,
                        onHeartClicked: onHeartClicked,
                        onShareClicked: onShareClicked,
                        heartButtonController: _heartButtonController,
                        statusBarTitle: _tourDetailBloc.state.data?.name,
                      );
                    });
              });
        });
  }

  _handleProgressHandler() {
    switch (_otaFavouriteServiceBloc.state.pageState) {
      case FavoritePageState.loading:
        OtaDialogLoader().showLoader(context);
        break;
      case FavoritePageState.addFavouriteFailure:
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.addFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
        break;
      case FavoritePageState.addfavouriteInternetFailure:
      case FavoritePageState.unfavouriteInternetFailure:
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
        break;
      case FavoritePageState.unFavoriteFailure:
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
        break;
      case FavoritePageState.failureMaxLimit:
        OtaDialogLoader().hideLoader(context);
        OtaFavoriteMaxLimitError().showErrorDialog(
          context,
        );
        break;
      case FavoritePageState.none:
        OtaDialogLoader().hideLoader(context);
        break;
      default:
        OtaDialogLoader().hideLoader(context);
        break;
    }
  }

  Widget defaultWidget() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return const SizedBox(
          height: 600,
        );
      },
      childCount: 1,
    ));
  }

  Widget loadIngWidget() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return const OTALoadingIndicator();
      },
      childCount: 1,
    ));
  }

  Widget successWidget() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (index == 2) {
        return _buildTourOptionView();
      } else if (index == 1) {
        return BlocBuilder(
            bloc: _cardHeadBloc,
            builder: () {
              if (_cardHeadBloc.state.cardHeadBlocState !=
                  TourCardHeadBlocState.sticky) {
                return const SizedBox(
                  height: _kStickyWidgetHeight + kSize24,
                );
              } else {
                return _buildSelectDate(true);
              }
            });
      } else {
        return _topDetailSection();
      }
    }, childCount: 3));
  }

  Widget _buildDivider() {
    return const OtaHorizontalDivider(
      dividerColor: AppColors.kGreyLineStroke,
    );
  }

  Widget _getTourIcon() {
    return SvgPicture.asset(
      _kTourIcon,
      height: kSize16,
      width: kSize16,
      fit: BoxFit.contain,
      color: AppColors.kGrey50,
    );
  }

  Widget _getTextView(String text) {
    return Text(
      text,
      style: AppTheme.kSmall1,
    );
  }

  String? _getCategoryLocation() {
    String? text;
    if (_tourDetailBloc.state.data!.categoryName != null &&
        _tourDetailBloc.state.data!.locationName != null) {
      text = _tourDetailBloc.state.data!.categoryName!.addTrailingDot() +
          _tourDetailBloc.state.data!.locationName!;
    } else if (_tourDetailBloc.state.data!.categoryName != null) {
      text = _tourDetailBloc.state.data!.categoryName;
    } else if (_tourDetailBloc.state.data!.locationName != null) {
      text = _tourDetailBloc.state.data!.locationName;
    }
    return text;
  }

  Widget _topDetailSection() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _tourDetailBloc.state.data!.name!,
            style: AppTheme.kHeading1Medium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_getCategoryLocation() != null) const SizedBox(height: kSize4),
          Row(
            children: [
              if (_tourDetailBloc.state.data!.categoryName != null)
                _getTourIcon(),
              if (_tourDetailBloc.state.data!.categoryName != null)
                const SizedBox(width: kSize4),
              if (_getCategoryLocation() != null)
                _getTextView(_getCategoryLocation()!),
            ],
          ),
          const SizedBox(height: kSize16),
          Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.gradient1
                      .createShader(Offset.zero & bounds.size);
                },
                child: Text(
                  getTranslated(
                      context, AppLocalizationsStrings.activityDetail),
                  style: AppTheme.kButton3,
                  textAlign: TextAlign.center,
                ),
              ),
              OtaIconButton(
                padding: const EdgeInsets.symmetric(vertical: kSize10),
                onTap: () {
                  _getActivityClickedFirebase();
                  navigateToTourDescriptionScreen(
                      _tourDetailBloc.state.data!.information);
                },
                icon: SvgPicture.asset(
                  _kArrowIcon,
                  fit: BoxFit.none,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
          const SizedBox(height: kSize24),
        ],
      ),
    );
  }

  Widget _buildTourOptionView() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_tourDetailBloc.state.data?.promotionData != null &&
              _tourDetailBloc.state.data!.promotionData.isNotEmpty) ...[
            OtaFreeFoodBannerWidget(
              freeFoodPromotionList: _tourDetailBloc.state.data!.promotionData,
            ),
            const SizedBox(height: kSize24),
          ],
          Text(
            getTranslated(context, AppLocalizationsStrings.packageOptions),
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(height: kSize16),
          _getPackageCardDetail(),
          const SizedBox(height: kSize8),
        ],
      ),
    );
  }

  Widget _buildSelectDate(bool isNotSticky) {
    return Column(
      children: [
        if (!isNotSticky)
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey4),
        if (isNotSticky) _buildDivider(),
        Padding(
          padding: kPaddingHori24,
          child: OtaDateSelectionWidget(
            padding: isNotSticky
                ? const EdgeInsets.only(top: kSize15, bottom: kSize8)
                : const EdgeInsets.symmetric(vertical: kSize8),
            selectedDate: Helpers.getddMMMyyyy(argument!.tourDateTime),
            changeDate: () => _openTourDateSelectionScreen(),
          ),
        ),
        if (isNotSticky) const SizedBox(height: kSize8),
        if (isNotSticky) _buildDivider(),
        if (isNotSticky) const SizedBox(height: kSize24),
      ],
    );
  }

  Widget _getPackageCardDetail() {
    return _tourDetailBloc.isPackagesEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: kSize26),
            child: OtaSearchNoResultWidget(
              errorTextHeader:
                  getTranslated(context, AppLocalizationsStrings.sorry),
              errorTextFooter: getTranslated(
                  context, AppLocalizationsStrings.noTourPackageAvailable),
              dividerHeight: kSize16,
              paddingHeight: kSize16,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _tourDetailBloc.packages.length,
            itemBuilder: (BuildContext context, int index) =>
                TourPackageOptionView(
              tourPackage: _tourDetailBloc.packages[index],
              onReservePress: () {
                LoginModel loginModel = Provider.of<LoginModel>(
                    GlobalKeys.navigatorKey.currentContext!,
                    listen: false);
                if (loginModel.userType == UserType.loggedInUser) {
                  final package = _tourDetailBloc.packages[index];
                  _onReserveClicked(
                      context,
                      package.packageDetail?.rateKey ?? '',
                      package.packageDetail?.currency ?? '',
                      package.packageDetail?.name ?? '',
                      package.packageDetail?.adultPrice ?? 0,
                      package.packageDetail?.childPrice ?? 0,
                      package.packageDetail?.serviceCategory ?? "",
                      package.packageDetail?.serviceId ?? "",
                      package.packageDetail?.zoneId ?? "",
                      package.packageDetail?.availableSeats ?? 0,
                      package.packageDetail?.minimumSeats ?? 0,
                      package.packageDetail?.timeOfDay ?? "",
                      package.packageDetail?.startTime ?? "",
                      package.packageDetail?.refCode ?? " ");
                } else {
                  OtaDialogHelper.guestUserDialog(
                    context,
                    getTranslated(
                      context,
                      AppLocalizationsStrings.registerToRobinhoodTourAlert,
                    ),
                  );
                }
              },
            ),
          );
  }

  Widget failureState() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return OtaDetailErrorWidget(
          height: MediaQuery.of(context).size.height -
              _kExpandableMaxHeight +
              _kDetailsBorder,
          onRefresh: () async => await requestTourData(isRefresh: true),
        );
      },
      childCount: 1,
    ));
  }

  void _setHeartButtonState() {
    if (_otaFavouriteServiceBloc.state.isFavourite) {
      _heartButtonController.setSelected();
    } else {
      _heartButtonController.setUnselected();
    }
  }

  void onBackClicked() {
    _otaFavouriteServiceBloc.dispose();
    _tourDetailBloc.dispose();
    NavigatorHelper.shouldSystemPop(context, arguments: isDeleted);
    isDeleted = false;
  }

  void onHeartClicked() {
    _getHeartFirebaseData();
    if (_otaFavouriteServiceBloc.state.isFavourite) {
      isDeleted = true;
      _otaFavouriteServiceBloc.removeFavorite(
          serviceName: OtaFavouriteServiceType.tour,
          serviceId: argument!.tourId);
    } else {
      _otaFavouriteServiceBloc.markFavorite(OtaFavoritesArgumentModel(
          serviceName: OtaFavouriteServiceType.tour,
          tourDetail: _getTourDetail()));
    }
  }

  TourDetail _getTourDetail() {
    return TourDetail(
        serviceId: argument!.tourId,
        countryId: argument!.countryId,
        cityId: argument!.cityId,
        name: _tourDetailBloc.state.data!.name!,
        location: _tourDetailBloc.state.data!.locationName,
        category: _tourDetailBloc.state.data!.categoryName,
        image: _tourDetailBloc.state.data!.imageUrl);
  }

  void onShareClicked() {
    _getShareFirebaseData();
    OtaShareFunction().otaShareClicked(
      serviceType: OtaServiceType.activity,
      shareText: AppConfig()
          .configModel
          .tourShareTitle
          .replaceAll('{}', _tourDetailBloc.state.data?.name ?? ''),
      cityId: argument?.cityId,
      countryId: argument?.countryId,
      productId: argument?.tourId,
    );
  }

  void onGalleryButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.galleryOtaScreen,
        arguments: GalleryArgument(
            serviceName: OtaFavouriteServiceType.tour,
            serviceId: argument!.tourId));
  }

  void _onReserveClicked(
    BuildContext context,
    String rateKey,
    String currency,
    String name,
    double adultPrice,
    double childPrice,
    String serviceCategory,
    String serviceId,
    String zoneId,
    int availableSeats,
    int minimumSeats,
    String timeOfDay,
    String startTime,
    String refCode,
  ) {
    Navigator.pushNamed(
      context,
      AppRoutes.otaBookingCalenderScreen,
      arguments: TourBookingCalendarArgument.fromTourDetailArgument(
          argument!,
          rateKey,
          currency,
          name,
          adultPrice,
          childPrice,
          serviceCategory,
          serviceId,
          zoneId,
          availableSeats,
          minimumSeats,
          timeOfDay,
          startTime,
          refCode),
    );
  }

  void onReservationDetailsClicked(BuildContext context) async {}

  void navigateToTourDescriptionScreen(TourInformation? information) {
    Navigator.pushNamed(context, AppRoutes.tourDescriptionScreen,
        arguments: information);
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

  void _getActivityClickedFirebase() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameter.activityId,
        value: _tourDetailBloc.state.data?.tourId);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameter.activityName,
        value: _tourDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameter.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityViewActivityDetail);
  }

  void _getShareFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityId,
        value: _tourDetailBloc.state.data?.tourId);
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityName,
        value: _tourDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityShare);
  }

  void _getHeartFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityId,
        value: _tourDetailBloc.state.data?.tourId);
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityName,
        value: _tourDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityFavorite);
  }

  void _getFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityId,
        value: _tourDetailBloc.state.data?.tourId);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityName,
        value: _tourDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityViewDetails);
  }

  void _getAppFlyerData() {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: TourDetailAppFlyer.tourPlaceId, value: argument?.tourId);
    logger.addCurrency(key: TourDetailAppFlyer.tourCurrency);
    logger.addUserLocation();
    logger.addKeyValue(
        key: TourDetailAppFlyer.tourLocation,
        value: _tourDetailBloc.state.data?.locationName);
    logger.addKeyValue(
        key: TourDetailAppFlyer.tourContentId, value: argument?.tourId);
    logger.addContentType(key: TourDetailAppFlyer.tourContentType);
    logger.publishToSuperApp(AppFlyerEvent.tourDetailEvent);
  }

  void _publishFirebaseViewGalleryData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityId, value: argument?.tourId);
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityName,
        value: _tourDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.tourTicketViewGallery);
  }

  void _getTourIdTourName() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityId,
        value: _tourDetailBloc.state.data?.tourId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityName,
        value: _tourDetailBloc.state.data?.name);
    FirebaseHelper.addCommaSeparatedList(
        key: ActivitySelectParameter.activityPromotionTag,
        value: _tourDetailBloc.state.data?.promotionData != null
            ? _tourDetailBloc.state.data?.promotionData
                .map((e) => e.line1)
                .toList()
            : [],
        eventName: FirebaseEvent.activitySelect);
  }
}
