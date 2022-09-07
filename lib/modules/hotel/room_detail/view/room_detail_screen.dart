import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_room_promotion_widget/ota_room_special_promotion_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/card_head_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_image_slider.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_slider_bottom.dart';
import 'package:ota/modules/hotel/room_detail/bloc/room_detail_bloc.dart';
import 'package:ota/modules/hotel/room_detail/channels/super_app_to_booking_register.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_controller.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/hotel_room_bottom_widget.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/hotel_room_detail_slider_top.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/hotel_room_facility.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_detail_error_widget.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_info_widget.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_argument_model.dart';

import '../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';

const String formNextLine = '\n';
const double _kAppBarHeight = 89;
const int roundingOff = 2;
const double _kExpandableMaxHeight = 387.0;
const double _kDetailsBorder = 24;
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({Key? key}) : super(key: key);

  @override
  RoomDetailScreenState createState() => RoomDetailScreenState();
}

class RoomDetailScreenState extends State<RoomDetailScreen> {
  final CancellationPolicyController _cancellationPolicyController =
      CancellationPolicyController();
  final RoomDetailViewBloc roomDetailViewBloc = RoomDetailViewBloc();
  RoomDetailArgument? argument;
  final SuperAppToRegisterConfirmBooking superAppToRegisterConfirmBooking =
      SuperAppToRegisterConfirmBooking();
  final StatusBarBloc _statusBarBloc = StatusBarBloc();
  final ScrollController _scrollController = ScrollController();
  final CardHeadBloc _cardHeadBloc = CardHeadBloc();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    superAppToRegisterConfirmBooking.dispose();
    super.dispose();
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
      _cardHeadBloc.setStatusOnScroll(_scrollController);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument =
          ModalRoute.of(context)?.settings.arguments as RoomDetailArgument;
      requestRoomData();
      superAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );

      roomDetailViewBloc.stream.listen((event) {
        if (roomDetailViewBloc.state.pageState ==
            RoomDetailViewPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
    });
  }

  Future<void> requestRoomData({bool isRefresh = false}) async {
    roomDetailViewBloc.getRoomDetail(argument, isRefresh);
  }

  Widget _getFacilityDetail(BuildContext context) {
    List<String>? roomFacilities =
        roomDetailViewBloc.state.data?.roomFacilities;
    if (roomFacilities != null && roomFacilities.isNotEmpty) {
      return BlocBuilder(
        bloc: roomDetailViewBloc,
        builder: () {
          return HotelRoomFacility(
              facilityList: roomDetailViewBloc.state.data?.roomFacilities);
        },
      );
    }
    return const SizedBox.shrink();
  }

  void _setCancellationPolicyState() {
    switch (roomDetailViewBloc.state.data?.roomDetailCancellationPolicyType) {
      case RoomDetailCancellationPolicyType.freeCancellation:
        _cancellationPolicyController.setfreeCancellation();
        break;
      case RoomDetailCancellationPolicyType.conditionalCancellation:
        _cancellationPolicyController.setconditionalCancellation();
        break;
      default:
        _cancellationPolicyController.setnonRefundable();
        break;
    }
  }

  Widget _getCancellationPolicy(BuildContext context) {
    return BlocBuilder(
      bloc: roomDetailViewBloc,
      builder: () {
        _setCancellationPolicyState();
        return CancellationPolicy(
          cancellationPolicyController: _cancellationPolicyController,
          cancellationPolicyModel:
              roomDetailViewBloc.state.data?.cancellationPolicies,
        );
      },
    );
  }

  Widget _getRoomInfo(BuildContext context) {
    return BlocBuilder(
      bloc: roomDetailViewBloc,
      builder: () {
        return HotelRoomDetailInfoWidget(
          roomType: roomDetailViewBloc.state.data?.roomType,
          facilityList: roomDetailViewBloc.state.data?.facilityList ?? [],
          roomList: roomDetailViewBloc.state.data?.roomList,
        );
      },
    );
  }

  Widget getHotelSliderTop() {
    return BlocBuilder(
      bloc: roomDetailViewBloc,
      builder: () {
        return HotelSliderTop(
          statusBarBloc: _statusBarBloc,
          isRemoveOval: !roomDetailViewBloc.isRoomImageAvailable,
          onBackClicked: onBackClicked,
          statusBarTitle: roomDetailViewBloc.state.data?.roomType,
        );
      },
    );
  }

  void onBackClicked() {
    printDebug("onBackClicked");
    NavigatorHelper.shouldSystemPop(context);
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return true;
  }

  Widget _getSpecialPromotion(BuildContext context) {
    List<OtaPromotionModel> specialPromotions =
        roomDetailViewBloc.state.data?.specialPromotionDetailList ?? [];
    return specialPromotions.isNotEmpty
        ? OtaRoomSpecialPromotionWidget(
            header: getTranslated(
                context, AppLocalizationsStrings.specialPromotion),
            specialPromotionList: specialPromotions,
            bottomDetail: getTranslated(
                context, AppLocalizationsStrings.promotionTNCroom),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: customScrollView(),
    );
  }

  Widget customScrollView() {
    final collapsedHeight = _kAppBarHeight - MediaQuery.of(context).padding.top;
    _statusBarBloc.setDynamicCardHeadOffset(collapsedHeight);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              BlocBuilder(
                bloc: roomDetailViewBloc,
                builder: () {
                  return SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarBrightness:
                          Platform.isIOS ? Brightness.light : Brightness.dark,
                      statusBarIconBrightness:
                          Platform.isIOS ? Brightness.light : Brightness.dark,
                    ),
                    flexibleSpace: roomDetailViewBloc.isRoomImageAvailable
                        ? FlexibleSpaceBar(
                            background: HotelImageSlider(
                              key: const Key("coverImage"),
                              imageUrl: [
                                roomDetailViewBloc.state.data?.roomImage ?? ''
                              ],
                              sliderHeight:
                                  _kExpandableMaxHeight + kToolbarHeight,
                              pageController: _pageController,
                            ),
                          )
                        : const SizedBox.shrink(),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    expandedHeight: roomDetailViewBloc.isRoomImageAvailable
                        ? _kExpandableMaxHeight
                        : kSize0,
                    toolbarHeight: collapsedHeight,
                    floating: false,
                    collapsedHeight: collapsedHeight,
                    pinned: true,
                    shadowColor: AppColors.kShadowAppBar,
                    bottom: PreferredSize(
                      preferredSize: Size.zero,
                      child: roomDetailViewBloc.isRoomImageAvailable
                          ? HotelSliderBottom(
                              pageController: _pageController,
                              statusBarBloc: _statusBarBloc,
                              sliderItemCount: 4,
                              detailsBorder: _kDetailsBorder,
                              onGalleryClicked: () =>
                                  onGalleryButtonClicked(context),
                              galleryButtonText: getTranslated(context,
                                  AppLocalizationsStrings.galleryButtonText),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                },
              ),
              BlocBuilder(
                bloc: roomDetailViewBloc,
                builder: () {
                  switch (roomDetailViewBloc.state.pageState) {
                    case RoomDetailViewPageState.loading:
                      return warpInSliverList(loadIngWidget());
                    case RoomDetailViewPageState.failure:
                    case RoomDetailViewPageState.internetFailure:
                      return warpInSliverList(failureState());
                    case RoomDetailViewPageState.success:
                      return warpInSliverList(successWidget());
                    default:
                      return warpInSliverList(defaultWidget());
                  }
                },
              ),
            ],
          ),
          BlocBuilder(
            bloc: roomDetailViewBloc,
            builder: () {
              if (roomDetailViewBloc.state.pageState ==
                  RoomDetailViewPageState.success) {
                return HotelRoomBottomWidget(
                  argument: argument!,
                  roomDetailViewBloc: roomDetailViewBloc,
                  waitForSuperAppToPushLandingPage:
                      waitForSuperAppToPushLandingPage,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          getHotelSliderTop(),
        ],
      ),
    );
  }

  void onGalleryButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.roomGalleryScreen,
        arguments: RoomGalleryArgumentModel(
            hotelId: argument?.hotelId ?? '',
            roomId: argument?.roomCode ?? ''));
  }

  Widget successWidget() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _getRoomInfo(context),
        const Padding(
            padding: EdgeInsets.only(top: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10)),
        _getSpecialPromotion(context),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        _getFacilityDetail(context),
        _getCancellationPolicy(context),
        SizedBox(height: kSize120 + MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  Widget failureState() {
    return RoomDetailErrorWidget(
      height: MediaQuery.of(context).size.height -
          _kExpandableMaxHeight +
          _kDetailsBorder,
      onRefresh: () async => await requestRoomData(isRefresh: true),
    );
  }

  Widget loadIngWidget() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      child: const OTALoadingIndicator(),
    );
  }

  Widget warpInSliverList(Widget child) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return child;
        },
        childCount: 1,
      ),
    );
  }

  Widget defaultWidget() {
    return const SizedBox();
  }
}
