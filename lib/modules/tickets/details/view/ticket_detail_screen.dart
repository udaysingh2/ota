import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_detail_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_cover_image.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selection_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_detail_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_favourite_limit_error.dart';
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
import 'package:ota/modules/tickets/details/bloc/ticket_detail_bloc.dart';
import 'package:ota/modules/tickets/details/view/widget/ticket_package_option_view.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view_model/ticket_booking_calendar_argument.dart';
import 'package:ota/modules/tours/details/bloc/tour_card_head_bloc.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/helpers/ota_dialog_helper.dart';
import 'package:ota/modules/tours/package_detail/channels/ota_super_app_to_booking_register.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';

const double _kExpandableMaxHeight = 388.0;
const double _kAppBarHeight = 89;
const double _kDetailsBorder = 24;
const double _kStickyWidgetHeight = 64.0;
const _kTicketIcon = 'assets/images/icons/uil_ticket.svg';
const _kArrowIcon = "assets/images/icons/arrow_gradient_right.svg";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kServiceType = "Ticket";

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({Key? key}) : super(key: key);

  @override
  TicketDetailScreenState createState() => TicketDetailScreenState();
}

class TicketDetailScreenState extends State<TicketDetailScreen> {
  final StatusBarBloc _statusBarBloc = StatusBarBloc();
  final ScrollController _scrollController = ScrollController();
  final TicketDetailBloc _ticketDetailBloc = TicketDetailBloc();
  final HeartButtonController _heartButtonController = HeartButtonController();
  final OtaFavouriteServiceBloc _otaFavouriteServiceBloc =
      OtaFavouriteServiceBloc();
  final OtaSuperAppToRegisterConfirmBooking
      ticketSuperAppToRegisterConfirmBooking =
      OtaSuperAppToRegisterConfirmBooking();
  final TourCardHeadBloc _cardHeadBloc = TourCardHeadBloc();
  TicketDetailArgument? argument;
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
          ModalRoute.of(context)?.settings.arguments as TicketDetailArgument;
      requestTicketData();
      _otaFavouriteServiceBloc.stream.listen((event) {
        _setHeartButtonState();
        _handleProgressHandler();
      });
      _ticketDetailBloc.stream.listen(
        (event) {
          if (_ticketDetailBloc.state.pageState ==
              TicketDetailScreenPageState.internetFailure) {
            OtaNoInternetAlertDialog().showAlertDialog(context);
          }
          if (_ticketDetailBloc.state.pageState ==
                  TicketDetailScreenPageState.success &&
              argument!.userType == TicketDetailUserType.loggedInUser) {
            _otaFavouriteServiceBloc.checkFavorite(
                serviceName: OtaFavouriteServiceType.ticket,
                serviceId: argument!.ticketId);
          }
          if (_ticketDetailBloc.state.pageState ==
              TicketDetailScreenPageState.success) {
            _getAppFlyerData();
            _getFirebaseData();
            _getTicketIdTicketName();
          }
        },
      );
      ticketSuperAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
  }

  Future<void> requestTicketData({bool isRefresh = false}) async {
    await _ticketDetailBloc.getTicketDetail(argument, isRefresh);
  }

  void _openTicketDateSelectionScreen() async {
    var selectedDate = await Navigator.pushNamed(
        context, AppRoutes.otaDateSelectionScreen,
        arguments: argument?.ticketDateTime);
    if (selectedDate != null) {
      final selectedDateTime = selectedDate as DateTime;
      argument?.ticketDate = Helpers.getYYYYmmddFromDateTime(selectedDateTime);
      requestTicketData();
    }
  }

  @override
  void dispose() {
    ticketSuperAppToRegisterConfirmBooking.dispose();
    _scrollController.dispose();
    _ticketDetailBloc.dispose();
    _otaFavouriteServiceBloc.dispose();
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
                        bloc: _ticketDetailBloc,
                        builder: () {
                          return OtaCoverImage(
                            key: const Key("ticketCoverImage"),
                            imageUrl: _ticketDetailBloc.state.data?.imageUrl,
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
                    bloc: _ticketDetailBloc,
                    builder: () {
                      switch (_ticketDetailBloc.state.pageState) {
                        case TicketDetailScreenPageState.loading:
                          return loadIngWidget();
                        case TicketDetailScreenPageState.failure:
                        case TicketDetailScreenPageState.failure1899:
                        case TicketDetailScreenPageState.failure1999:
                        case TicketDetailScreenPageState.internetFailure:
                          return failureState();
                        case TicketDetailScreenPageState.success:
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
        bloc: _ticketDetailBloc,
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
                        statusBarTitle: _ticketDetailBloc.state.data?.name,
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
        return _buildTicketOptionView();
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

  String? _getCategoryLocation() {
    String? text;
    if (_ticketDetailBloc.state.data!.categoryName != null &&
        _ticketDetailBloc.state.data!.locationName != null) {
      text = _ticketDetailBloc.state.data!.categoryName!.addTrailingDot() +
          _ticketDetailBloc.state.data!.locationName!;
    } else if (_ticketDetailBloc.state.data!.categoryName != null) {
      text = _ticketDetailBloc.state.data!.categoryName;
    } else if (_ticketDetailBloc.state.data!.locationName != null) {
      text = _ticketDetailBloc.state.data!.locationName;
    }
    return text;
  }

  Widget _getTicketIcon() {
    return SvgPicture.asset(
      _kTicketIcon,
      height: kSize16,
      width: kSize16,
      fit: BoxFit.contain,
      color: AppColors.kGrey50,
    );
  }

  Widget _getTextView(String text) {
    return Text(
      text,
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget _topDetailSection() {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _ticketDetailBloc.state.data!.name!,
            style: AppTheme.kHeading1Medium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (_getCategoryLocation() != null) const SizedBox(height: kSize4),
          Row(
            children: [
              if (_ticketDetailBloc.state.data!.categoryName != null)
                _getTicketIcon(),
              if (_ticketDetailBloc.state.data!.categoryName != null)
                const SizedBox(width: kSize8),
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
                  getTranslated(context, AppLocalizationsStrings.ticketDetails),
                  style: AppTheme.kButton3,
                  textAlign: TextAlign.center,
                ),
              ),
              OtaIconButton(
                onTap: () {
                  _getActivityClickedFirebase();
                  navigateToTicketDescriptionScreen(
                      _ticketDetailBloc.state.data!.information);
                },
                padding: const EdgeInsets.symmetric(vertical: kSize10),
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

  Widget _buildTicketOptionView() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _ticketDetailBloc.state.data?.promotionData ?? [];
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (freeFoodPromotionList.isNotEmpty)
            OtaFreeFoodBannerWidget(
                freeFoodPromotionList: freeFoodPromotionList),
          if (freeFoodPromotionList.isNotEmpty) const SizedBox(height: kSize24),
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
            selectedDate: Helpers.getddMMMyyyy(argument!.ticketDateTime),
            changeDate: () => _openTicketDateSelectionScreen(),
          ),
        ),
        if (isNotSticky) const SizedBox(height: kSize8),
        if (isNotSticky) _buildDivider(),
        if (isNotSticky) const SizedBox(height: kSize24),
      ],
    );
  }

  Widget _getPackageCardDetail() {
    return _ticketDetailBloc.isPackageEmpty
        ? Padding(
            padding: const EdgeInsets.only(
                bottom: kSize36, left: kSize26, right: kSize26),
            child: OtaSearchNoResultWidget(
              errorTextHeader:
                  getTranslated(context, AppLocalizationsStrings.sorry),
              errorTextFooter: getTranslated(
                  context, AppLocalizationsStrings.noTicketPackageAvailable),
              dividerHeight: kSize16,
              paddingHeight: kSize16,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _ticketDetailBloc.packages.length,
            itemBuilder: (BuildContext context, int index) =>
                TicketPackageOptionView(
              ticketPackage: _ticketDetailBloc.packages[index],
              onReservePress: () {
                LoginModel loginModel = getLoginProvider();

                if (loginModel.userType == UserType.loggedInUser) {
                  final package = _ticketDetailBloc.packages[index];
                  _onReserveClicked(
                      context: context,
                      rateKey: package.packageDetail?.rateKey ?? '',
                      currency: package.packageDetail?.currency ?? '',
                      name: package.packageDetail?.name ?? '',
                      ticketTypes: package.packageDetail!.ticketTypes!,
                      refCode: package.packageDetail!.refCode!,
                      serviceId: package.packageDetail!.serviceId!,
                      zoneId: package.packageDetail!.zoneId!,
                      timeOfDay: package.packageDetail!.timeOfDay!,
                      serviceType: package.packageDetail!.serviceType!,
                      startTime: package.packageDetail!.startTime!,
                      availableSeats: package.packageDetail!.availableSeats!);
                } else {
                  OtaDialogHelper.guestUserDialog(
                    context,
                    getTranslated(
                      context,
                      AppLocalizationsStrings.registerToRobinhoodTicketAlert,
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
          onRefresh: () async => await requestTicketData(isRefresh: true),
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
    _ticketDetailBloc.dispose();
    _otaFavouriteServiceBloc.dispose();
    NavigatorHelper.shouldSystemPop(context, arguments: isDeleted);
    isDeleted = false;
  }

  TicketDetail _getTicketDetail() {
    return TicketDetail(
        serviceId: argument!.ticketId,
        countryId: argument!.countryId,
        cityId: argument!.cityId,
        name: _ticketDetailBloc.state.data!.name!,
        location: _ticketDetailBloc.state.data!.locationName,
        category: _ticketDetailBloc.state.data!.categoryName,
        image: _ticketDetailBloc.state.data!.imageUrl);
  }

  void onHeartClicked() {
    _getHeartFirebaseData();
    if (_otaFavouriteServiceBloc.state.isFavourite) {
      isDeleted = true;
      _otaFavouriteServiceBloc.removeFavorite(
          serviceName: OtaFavouriteServiceType.ticket,
          serviceId: argument!.ticketId);
    } else {
      _otaFavouriteServiceBloc.markFavorite(OtaFavoritesArgumentModel(
          serviceName: OtaFavouriteServiceType.ticket,
          ticketDetail: _getTicketDetail()));
    }
  }

  void onShareClicked() {
    _getShareFirebaseData();
    OtaShareFunction().otaShareClicked(
      serviceType: OtaServiceType.ticket,
      shareText: AppConfig()
          .configModel
          .tourShareTitle
          .replaceAll('{}', _ticketDetailBloc.state.data?.name ?? ''),
      cityId: argument?.cityId,
      countryId: argument?.countryId,
      productId: argument?.ticketId,
    );
  }

  void onGalleryButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.galleryOtaScreen,
        arguments: GalleryArgument(
            serviceName: OtaFavouriteServiceType.ticket,
            serviceId: argument!.ticketId));
  }

  void onReservationDetailsClicked(BuildContext context) async {}

  void _onReserveClicked(
      {required BuildContext context,
      required String rateKey,
      required String currency,
      required String name,
      required String refCode,
      required String serviceId,
      required String zoneId,
      required String timeOfDay,
      required String startTime,
      required String serviceType,
      required int availableSeats,
      required List<TicketTypeData> ticketTypes}) {
    Navigator.pushNamed(
      context,
      AppRoutes.ticketBookingCalenderScreen,
      arguments: TicketBookingCalendarArgument.fromTicketDetailArgument(
          argument: argument!,
          rateKey: rateKey,
          currency: currency,
          refCode: refCode,
          serviceId: serviceId,
          zoneId: zoneId,
          packageName: name,
          timeOfDay: timeOfDay,
          startTime: startTime,
          serviceType: serviceType,
          availableSeats: availableSeats,
          ticketTypeData: ticketTypes),
    );
  }

  void navigateToTicketDescriptionScreen(TicketInformation? information) {
    Navigator.pushNamed(context, AppRoutes.ticketDescriptionScreen,
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
        value: _ticketDetailBloc.state.data?.ticketId);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameter.activityName,
        value: _ticketDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameter.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityViewActivityDetail);
  }

  void _getShareFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityId,
        value: _ticketDetailBloc.state.data?.ticketId);
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityName,
        value: _ticketDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityShareDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityShare);
  }

  void _getHeartFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityId,
        value: _ticketDetailBloc.state.data?.ticketId);
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityName,
        value: _ticketDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityHeartDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityFavorite);
  }

  void _getFirebaseData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityId,
        value: _ticketDetailBloc.state.data?.ticketId);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityName,
        value: _ticketDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: ActivityViewDetailsParameters.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.activityViewDetails);
  }

  void _getAppFlyerData() {
    AppFlyerLogger logger = AppFlyerLogger();
    logger.addKeyValue(
        key: TicketDetailAppFlyer.ticketPlaceId, value: argument?.ticketId);
    logger.addCurrency(key: TicketDetailAppFlyer.ticketCurrency);
    logger.addUserLocation();
    logger.addKeyValue(
        key: TicketDetailAppFlyer.ticketLocation,
        value: _ticketDetailBloc.state.data?.locationName);
    logger.addKeyValue(
        key: TicketDetailAppFlyer.ticketContentId, value: argument?.ticketId);
    logger.addContentType(key: TicketDetailAppFlyer.ticketContentType);
    logger.publishToSuperApp(AppFlyerEvent.ticketDetailEvent);
  }

  void _publishFirebaseViewGalleryData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityId,
        value: argument?.ticketId);
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityName,
        value: _ticketDetailBloc.state.data?.name);
    firebaseLogger.addKeyValue(
        key: TourTicketViewGalleryFirebase.activityService,
        value: _kServiceType);
    firebaseLogger.publishToSuperApp(FirebaseEvent.tourTicketViewGallery);
  }

  void _getTicketIdTicketName() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityId,
        value: _ticketDetailBloc.state.data?.ticketId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityName,
        value: _ticketDetailBloc.state.data?.name);
    FirebaseHelper.addCommaSeparatedList(
        key: ActivitySelectParameter.activityPromotionTag,
        value: _ticketDetailBloc.state.data?.promotionData != null
            ? _ticketDetailBloc.state.data?.promotionData
                .map((e) => e.line1)
                .toList()
            : [],
        eventName: FirebaseEvent.activitySelect);
  }
}
