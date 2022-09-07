import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_details_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_share_function.dart';
import 'package:ota/core_pack/custom_widgets/ota_special_promotion_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_supplier_common_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_supplier_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_supplier_reserve_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_status_bar_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_sticky_bar_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_rental_favorites_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/channels/super_app_to_confirm_register_booking.dart';
import 'package:ota/modules/car_rental/car_detail/helper/car_detail_helper.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_app_bar.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_error_widget.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_gallery_slider.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_header_button.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_image_slider.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_info.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_list.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_price_widget.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_sticky_bar.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_pickup_dropoff_widget.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/heart_button_car_rental_controller.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_view_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_rental_favorites_view_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view_model/car_detail_more_info_view_model.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_update.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/app_localization_strings.dart';
import '../../../../core_pack/custom_widgets/ota_alert_dialog.dart';
import '../../../../core_pack/custom_widgets/ota_banner/ota_banner.dart';
import '../../../../core_pack/custom_widgets/ota_dialog_loader.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../car_reservation/view_model/car_reservation_argument_view_model.dart';

const double _kExpandableMaxHeight = 420;
const double _kAppBarHeight = 89;
const double _kStickyWidgetHeight = 60;
const String _kServiceName = "CARRENTAL";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";
const String _kCarDetailListKey = "car_detail_list_key";
const String _kLastSizeBoxKey = "last_size_box_key";
const String _kCarDetailSuccessSliverListKey =
    "car_detail_success_sliver_list_key";

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({Key? key}) : super(key: key);

  @override
  CarDetailScreenState createState() => CarDetailScreenState();
}

class CarDetailScreenState extends State<CarDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final HeartButtonCarRentalController _heartButtonController =
      HeartButtonCarRentalController();
  final CarDetailViewBloc _carDetailViewBloc = CarDetailViewBloc();
  final CarDetailStatusBarBloc _statusBarBloc = CarDetailStatusBarBloc();
  final CarDetailStickyBarBloc _stickyBarBloc = CarDetailStickyBarBloc();
  final CarRentalFavoritesBloc _carRentalFavoritesBloc =
      CarRentalFavoritesBloc();

  CarDetailArgumentModel? argument;
  final SuperAppToRegisterCarConfirmBooking
      superAppToRegisterCarConfirmBooking =
      SuperAppToRegisterCarConfirmBooking();
  AppFlyerLogger appFlyerLogger = AppFlyerLogger();
  FirebaseLogger firebaseLogger = FirebaseLogger();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _statusBarBloc.setStatusOnScroll(_scrollController);
      _stickyBarBloc.setStatusOnScroll(_scrollController);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      superAppToRegisterCarConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
      argument =
          ModalRoute.of(context)?.settings.arguments as CarDetailArgumentModel;
      _carDetailViewBloc.setCarDetail(argument);

      _requestCarDeatilData();
      _checkFavourite(
        _kServiceName,
        argument?.carId ?? '',
        argument?.supplierId ?? '',
      );

      _carRentalFavoritesBloc.stream.listen((event) {
        _setButtonState();
        if (_carRentalFavoritesBloc.state.addFavoriteCarRentalState ==
                AddFavoriteCarRentalState.failureNetwork ||
            _carRentalFavoritesBloc.state.unFavoriteCarRentalState ==
                UnFavoriteCarRentalState.failureNetwork) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
    });
    _carDetailViewBloc.stream.listen((event) {
      if (_carDetailViewBloc.state.pageState ==
          CarDetailViewPageState.success) {
        _launchAppFlyerEvent();
        _launchFirebaseCommonSupplierEvents(FirebaseEvent.carSupplierViewEvent);
      }
      if (_carDetailViewBloc.state.pageState ==
          CarDetailViewPageState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  Future<void> _requestCarDeatilData({bool isRefresh = false}) async {
    await _carDetailViewBloc.getCarDetail(argument, isRefresh);
    getCapsulePromotions(FirebaseEvent.carSupplierSelect,
        _carDetailViewBloc.state.carDetailInfo?.carDetail?.promotions);
  }

  @override
  void dispose() {
    superAppToRegisterCarConfirmBooking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collapsedHeight = _kAppBarHeight - MediaQuery.of(context).padding.top;
    final appBarHeight = _kAppBarHeight + MediaQuery.of(context).padding.top;
    _stickyBarBloc.setDynamicCardHeadOffset(appBarHeight);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        body: Stack(
          children: [
            CustomScrollView(
              key: const Key(_kCarDetailListKey),
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness:
                        Platform.isIOS ? Brightness.light : Brightness.dark,
                    statusBarIconBrightness:
                        Platform.isIOS ? Brightness.light : Brightness.dark,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: BlocBuilder(
                      bloc: _carDetailViewBloc,
                      builder: () {
                        return CarDetailImageSlider(
                          imageUrl: [
                            _carDetailViewBloc.state.carDetailInfo?.carInfo
                                    ?.images?.full ??
                                ""
                          ],
                          sliderHeight: _kExpandableMaxHeight + kToolbarHeight,
                          pageController: _pageController,
                        );
                      },
                    ),
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
                    child: CarDetailGallerySlider(
                      statusBarBloc: _statusBarBloc,
                      onGalleryClicked: () => _onGalleryButtonClicked(),
                    ),
                  ),
                ),
                BlocBuilder(
                  bloc: _carDetailViewBloc,
                  builder: () {
                    switch (_carDetailViewBloc.state.pageState) {
                      case CarDetailViewPageState.failure:
                      case CarDetailViewPageState.failureNetwork:
                        return _failureWidget();
                      case CarDetailViewPageState.noData:
                        return _noInfoWidget();
                      case CarDetailViewPageState.success:
                        return _successWidget();
                      default:
                        return _loadingWidget();
                    }
                  },
                ),
              ],
            ),
            _buildClosedAppBar(),
            _buildDateAndTimeSelectionBar(),
            _buildBottomPriceWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildClosedAppBar() {
    return BlocBuilder(
      bloc: _carDetailViewBloc,
      builder: () {
        String brnadName =
            _carDetailViewBloc.state.carDetailInfo?.carInfo?.brand ?? '';
        String carName =
            _carDetailViewBloc.state.carDetailInfo?.carInfo?.name ?? '';
        return BlocBuilder(
          bloc: _statusBarBloc,
          builder: () {
            return BlocBuilder(
              bloc: _carRentalFavoritesBloc,
              builder: () {
                _handleProgressHandler();
                return CarDetailAppBar(
                  statusBarBloc: _statusBarBloc,
                  onBackClicked: _onBackButtonClicked,
                  onHeartClicked: _onHeartButtonClicked,
                  statusBarTitle: brnadName.addTrailingSpace() + carName,
                  heartButtonCarRentalController: _heartButtonController,
                  onShareClicked: _onShareClicked,
                );
              },
            );
          },
        );
      },
    );
  }

  void _onShareClicked() {
    _launchFirebaseCommonSupplierEvents(FirebaseEvent.carSupplierShareEvent);
    OtaShareFunction().otaShareClicked(
      serviceType: OtaServiceType.carRental,
      productId: _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.id ??
          argument?.carId,
      pickupLocation: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.pickupCounter?.locationId ??
          argument?.pickupLocationId,
      pickUpCounter: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.pickupCounter?.id ??
          argument?.pickupCounter,
      returnLocation: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.returnCounter?.locationId ??
          argument?.returnLocationId,
      returnCounter: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.returnCounter?.id ??
          argument?.returnCounter,
      supplierId:
          _carDetailViewBloc.state.carDetailInfo?.carDetail?.supplier?.id ??
              argument?.supplierId,
      shareText: AppConfig().configModel.carRentalShareTitle.replaceAll('{}',
          '${_carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.name ?? ""} ${_carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.brand ?? ""}'),
    );
  }

  Widget _buildDateAndTimeSelectionBar() {
    return BlocBuilder(
      bloc: _stickyBarBloc,
      builder: () {
        if (_stickyBarBloc.state.cardHeadBlocState ==
            CarDetailStickyBarState.sticky) {
          return const SizedBox.shrink();
        }
        return Container(
          color: AppColors.kLight100,
          height: _kStickyWidgetHeight,
          margin: const EdgeInsets.only(top: _kAppBarHeight),
          child: CarDetailStickyBar(
            isSticky: true,
            pickUpDate: Helpers.getddMMMyy(
                _carDetailViewBloc.state.carDetailInfo?.fromDate ??
                    DateTime.now()),
            pickUpTime: Helpers.gethhmm(
                _carDetailViewBloc.state.carDetailInfo?.fromDate ??
                    DateTime.now()),
            dropOffDate: Helpers.getddMMMyy(
                _carDetailViewBloc.state.carDetailInfo?.toDate ??
                    DateTime.now()),
            dropOffTime: Helpers.gethhmm(
                _carDetailViewBloc.state.carDetailInfo?.toDate ??
                    DateTime.now()),
            onPressed: _goToDateAndTimeSelectionScreen,
          ),
        );
      },
    );
  }

  Widget _loadingWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const OTALoadingIndicator();
        },
        childCount: 1,
      ),
    );
  }

  Widget _noInfoWidget() {
    _setButtonState();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return _buildDateAndTimeSelectionBarWithDetail();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSize24, vertical: kSize30),
              child: OtaNoMatchingResultWidget(
                errorTextHeader:
                    getTranslated(context, AppLocalizationsStrings.sorry),
                errorTextFooter:
                    getTranslated(context, AppLocalizationsStrings.noCarDetail),
              ),
            );
          }
        },
        childCount: 2,
      ),
    );
  }

  Widget _failureWidget() {
    _setButtonState();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CarDetailErrorWidget(
            height: MediaQuery.of(context).size.height * 0.45,
            onRefresh: () async {
              _checkFavourite(
                _kServiceName,
                argument?.carId ?? '',
                argument?.supplierId ?? '',
              );
              await _requestCarDeatilData(isRefresh: true);
            },
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget _successWidget() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _carDetailViewBloc.state.carDetailInfo?.carDetail?.promotions ?? [];
    _setButtonState();
    return SliverList(
      key: const Key(_kCarDetailSuccessSliverListKey),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          CarDetailModel? carDetail =
              _carDetailViewBloc.state.carDetailInfo?.carDetail;
          if (index == 0) {
            return _buildDateAndTimeSelectionBarWithDetail();
          } else if (index == 1) {
            return Column(
              children: [
                if (freeFoodPromotionList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kSize24, right: kSize24, top: kSize24),
                    child: OtaFreeFoodBannerWidget(
                        freeFoodPromotionList: freeFoodPromotionList),
                  ),
                CarPickUpDropOffWidget(
                  pickUpLocation: carDetail?.pickupCounter?.locationName ?? '',
                  dropOffLocation: carDetail?.returnCounter?.locationName ?? '',
                  onPress: () => _goToPickupDropoff(
                      CarDetailInfoPickType.carDetailInfoPickup),
                ),
              ],
            );
          } else if (index == 2) {
            CarModel? car = carDetail?.car;
            return Column(
              children: [
                CarDetailList(
                  onPress: () => _goToPickupDropoff(
                      CarDetailInfoPickType.carDetailInfoCarInfo),
                  noOfSeats: car?.seatNbr ?? '',
                  gear: car?.gear ?? '',
                  noOfDoors: car?.doorNbr ?? '',
                  noOfLargeBag: car?.bagLargeNbr ?? '',
                  noOfSmallBag: car?.bagSmallNbr ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: kSize24, right: kSize24, top: kSize24),
                  child: OtaSpecialPromotionWidget(
                    allowLateReturn: carDetail?.allowLateReturn ?? 0,
                  ),
                ),
              ],
            );
          } else if (index == 3) {
            return CarDetailHeaderButton(
              headerTitle: AppLocalizationsStrings.includeLabel,
              onPress: () => _goToCarDetailMoreInfo(
                  CarDetailMoreInfoPickType.includedInRentalPrice),
            );
          } else if (index == 4) {
            return CarDetailHeaderButton(
              headerTitle: AppLocalizationsStrings.carRentalConditionsLabel,
              onPress: () => _goToCarDetailMoreInfo(
                  CarDetailMoreInfoPickType.carRentalCondition),
            );
          } else if (index == 5) {
            return CarDetailHeaderButton(
              headerTitle: AppLocalizationsStrings.pickupConditionsLabel,
              onPress: () =>
                  _goToCarDetailMoreInfo(CarDetailMoreInfoPickType.pickUp),
            );
          } else {
            return SizedBox(
              key: const Key(_kLastSizeBoxKey),
              height: kSize100 + MediaQuery.of(context).padding.bottom,
            );
          }
        },
        childCount: 7,
      ),
    );
  }

  Widget _buildBottomPriceWidget() {
    return BlocBuilder(
      bloc: _carDetailViewBloc,
      builder: () {
        CarDetailModel? carDetail =
            _carDetailViewBloc.state.carDetailInfo?.carDetail;
        return _carDetailViewBloc.state.pageState ==
                CarDetailViewPageState.success
            ? Align(
                alignment: Alignment.bottomCenter,
                child: CarDeatilPriceWidget(
                    pricePerDay: carDetail?.pricePerDay ?? 0.0,
                    totalPrice: carDetail?.totalPrice ?? 0.0,
                    pickupLocation: _carDetailViewBloc.state.carDetailInfo
                            ?.carDetail?.pickupCounter?.locationName ??
                        '',
                    returnLocation: _carDetailViewBloc.state.carDetailInfo
                            ?.carDetail?.returnCounter?.locationName ??
                        '',
                    onPressed: () async {
                      _launchFirebaseClickReserveEvent();
                      LoginModel loginModel = Provider.of<LoginModel>(
                          GlobalKeys.navigatorKey.currentContext!,
                          listen: false);

                      if (loginModel.userType == UserType.loggedInUser) {
                        await Navigator.pushNamed(
                          context,
                          AppRoutes.carReservationScreen,
                          arguments: CarReservationViewArgumentModel(
                            age: argument?.age ?? 0,
                            carId: argument?.carId ?? "",
                            currency: argument?.currency ?? "",
                            includeDriver: argument?.includeDriver ?? "",
                            pickupDate: _carDetailViewBloc
                                .state.carDetailInfo?.fromDate,
                            pickupLocationId: argument?.pickupLocationId ?? "",
                            rentalType: argument?.rentalType ?? "",
                            returnDate:
                                _carDetailViewBloc.state.carDetailInfo?.toDate,
                            returnLocationId: argument?.returnLocationId ?? "",
                            supplierId: argument?.supplierId ?? "",
                            pickupCounter: carDetail?.pickupCounter?.id ?? '',
                            residenceCountry: argument?.residenceCountry ?? "",
                            returnCounter: carDetail?.returnCounter?.id ?? '',
                            rateKey: carDetail?.rateKey ?? "",
                            refCode: carDetail?.refCode ?? "",
                            lastPrice: carDetail?.totalPrice ?? 0.0,
                          ),
                        );
                        CarReservationUpdate carReservationUpdate =
                            Provider.of<CarReservationUpdate>(context,
                                listen: false);
                        if (carReservationUpdate.isCarDetailUpdated) {
                          carReservationUpdate.carDetailUpdated();
                          _requestCarDeatilData();
                        }
                      } else {
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
                                    leftButtonText: getTranslated(context,
                                        AppLocalizationsStrings.cancel),
                                    rightButtonText: getTranslated(
                                        context,
                                        AppLocalizationsStrings
                                            .registerPopupRegisterButton),
                                    alertText: getTranslated(
                                        context,
                                        AppLocalizationsStrings
                                            .accountProceedLabel),
                                    alertTitle: getTranslated(
                                        context,
                                        AppLocalizationsStrings
                                            .registerPopupHeader),
                                    onLeftButtonTap: () {
                                      Navigator.pop(context);
                                    },
                                    onRightButtonTap: () {
                                      waitForSuperAppToPushLandingPage();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    returnExtraCharge: carDetail?.returnExtraCharge ?? 0.0),
              )
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildDateAndTimeSelectionBarWithDetail() {
    CarDetailInfoModel? carDetailInfo = _carDetailViewBloc.state.carDetailInfo;
    CarDetailModel? carDetail = carDetailInfo?.carDetail;
    CarInfoModel? carInfo = carDetailInfo?.carInfo;
    String brnadName = carInfo?.brand ?? '';
    String carName = carInfo?.name ?? '';
    String carType = carInfo?.crafttype ?? '';
    String logo = carDetail?.supplier?.logo ?? '';

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kLight100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarDetailInfo(
            statusBarBloc: _statusBarBloc,
            headerText: brnadName.addTrailingSpace() + carName,
            typeText: carType,
            logo: logo,
          ),
          const SizedBox(height: kSize16),
          BlocBuilder(
            bloc: _stickyBarBloc,
            builder: () {
              DateTime fromDate =
                  _carDetailViewBloc.state.carDetailInfo?.fromDate ??
                      DateTime.now();
              DateTime toDate =
                  _carDetailViewBloc.state.carDetailInfo?.toDate ??
                      DateTime.now();
              return Opacity(
                opacity: _stickyBarBloc.state.cardHeadBlocState ==
                        CarDetailStickyBarState.sticky
                    ? 1
                    : 0,
                child: CarDetailStickyBar(
                  isSticky: false,
                  pickUpDate: Helpers.getddMMMyy(fromDate),
                  pickUpTime: Helpers.gethhmm(fromDate),
                  dropOffDate: Helpers.getddMMMyy(toDate),
                  dropOffTime: Helpers.gethhmm(toDate),
                  onPressed: _goToDateAndTimeSelectionScreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onBackButtonClicked() {
    NavigatorHelper.shouldSystemPop(context);
  }

  void _onHeartButtonClicked() {
    Provider.of<FavouriteUpdate>(context, listen: false).updateFavourite(true);
    if (_carRentalFavoritesBloc.state.heartButtonType ==
        CarRentalDetailHeartButtonType.selected) {
      _carRentalFavoritesBloc.removeFavouriteCar(
        _kServiceName,
        argument?.carId ?? '',
        argument?.supplierId ?? '',
      );
    } else {
      _launchFirebaseCommonSupplierEvents(
          FirebaseEvent.carSupplierFavouriteEvent);
      _setCounterValues();
      _carRentalFavoritesBloc.addFavouriteCar(
        AddFavoriteArgumentModelDomain.mapArgumentModel(
          argument,
          _carDetailViewBloc.state.carDetailInfo,
        ),
        _kServiceName,
      );
    }
  }

  void _setCounterValues() {
    argument?.pickupCounter =
        _carDetailViewBloc.state.carDetailInfo?.carDetail?.pickupCounter?.id ??
            "";
    argument?.returnCounter =
        _carDetailViewBloc.state.carDetailInfo?.carDetail?.returnCounter?.id ??
            "";
  }

  Future<bool> _onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    NavigatorHelper.shouldSystemPop(context);
    return false;
  }

  void _onGalleryButtonClicked() {
    _launchFirebaseCommonSupplierEvents(
        FirebaseEvent.carSupplierViewGalleryEvent);
    Navigator.of(context).pushNamed(
      AppRoutes.carGalleryScreen,
      arguments: CarGalleryArgumentModel(carId: argument?.carId ?? ''),
    );
  }

  void _goToCarDetailMoreInfo(
      CarDetailMoreInfoPickType carDetailMoreInfoPickType) {
    CarDetailModel? carDetail =
        _carDetailViewBloc.state.carDetailInfo?.carDetail;
    Navigator.of(context).pushNamed(
      AppRoutes.carDetailMoreInfoScreen,
      arguments: CarDetailMoreInfoArgumentModel(
        carRentalConditionHtmlText: carDetail?.carRentalConditionsInfo ?? '',
        includedInRentalPriceHtmlText: carDetail?.includesInfo ?? '',
        pickUpHtmlText: carDetail?.pickupConditionsInfo ?? '',
        carDetailMoreInfoPickType: carDetailMoreInfoPickType,
      ),
    );
  }

  void _goToPickupDropoff(CarDetailInfoPickType carDetailInfoPickType) async {
    CarDetailModel? carDetail =
        _carDetailViewBloc.state.carDetailInfo?.carDetail;
    CarDetailsInfoDataViewModel carDetailsInfoDataViewModel =
        CarDetailHelper.getCarDetailInfo(carDetail, context);
    CarReservationViewArgumentModel carReservationViewArgumentModel =
        CarReservationViewArgumentModel(
      age: argument?.age ?? 0,
      carId: argument?.carId ?? "",
      currency: argument?.currency ?? "",
      includeDriver: argument?.includeDriver ?? "",
      pickupDate: _carDetailViewBloc.state.carDetailInfo?.fromDate,
      pickupLocationId: argument?.pickupLocationId ?? "",
      rentalType: argument?.rentalType ?? "",
      returnDate: _carDetailViewBloc.state.carDetailInfo?.toDate,
      returnLocationId: argument?.returnLocationId ?? "",
      supplierId: argument?.supplierId ?? "",
      pickupCounter: argument?.pickupCounter,
      residenceCountry: argument?.residenceCountry ?? "",
      returnCounter: argument?.returnCounter,
      rateKey: carDetail?.rateKey ?? "",
      refCode: carDetail?.refCode ?? "",
      lastPrice: carDetail?.totalPrice ?? 0.0,
    );

    await Navigator.pushNamed(
      context,
      AppRoutes.carDetailInfoScreen,
      arguments: CarDetailInfoArgumentModel(
          carDetailInfoCarInfo: CarDetailInfoCarInfo(
            carDetails: carDetailsInfoDataViewModel.carDetails,
            facilityList: carDetail?.car?.facilities ?? [],
            pricing: carDetailsInfoDataViewModel.pricing,
          ),
          carDetailInfoDropOff: CarDetailInfoDropOff(
            carDetails: carDetailsInfoDataViewModel.carDetailsDropOff,
            carInfo: carDetailsInfoDataViewModel.carInfo,
            pricing: carDetailsInfoDataViewModel.pricing,
          ),
          carDetailInfoPickup: CarDetailInfoPickup(
            carDetails: carDetailsInfoDataViewModel.carDetailsPickUp,
            carInfo: carDetailsInfoDataViewModel.carInfo,
            pricing: carDetailsInfoDataViewModel.pricing,
          ),
          carDetailInfoPickType: carDetailInfoPickType,
          carReservationViewArgumentModel: carReservationViewArgumentModel,
          isPriceWidgetVisible: true,
          showMap: true,
          pickupLocation: LocationDataModel(
              lattitude: _carDetailViewBloc
                  .state.carDetailInfo?.carDetail?.pickupCounter?.latitude,
              longitude: _carDetailViewBloc
                  .state.carDetailInfo?.carDetail?.pickupCounter?.longitude),
          dropOffLocation: LocationDataModel(
              lattitude: _carDetailViewBloc
                  .state.carDetailInfo?.carDetail?.returnCounter?.latitude,
              longitude: _carDetailViewBloc
                  .state.carDetailInfo?.carDetail?.returnCounter?.longitude),
          pickupLocationName: carDetail?.pickupCounter?.locationName ?? '',
          dropOffLocationName: carDetail?.returnCounter?.locationName ?? '',
          returnExtraCharge: carDetail?.returnExtraCharge ?? 0.0),
    );
    CarReservationUpdate carReservationUpdate =
        Provider.of<CarReservationUpdate>(context, listen: false);
    if (carReservationUpdate.isCarDetailUpdated) {
      carReservationUpdate.carDetailUpdated();
      _requestCarDeatilData();
    }
  }

  void _goToDateAndTimeSelectionScreen() async {
    DateTime fromDate =
        _carDetailViewBloc.state.carDetailInfo?.fromDate ?? DateTime.now();
    DateTime toDate =
        _carDetailViewBloc.state.carDetailInfo?.toDate ?? DateTime.now();

    var data = await Navigator.of(context).pushNamed(
      AppRoutes.carDateTimeSelectionScreen,
      arguments: CarDateTimePickerArgumentModel(
        pickUpDate: fromDate,
        dropOffDate: toDate,
      ),
    );
    if (data != null) {
      CarDateTimePickerArgumentModel? argumentModel =
          data as CarDateTimePickerArgumentModel;
      _carDetailViewBloc.updateDateAndTime(argumentModel);
      _requestCarDeatilData();
    }
  }

  void _setButtonState() {
    switch (argument?.userType) {
      case CarRentalDetailUserType.guestUser:
        if (_carDetailViewBloc.state.pageState ==
            CarDetailViewPageState.failureNetwork) {
          _statusBarBloc.setDisabled();
        } else {
          _statusBarBloc.setEnable();
        }
        _heartButtonController.setDisabled();
        break;
      case CarRentalDetailUserType.loggedInUser:
        if (_carDetailViewBloc.state.pageState ==
                CarDetailViewPageState.failure ||
            _carDetailViewBloc.state.pageState ==
                CarDetailViewPageState.loading ||
            _carDetailViewBloc.state.pageState ==
                CarDetailViewPageState.failureNetwork) {
          _heartButtonController.setUnselected();
          _heartButtonController.setDisabled();
          _statusBarBloc.setDisabled();
        } else if (_carRentalFavoritesBloc.state.heartButtonType ==
            CarRentalDetailHeartButtonType.selected) {
          _heartButtonController.setSelected();
          _statusBarBloc.setEnable();
        } else {
          _heartButtonController.setUnselected();
          _statusBarBloc.setEnable();
        }
        break;
      default:
        _heartButtonController.setDisabled();
        _statusBarBloc.setDisabled();
        break;
    }
  }

  void _checkFavourite(String kServiceName, String carId, String supplierId) {
    _carRentalFavoritesBloc.checkFavorites(carId, supplierId, kServiceName);
  }

  void _handleProgressHandler() {
    if (_carRentalFavoritesBloc.state.unFavoriteCarRentalState ==
        UnFavoriteCarRentalState.loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaDialogLoader().showLoader(context);
      });
    } else if (_carRentalFavoritesBloc.state.unFavoriteCarRentalState ==
        UnFavoriteCarRentalState.failure) {
      _carRentalFavoritesBloc.updateUnfavouritesCarState();
      OtaDialogLoader().hideLoader(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      });
    } else if (_carRentalFavoritesBloc.state.unFavoriteCarRentalState ==
        UnFavoriteCarRentalState.success) {
      _carRentalFavoritesBloc.updateUnfavouritesCarState();
      OtaDialogLoader().hideLoader(context);
    } else if (_carRentalFavoritesBloc.state.addFavoriteCarRentalState ==
        AddFavoriteCarRentalState.loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaDialogLoader().showLoader(context);
      });
    } else if (_carRentalFavoritesBloc.state.addFavoriteCarRentalState ==
        AddFavoriteCarRentalState.failure) {
      _carRentalFavoritesBloc.updateAddfavouritesCarState();
      OtaDialogLoader().hideLoader(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.addFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      });
    } else if (_carRentalFavoritesBloc.state.addFavoriteCarRentalState ==
        AddFavoriteCarRentalState.failureMaxLimit) {
      OtaDialogLoader().hideLoader(context);
      _carRentalFavoritesBloc.updateAddfavouritesCarState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAlert();
      });
    } else if (_carRentalFavoritesBloc.state.addFavoriteCarRentalState ==
        AddFavoriteCarRentalState.success) {
      _carRentalFavoritesBloc.updateAddfavouritesCarState();
      OtaDialogLoader().hideLoader(context);
    }
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
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "bookingCustomerRegister",
        arguments: BookingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  void _showAlert() {
    OtaAlertDialog(
        errorMessage: getTranslated(
          context,
          AppLocalizationsStrings.maxLimitExceed,
        ),
        errorTitle: getTranslated(
          context,
          AppLocalizationsStrings.unableToProceed,
        ),
        buttonTitle: getTranslated(
          context,
          AppLocalizationsStrings.ok,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }).showAlertDialog(context);
  }

  Map<String, String> _getAppFlyerParameterData() {
    return {
      CarDetailsAppFlyer.carId: argument?.carId ?? '',
      CarDetailsAppFlyer.carAgencyName:
          _carDetailViewBloc.state.carDetailInfo?.carDetail?.supplier?.name ??
              '',
      CarDetailsAppFlyer.carDropOffLocation: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.returnCounter?.locationName ??
          '',
      CarDetailsAppFlyer.carPickUpLocation: _carDetailViewBloc
              .state.carDetailInfo?.carDetail?.pickupCounter?.locationName ??
          '',
      CarDetailsAppFlyer.carPickUpDate: CarAppFlyerHelper()
          .addCarFormatDateValue(
              value: _carDetailViewBloc.state.carDetailInfo?.fromDate),
      CarDetailsAppFlyer.carReturnDate: CarAppFlyerHelper()
          .addCarFormatDateValue(
              value: _carDetailViewBloc.state.carDetailInfo?.toDate),
      CarDetailsAppFlyer.carNoOfPassengers:
          _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.seatNbr ?? '',
      CarDetailsAppFlyer.carContentId: argument?.carId ?? '',
    };
  }

  void _launchAppFlyerEvent() {
    int rentalPeriod = Helpers.daysBetween(
        start: CarAppFlyerHelper().getDateTimeAsString(
            value: _carDetailViewBloc.state.carDetailInfo?.fromDate),
        end: CarAppFlyerHelper().getDateTimeAsString(
            value: _carDetailViewBloc.state.carDetailInfo?.toDate));
    appFlyerLogger.addParameters(_getAppFlyerParameterData());
    appFlyerLogger.addDoubleValue(
        key: CarDetailsAppFlyer.carRentalPrice,
        value: _carDetailViewBloc.state.carDetailInfo?.carDetail?.pricePerDay);
    appFlyerLogger.addIntValue(
        key: CarDetailsAppFlyer.carRentalPeriod, value: rentalPeriod);
    appFlyerLogger.addContentType(key: CarDetailsAppFlyer.carContentType);
    appFlyerLogger.addCurrency(key: CarDetailsAppFlyer.carCurrency);
    appFlyerLogger.addUserLocation();
    appFlyerLogger.publishToSuperApp(AppFlyerEvent.carDetailEvent);
  }

  void _getFirebaseClickReserveParameters() {
    int rentalPeriod = 0;
    TimeOfDay dropTime = CarAppFlyerHelper.getOnlyTimeFromDate(
        _carDetailViewBloc.state.carDetailInfo?.toDate);
    TimeOfDay pickUpTime = CarAppFlyerHelper.getOnlyTimeFromDate(
        _carDetailViewBloc.state.carDetailInfo?.fromDate);
    if (dropTime.hour > pickUpTime.hour &&
            dropTime.minute >= pickUpTime.minute ||
        dropTime.hour == pickUpTime.hour &&
            dropTime.minute > pickUpTime.minute) {
      rentalPeriod = 1 +
          Helpers.daysBetween(
              start: Helpers.getYYYYmmddFromDateTime(
                  _carDetailViewBloc.state.carDetailInfo?.fromDate),
              end: Helpers.getYYYYmmddFromDateTime(
                  _carDetailViewBloc.state.carDetailInfo?.toDate));
    } else {
      rentalPeriod = Helpers.daysBetween(
          start: Helpers.getYYYYmmddFromDateTime(
              _carDetailViewBloc.state.carDetailInfo?.fromDate),
          end: Helpers.getYYYYmmddFromDateTime(
              _carDetailViewBloc.state.carDetailInfo?.toDate));
    }
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carModelId, value: argument?.carId);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carModelName,
        value: _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.name);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carSupplierId,
        value: argument?.supplierId);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carSupplierName,
        value:
            _carDetailViewBloc.state.carDetailInfo?.carDetail?.supplier?.name);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carBrand,
        value: _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.brand);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carType,
        value:
            _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.crafttype);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carPickUpLocation,
        value: _carDetailViewBloc
            .state.carDetailInfo?.carDetail?.pickupCounter?.locationName);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carDropOffLocation,
        value: _carDetailViewBloc
            .state.carDetailInfo?.carDetail?.returnCounter?.locationName);
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carPickUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carDetailViewBloc.state.carDetailInfo?.fromDate));
    firebaseLogger.addKeyValue(
        key: CarSupplierReserveFirebase.carReturnUpDateTime,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: _carDetailViewBloc.state.carDetailInfo?.toDate));
    firebaseLogger.addIntValue(
        key: CarSupplierReserveFirebase.carNumberDay, value: rentalPeriod);
    firebaseLogger.addDoubleValue(
        key: CarSupplierReserveFirebase.carTotalPrice,
        value: (_carDetailViewBloc.state.carDetailInfo?.carDetail?.totalPrice ??
                0.0) +
            (_carDetailViewBloc
                    .state.carDetailInfo?.carDetail?.returnExtraCharge ??
                0.0));
  }

  void _launchFirebaseClickReserveEvent() {
    _getFirebaseClickReserveParameters();
    firebaseLogger.publishToSuperApp(FirebaseEvent.carSupplierReserveEvent);
  }

  void _getFirebaseCommonSupplierParameters() {
    firebaseLogger.addKeyValue(
        key: CarSupplierFirebase.carModelId, value: argument?.carId);
    firebaseLogger.addKeyValue(
        key: CarSupplierFirebase.carModelName,
        value: _carDetailViewBloc.state.carDetailInfo?.carDetail?.car?.name);
    firebaseLogger.addKeyValue(
        key: CarSupplierFirebase.carSupplierId, value: argument?.supplierId);
    firebaseLogger.addKeyValue(
        key: CarSupplierFirebase.carSupplierName,
        value:
            _carDetailViewBloc.state.carDetailInfo?.carDetail?.supplier?.name);
  }

  void _launchFirebaseCommonSupplierEvents(String eventName) {
    _getFirebaseCommonSupplierParameters();
    firebaseLogger.publishToSuperApp(eventName);
  }

  getCapsulePromotions(
      String eventName, List<OtaFreeFoodPromotionModel>? promotions) {
    FirebaseHelper.addCommaSeparatedList(
        key: CarSupplierParametersFirebase.carPromotionTag,
        value:
            promotions != null ? promotions.map((e) => e.line1).toList() : [],
        eventName: eventName);
    FirebaseHelper.stopCapturingEvent(eventName);
  }
}
