import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_detail_click_hotel_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_detail_view_hotel_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_success_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_view_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_review_reservation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_share_function.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_booking_review_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_favorite_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_roomselect_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_share_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_view_room_details.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_viewdetails_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_viewfacility_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_viewgallery_parameter.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/card_head_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_detail_interest_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_detail_view_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/hotel_favorites_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/channels/super_app_to_booking_register.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/accomodation_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/card_head_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/heart_button/heart_button_controller.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_detail_error_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_favorite_limit_error.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_image_slider.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_info_section.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_slider_bottom.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_slider_top.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/primary_hotel_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/suggetion_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_interest_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_favorites_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/primary_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/suggetion_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:provider/provider.dart';

import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';

const double _kExpandableMaxHeight = 387.0;
const double _kAppBarHeight = 93.0;
const double _kDetailsBorder = 24.0;
const double _kStickyWidgetHeight = 60.0;
const int _kFooterCount = 1;
const int _kHeaderCount = 1;
const String _kServiceNameHotel = "HOTEL";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const int _kDefaultValue = 0;

class HotelDetailView extends StatefulWidget {
  const HotelDetailView({Key? key}) : super(key: key);

  @override
  HotelDetailViewState createState() => HotelDetailViewState();
}

class HotelDetailViewState extends State<HotelDetailView> {
  final PageController _pageController = PageController();
  final StatusBarBloc _statusBarBloc = StatusBarBloc();
  final ScrollController _scrollController = ScrollController();
  final CardHeadBloc _cardHeadBloc = CardHeadBloc();
  final HeartButtonController _heartButtonController = HeartButtonController();
  final HotelDetailViewBloc _hotelDetailViewBloc = HotelDetailViewBloc();
  final HotelFavoritesBloc _hotelFavoritesBloc = HotelFavoritesBloc();
  final HotelDetailInterestBloc _hotelDetailInterestBloc =
      HotelDetailInterestBloc();
  HotelDetailArgument? argument;
  final SuperAppToRegisterConfirmBooking superAppToRegisterConfirmBooking =
      SuperAppToRegisterConfirmBooking();
  String url = getLoginProvider().getLanguage() == "EN"
      ? AppConfig().configModel.freeFoodDeliveryUrlHotel
      : AppConfig().configModel.freeFoodDeliveryUrlHotelTh;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
      _cardHeadBloc.setStatusOnScroll(_scrollController);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelRoomSelect);
      FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelViewRoomDetails);
      FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelViewFacility);
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.hotelReservationEvent);
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.hotelPaymentEvent);
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.hotelPaymentSuccessEvent);
      AppFlyerHelper.startCapturingEvent(
          AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent);
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.hoteldetailClickEvent);
      AppFlyerHelper.startCapturingEvent(AppFlyerEvent.hotelPaymentViewEvent);
      FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelBookingReview);

      superAppToRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
      argument =
          ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;

      _hotelDetailViewBloc.stream.listen(
        (event) {
          if (_hotelDetailViewBloc.state.pageState ==
              HotelDetailViewPageState.internetFailure) {
            OtaNoInternetAlertDialog().showAlertDialog(context);
          } else if (_hotelDetailViewBloc.state.pageState ==
              HotelDetailViewPageState.success) {
            _getAppFlyerData();
          }
          if (_hotelDetailViewBloc.state.pageState ==
              HotelDetailViewPageState.success) {
            _getHotelIdFirebase();
            _getAppFlyer();
            _getViewFirebase();
            _getViewFacilityFirebase();
            _getHotelRoomSelect();
            getCapsulePromotions(FirebaseEvent.hotelBookingReview,
                _hotelDetailViewBloc.state.data?.freeFoodPromotions);
          }
        },
      );

      requestHotelData();
      requestSuggestionsData();
      checkFavourite(_kServiceNameHotel, argument?.hotelId ?? "");
      _hotelFavoritesBloc.stream.listen((event) {
        _setHeartButtonState();
        _handleUnFavouriteProgressHandler();
        _handleFavouriteProgressHandler();
      });
      Provider.of<HotelDetailStatus>(context, listen: false).addListener(() {
        requestHotelData();
        requestSuggestionsData();
      });
    });
  }

  Future<void> requestSuggestionsData({bool isRefresh = false}) async {
    _hotelDetailInterestBloc.getInterests(argument);
  }

  void _setHeartButtonState() {
    switch (argument?.userType) {
      case HotelDetailUserType.guestUser:
        _heartButtonController.setDisabled();
        break;
      case HotelDetailUserType.loggedInUser:
        if (_hotelFavoritesBloc.state.heartButtonType ==
            HotelDetailHeartButtonType.selected) {
          _heartButtonController.setSelected();
        } else {
          _heartButtonController.setUnselected();
        }
        break;
      default:
        _heartButtonController.setDisabled();
        break;
    }
  }

  Future<void> requestHotelData({bool isRefresh = false}) async {
    _hotelDetailViewBloc.getHotelDetail(argument, isRefresh);
  }

  Future<void> checkFavourite(String type, String hotelId) async {
    _hotelFavoritesBloc.checkFavorites(type, hotelId);
  }

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
                        bloc: _hotelDetailViewBloc,
                        builder: () {
                          return HotelImageSlider(
                            key: const Key("coverImage"),
                            imageUrl: [
                              _hotelDetailViewBloc.state.data?.coverImageUrl ??
                                  ""
                            ],
                            sliderHeight:
                                _kExpandableMaxHeight + kToolbarHeight,
                            pageController: _pageController,
                          );
                        }),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  expandedHeight: _kExpandableMaxHeight,
                  toolbarHeight: collapsedHeight,
                  floating: false,
                  shadowColor: AppColors.kShadowAppBar,
                  collapsedHeight: collapsedHeight,
                  pinned: true,
                  bottom: PreferredSize(
                    preferredSize: Size.zero,
                    child: HotelSliderBottom(
                      pageController: _pageController,
                      statusBarBloc: _statusBarBloc,
                      sliderItemCount: 4,
                      detailsBorder: _kDetailsBorder,
                      onGalleryClicked: () => onGalleryButtonClicked(context),
                      galleryButtonText: getTranslated(
                          context, AppLocalizationsStrings.galleryButtonText),
                    ),
                  ),
                ),
                BlocBuilder(
                    bloc: _hotelDetailViewBloc,
                    builder: () {
                      switch (_hotelDetailViewBloc.state.pageState) {
                        case HotelDetailViewPageState.loading:
                          return loadIngWidget();
                        case HotelDetailViewPageState.failure:
                        case HotelDetailViewPageState.internetFailure:
                          return failureState();
                        case HotelDetailViewPageState.success:
                          return successWidget(context);
                        case HotelDetailViewPageState.noRoomData:
                          return emptyRoom(context);
                        default:
                          return defaultWidget();
                      }
                    })
              ],
            ),
            getHotelSliderTop(),
            getCardHeadCalenderWidget(true, context),
          ],
        ),
      ),
    );
  }

  _handleUnFavouriteProgressHandler() {
    switch (_hotelFavoritesBloc.state.unFavoriteHotelState) {
      case UnFavoriteHotelState.loading:
        OtaDialogLoader().showLoader(context);
        break;
      case UnFavoriteHotelState.failure:
        _hotelFavoritesBloc.updateUnfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
        break;
      case UnFavoriteHotelState.success:
        _hotelFavoritesBloc.updateUnfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        break;
      case UnFavoriteHotelState.internetFailure:
        _hotelFavoritesBloc.updateUnfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
        break;
      default:
        OtaDialogLoader().hideLoader(context);
        break;
    }
  }

  _handleFavouriteProgressHandler() {
    switch (_hotelFavoritesBloc.state.addFavoriteHotelState) {
      case AddFavoriteHotelState.loading:
        OtaDialogLoader().showLoader(context);
        break;
      case AddFavoriteHotelState.failure:
        _hotelFavoritesBloc.updateAddfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.addFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
        break;
      case AddFavoriteHotelState.failureMaxLimit:
        OtaDialogLoader().hideLoader(context);
        _hotelFavoritesBloc.updateAddfavouritesHotelState();
        HotelFavoriteMaxLimitError().showErrorDialog(context);
        break;
      case AddFavoriteHotelState.success:
        _hotelFavoritesBloc.updateAddfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        break;
      case AddFavoriteHotelState.internetFailure:
        _hotelFavoritesBloc.updateUnfavouritesHotelState();
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
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
        return const SizedBox();
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

  Widget failureState() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return HotelDetailErrorWidget(
          height: MediaQuery.of(context).size.height -
              _kExpandableMaxHeight +
              _kDetailsBorder,
          onRefresh: () async {
            await requestHotelData(isRefresh: true);
            requestSuggestionsData();
          },
        );
      },
      childCount: 1,
    ));
  }

  Widget emptyRoom(BuildContext context) {
    _setHeartButtonState();
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (index == 0) {
        return getDetailListingWidget(context);
      } else if (index == 1) {
        return OtaNoMatchingResultWidget(
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
        );
      } else {
        return _getFooterDetailView(context);
      }
    }, childCount: 3));
  }

  Widget successWidget(BuildContext context) {
    _setHeartButtonState();
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (index == 0) {
        return getDetailListingWidget(context);
      } else if (index == _getFooterIndex()) {
        return _getFooterDetailView(context);
      } else {
        _getClickData();
        return _getPrimaryViewAtIndex(index);
      }
    }, childCount: _getTotalChildCount()));
  }

  //Get the total child count
  //Child will consist of Detail listing, footer view and dynamic value of primary hotels
  int _getTotalChildCount() {
    return _kFooterCount + _kHeaderCount + _getPrimaryHotelCount();
  }

  int _getPrimaryHotelCount() {
    return _getPrimaryView().length;
  }

//To get footer index subtract _kHeaderCount
  int _getFooterIndex() {
    return _getTotalChildCount() - _kHeaderCount;
  }

  //To get primary index subtract _kHeaderCount
  int _getPrimaryIndex(int index) {
    return index - _kHeaderCount;
  }

  Widget _getPrimaryViewAtIndex(int index) {
    return _getPrimaryView().elementAt(_getPrimaryIndex(index));
  }

  List<PrimaryHotelView> _getPrimaryView() {
    List<PrimaryViewModel>? roomList =
        _hotelDetailViewBloc.state.data?.roomList;
    if (roomList != null && roomList.isNotEmpty) {
      return List<PrimaryHotelView>.generate(
          roomList.length,
          (index) =>
              PrimaryHotelView(primaryViewModel: roomList.elementAt(index)));
    }
    return [];
  }

  Widget _getFooterDetailView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_hotelDetailViewBloc.state.data?.isFacilityShown ?? false)
          const SizedBox(height: kSize16),
        if (_hotelDetailViewBloc.state.data?.isFacilityShown ?? false)
          FacilityView(
            facilityList: _hotelDetailViewBloc.state.data?.facilityList,
            facilityMain: _hotelDetailViewBloc.state.data?.facilityMain,
          ),
        if (_hotelDetailViewBloc.state.data?.isFacilityShown ?? false)
          const Padding(
              padding:
                  EdgeInsets.only(top: kSize16, left: kSize24, right: kSize24),
              child: OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
              )),
        AccommodationWidget(address: _hotelDetailViewBloc.state.data?.address),
        BlocBuilder(
            bloc: _hotelDetailInterestBloc,
            builder: () {
              if (_hotelDetailInterestBloc.state.viewState ==
                      HotelDetailInterestViewModelState.success &&
                  _hotelDetailInterestBloc.state.listOfInterest != null &&
                  _hotelDetailInterestBloc.state.listOfInterest!.isNotEmpty) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          bottom: kSize24, left: kSize24, right: kSize24),
                      child: OtaHorizontalDivider(
                        dividerColor: AppColors.kGrey10,
                      ),
                    ),
                    SuggetionWidget(
                      suggetionList:
                          _hotelDetailInterestBloc.state.listOfInterest!,
                      onTap: (SuggetionViewModel suggestion) {
                        if (argument == null) return;
                        Navigator.pushNamed(
                          context,
                          AppRoutes.hotelDetail,
                          arguments: HotelDetailArgument
                              .fromHotelDetailArgumentAndSuggetions(
                                  hotelDetailDataArgument: argument!,
                                  suggetionViewModel: suggestion),
                        );
                      },
                    ),
                  ],
                );
              }
              return const SizedBox();
            }),
        const SizedBox(
          height: kSize24,
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: kPaddingHori24,
      child: Text(
        getTranslated(context, AppLocalizationsStrings.roomTypes),
        style: AppTheme.kHeading1Medium,
      ),
    );
  }

  Widget buildPromotionBanner() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _hotelDetailViewBloc.state.data?.freeFoodPromotions ?? [];
    return freeFoodPromotionList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: OtaFreeFoodBannerWidget(
                freeFoodPromotionList: freeFoodPromotionList),
          )
        : const SizedBox.shrink();
  }

  Widget getDetailListingWidget(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kLight100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelInfoSection(
            key: const Key("hotel-info"),
            statusBarBloc: _statusBarBloc,
            addressText: _hotelDetailViewBloc.state.data?.shortAddress ?? "",
            headerText: _hotelDetailViewBloc.state.data?.name ?? "",
            ratingButtonText:
                getTranslated(context, AppLocalizationsStrings.seeAllReviews),
            ratingIndexDescriptionText:
                _hotelDetailViewBloc.state.data?.ratingMessage ?? "",
            ratingIndexText:
                _hotelDetailViewBloc.state.data?.overAllRating.toString() ?? "",
            ratingText: _hotelDetailViewBloc.state.data?.starRating?.toString(),
          ),
          const SizedBox(
            height: kSize8,
          ),
          BlocBuilder(
              bloc: _cardHeadBloc,
              builder: () {
                return Opacity(
                  opacity: _cardHeadBloc.state.cardHeadBlocState ==
                          CardHeadBlocState.sticky
                      ? 1
                      : 0,
                  child: Container(
                    child: getCardHeadCalender(false, context),
                  ),
                );
              }),
          const SizedBox(height: kSize16),
          buildPromotionBanner(),
          if (_hotelDetailViewBloc.state.pageState !=
              HotelDetailViewPageState.noRoomData)
            const SizedBox(
              height: kSize24,
            ),
          if (_hotelDetailViewBloc.state.pageState !=
              HotelDetailViewPageState.noRoomData)
            _buildTitle(context),
        ],
      ),
    );
  }

  Widget getCardHeadCalenderWidget(bool isSticky, BuildContext context) {
    return BlocBuilder(
        bloc: _cardHeadBloc,
        builder: () {
          if (_cardHeadBloc.state.cardHeadBlocState ==
              CardHeadBlocState.sticky) {
            return const SizedBox();
          }
          return Container(
              color: AppColors.kLight100,
              height: _kStickyWidgetHeight,
              margin: const EdgeInsets.only(top: _kAppBarHeight),
              child: getCardHeadCalender(isSticky, context));
        });
  }

  Widget getHotelSliderTop() {
    return BlocBuilder(
        bloc: _hotelDetailViewBloc,
        builder: () {
          return BlocBuilder(
              bloc: _statusBarBloc,
              builder: () {
                return BlocBuilder(
                    bloc: _hotelFavoritesBloc,
                    builder: () {
                      return HotelSliderTop(
                        statusBarBloc: _statusBarBloc,
                        onBackClicked: onBackClicked,
                        onHeartClicked: onHeartClicked,
                        onShareClicked: (_hotelDetailViewBloc.state.pageState ==
                                    HotelDetailViewPageState.success ||
                                _hotelDetailViewBloc.state.pageState ==
                                    HotelDetailViewPageState.noRoomData)
                            ? onShareClicked
                            : null,
                        heartButtonController: _heartButtonController,
                        statusBarTitle:
                            _hotelDetailViewBloc.state.data?.name ?? "",
                      );
                    });
              });
        });
  }

  Widget getCardHeadCalender(bool isSticky, BuildContext context) {
    return CardHeadCalender(
      sectionOneHeader: getTranslated(context, AppLocalizationsStrings.checkIn),
      sectionTwoHeader:
          getTranslated(context, AppLocalizationsStrings.checkOut),
      sectionThreeHeader:
          getTranslated(context, AppLocalizationsStrings.hotelDetailRoomsLabel),
      sectionFourHeader: getTranslated(
          context, AppLocalizationsStrings.hotelDetailGuestsLabel),
      sectionOneFooter: _getTranslatedDate(
          _hotelDetailViewBloc.state.data?.checkInDate ?? ""),
      sectionTwoFooter: _getTranslatedDate(
          _hotelDetailViewBloc.state.data?.checkOutDate ?? ""),
      sectionFourFooter:
          _hotelDetailViewBloc.state.data?.guestCount.toString() ?? "",
      sectionThreeFooter:
          _hotelDetailViewBloc.state.data?.roomCount.toString() ?? "",
      isSticky: isSticky ? true : false,
      onPressed: () => onReservationDetailsClicked(context),
    );
  }

  String _getTranslatedDate(String date) {
    DateTime dateTime = Helpers().parseDateTime(date);
    return Helpers.getddMMMyy(dateTime);
  }

  void onBackClicked() {
    printDebug("onBackClicked");
    NavigatorHelper.shouldSystemPop(context);
  }

  void onHeartClicked() {
    Provider.of<FavouriteUpdate>(context, listen: false).updateFavourite(true);
    if (_hotelFavoritesBloc.state.heartButtonType ==
        HotelDetailHeartButtonType.selected) {
      _hotelFavoritesBloc.removeFavouriteHotel(
          _kServiceNameHotel, argument?.hotelId ?? '');
    } else {
      _hotelFavoritesBloc.addFavouriteHotel(
        AddFavoriteArgumentModelDomain.mapArgumentModel(
          argument,
          _hotelDetailViewBloc.state.data,
        ),
      );
      _getHeartClickedFirebase();
    }
  }

  void onShareClicked() {
    OtaShareFunction().otaShareClicked(
      serviceType: OtaServiceType.hotel,
      shareText: AppConfig()
          .configModel
          .hotelShareTitle
          .replaceAll('{}', _hotelDetailViewBloc.state.data?.name ?? ''),
      cityId: argument?.cityId,
      countryId: argument?.countryCode,
      productId: argument?.hotelId,
    );
    _getShareClickedFirebase();
  }

  void onGalleryButtonClicked(BuildContext context) {
    argument =
        ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;
    Navigator.pushNamed(context, AppRoutes.galleryScreen, arguments: argument);
    _getGalleryClickedFirebase();
  }

  void onReservationDetailsClicked(BuildContext context) async {
    argument =
        ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;
    final selectedFilter = await Navigator.pushNamed(
        context, AppRoutes.filterScreen,
        arguments: FilterArgument.fromHotelDetailArguments(argument,
            pushScreen: AppRoutes.hotelDetail));
    if (selectedFilter != null) {
      FilterArgument filterArgument = selectedFilter as FilterArgument;
      argument?.rooms =
          FilterHelper.getHotelArgumentRoomList(filterArgument.roomList);
      argument?.checkInDate = filterArgument.checkInDate ?? '';
      argument?.checkOutDate = filterArgument.checkOutDate ?? '';
      requestHotelData();
      requestSuggestionsData();
      _cardHeadBloc.setStateSticky();
      _statusBarBloc.setStatusOpened();
    }
  }

  String _getPriceRangeForAppFlyer(List<PrimaryViewModel>? roomList) {
    String priceRange = "";
    if (roomList == null) {
      priceRange = "";
    } else if (roomList.isEmpty) {
      priceRange = "";
    } else if (roomList.length == 1) {
      priceRange =
          "${roomList.first.nightPrice.toStringAsFixed(2)}-${roomList.first.nightPrice.toStringAsFixed(2)}";
    } else {
      priceRange =
          "${roomList.first.nightPrice.toStringAsFixed(2)}-${roomList.last.nightPrice.toStringAsFixed(2)}";
    }
    return priceRange;
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelPriceRange,
        value: _getPriceRangeForAppFlyer(
            _hotelDetailViewBloc.state.data?.roomList));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelPriceRange,
        value: _getPriceRangeForAppFlyer(
            _hotelDetailViewBloc.state.data?.roomList));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelPriceRange,
        value: _getPriceRangeForAppFlyer(
            _hotelDetailViewBloc.state.data?.roomList));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
        key: HotelPaymentSuccessAppFlyer.hotelPriceRange,
        value: _getPriceRangeForAppFlyer(
            _hotelDetailViewBloc.state.data?.roomList));
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
        key: HotelPaymentSuccessAppFlyer.hotelPriceRange,
        value: _getPriceRangeForAppFlyer(
            _hotelDetailViewBloc.state.data?.roomList));
  }

  String priceRange(List<PrimaryViewModel>? roomList) {
    String range = "";
    if (roomList == null) {
      range = "";
    } else if (roomList.length == 1) {
      range = roomList.first.nightPrice.toStringAsFixed(2);
    } else {
      range =
          "${roomList.first.nightPrice.toStringAsFixed(2)}-${roomList.last.nightPrice.toStringAsFixed(2)}";
    }
    return range;
  }

  void _getViewFirebase() {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: HotelViewDetailFirebase.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    logger.addKeyValue(
        key: HotelViewDetailFirebase.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    logger.publishToSuperApp(FirebaseEvent.hotelViewDetails);
  }

  void _getHeartClickedFirebase() {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: HotelFavoriteFirebase.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    logger.addKeyValue(
        key: HotelFavoriteFirebase.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    logger.publishToSuperApp(FirebaseEvent.hotelFavorite);
  }

  void _getShareClickedFirebase() {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: HotelShareParameter.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    logger.addKeyValue(
        key: HotelShareParameter.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    logger.publishToSuperApp(FirebaseEvent.hotelShare);
  }

  void _getGalleryClickedFirebase() {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: HotelViewGalleryFirebase.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    logger.addKeyValue(
        key: HotelViewGalleryFirebase.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    logger.publishToSuperApp(FirebaseEvent.hotelViewGallery);
  }

  void _getViewFacilityFirebase() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelViewFacility,
        key: HotelViewFacilityFirebase.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelViewFacility,
        key: HotelViewFacilityFirebase.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
  }

  void _getHotelRoomSelect() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelId,
        value: _hotelDetailViewBloc.state.data?.id);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    FirebaseHelper.addCommaSeparatedList(
        key: HotelRoomSelectFirebase.hotelPromotionTag,
        value: _hotelDetailViewBloc.state.data?.freeFoodPromotions != null
            ? _hotelDetailViewBloc.state.data?.freeFoodPromotions
                .map((e) => e.line1)
                .toList()
            : [],
        eventName: FirebaseEvent.hotelRoomSelect);
  }

  void _getAppFlyer() {
    AppFlyerLogger logger = AppFlyerLogger();

    int result = Helpers.daysBetween(
        start: argument!.checkInDate, end: argument!.checkOutDate);

    int childCount = argument?.childrenCount ?? 0;
    int guestCount = argument?.guestCount ?? 0;

    int adultCount = guestCount - childCount;

    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.checkInDate,
        value: _hotelDetailViewBloc.state.data?.checkInDate);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.checkOutDate,
        value: _hotelDetailViewBloc.state.data?.checkOutDate);
    logger.addIntValue(
        key: HotelDetailViewHotelAppFlyer.numberOfRooms,
        value: _hotelDetailViewBloc.state.data?.roomCount);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.hotelLocation,
        value: _hotelDetailViewBloc.state.data?.shortAddress);
    logger.addIntValue(
        key: HotelDetailViewHotelAppFlyer.hotelStar,
        value: _hotelDetailViewBloc.state.data?.starRating);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.hotelId, value: argument?.hotelId);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.contentId, value: argument?.hotelId);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.priceRangeChange,
        value: priceRange(_hotelDetailViewBloc.state.data?.roomList));

    logger.addIntValue(
        key: HotelDetailViewHotelAppFlyer.stayPeriod, value: result);

    logger.addIntValue(
        key: HotelDetailViewHotelAppFlyer.numberOfChild,
        value: argument?.childrenCount);
    logger.addIntValue(
        key: HotelDetailViewHotelAppFlyer.numberOfAdult, value: adultCount);
    logger.addKeyValue(
        key: HotelDetailViewHotelAppFlyer.contentType, value: "product");
    logger.addCurrency(key: HotelDetailViewHotelAppFlyer.currency);
    logger.addUserLocation();
    logger.addCommaSeparatedList(
        value: _hotelDetailViewBloc.state.data?.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        key: HotelDetailViewHotelAppFlyer.promoType);

    logger.publishToSuperApp(AppFlyerEvent.hoteldetailViewEvent);
  }

  void _getClickData() {
    int result = Helpers.daysBetween(
        start: argument!.checkInDate, end: argument!.checkOutDate);

    int childCount = argument?.childrenCount ?? 0;
    int guestCount = argument?.guestCount ?? 0;

    int adultCount = guestCount - childCount;

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.checkInDate,
        value: _hotelDetailViewBloc.state.data?.checkInDate);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.checkOutDate,
        value: _hotelDetailViewBloc.state.data?.checkOutDate);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.numberOfRooms,
        value: _hotelDetailViewBloc.state.data?.roomCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.hotelLocation,
        value: _hotelDetailViewBloc.state.data?.shortAddress);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.hotelStar,
        value: _hotelDetailViewBloc.state.data?.starRating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.hotelId,
        value: argument?.hotelId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.contentId,
        value: argument?.hotelId);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.priceRangeChange,
        value: priceRange(_hotelDetailViewBloc.state.data?.roomList));
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.stayPeriod,
        value: result);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.numberOfChild,
        value: argument?.childrenCount);
    AppFlyerHelper.addIntValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.numberOfAdult,
        value: adultCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.contentType,
        value: "product");
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        key: HotelDetailClickHotelAppFlyer.currency);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.hoteldetailClickEvent);
    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hoteldetailClickEvent,
        value: _hotelDetailViewBloc.state.data?.freeFoodPromotions
            .map((e) => e.line1)
            .toList(),
        key: HotelDetailClickHotelAppFlyer.promoType);
  }

  void _getHotelIdFirebase() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelName,
        value: _hotelDetailViewBloc.state.data?.name);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelViewRoomGalleryCount,
        value: _kDefaultValue);
    FirebaseHelper.addCommaSeparatedList(
      eventName: FirebaseEvent.hotelViewRoomDetails,
      key: HotelViewRoomDetails.hotelPromotionTag,
      value: _hotelDetailViewBloc.state.data?.freeFoodPromotions != null
          ? _hotelDetailViewBloc.state.data?.freeFoodPromotions
              .map((e) => e.line1)
              .toList()
          : [],
    );
  }

  getCapsulePromotions(
      String eventName, List<OtaFreeFoodPromotionModel>? promotions) {
    FirebaseHelper.addCommaSeparatedList(
        key: HotelBookingReviewFirebase.hotelPromotionTag,
        value:
            promotions != null ? promotions.map((e) => e.line1).toList() : [],
        eventName: eventName);
  }
}
