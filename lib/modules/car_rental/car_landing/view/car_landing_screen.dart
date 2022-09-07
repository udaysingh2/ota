import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_banner_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_landing_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_playlist_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_recommended_location_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_result_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/persistence/hive/boxes.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_location_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_recently_viewed_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_recommendation_card_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_recommendation_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';
import 'package:ota/modules/landing/bloc/banner_bloc.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../domain/car_rental/car_landing/models/landing_recent_search_domain_model.dart'
    as search_model;
import '../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import '../../car_search_suggestion/view_model/car_search_argument_model.dart';
import '../db_models/car_recent_search_model.dart';
import '../helpers/recent_search_db_helper.dart';
import '../helpers/string_to_date.dart';
import 'widgets/car_date_and_time_picker.dart';
import 'widgets/car_landing_diffrent_drop_toggel.dart';
import 'widgets/car_landing_driver_age_widget.dart';
import 'widgets/car_landing_no_internet_widget.dart';

const String _kOtaCarDriverAgeButton = "CarDriverAgeButton";
const String _kRecommendationButton = "CarRecommendationButton";
const String _kBannerType = "CAR_LANDING";
const String _kOtaTextSearchButton = "ota_text_search_button";
const String _kOtaAppBar = "OtaAppBarButton";
const int _kTime = 100;
const String _serviceType = "CARRENTAL";
const String _dataSearchType = "PLAYLIST";
const String _kServiceTypeCar = 'CARRENTAL_LANDING';
const int _kRecentCardsLimit = 20;
const double _kDefaultOpacity = 0.6;

class CarLandingScreen extends StatefulWidget {
  const CarLandingScreen({Key? key}) : super(key: key);

  @override
  CarLandingScreenState createState() => CarLandingScreenState();
}

class CarLandingScreenState extends State<CarLandingScreen>
    with SingleTickerProviderStateMixin {
  final CarLandingBloc _carLandingBloc = CarLandingBloc();
  final CarRecommendedLocationBloc _carRecommendedLocationBloc =
      CarRecommendedLocationBloc();
  AnimationController? _animationController;
  late Animation _circleAnimation;
  final BannerBloc _bannerBloc = BannerBloc();
  InternetConnectionInfo? internetConnectionInfo = InternetConnectionInfoImpl();

  @override
  void initState() {
    super.initState();
    // _carLandingBloc.stream.listen((event) {
    //   if (_carLandingBloc.state.carLandingViewModelState ==
    //       CarLandingViewModelState.failureNetwork) {
    //     OtaNoInternetAlertDialog().showAlertDialog(context);
    //   }
    // });
    FirebaseHelper.startCapturingEvent(FirebaseEvent.carSearchInput);
    _carRecommendedLocationBloc.stream.listen((event) {
      if (_carRecommendedLocationBloc.state.recommendationsState ==
          CarRecommendedLocationModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (_carRecommendedLocationBloc.state.recommendationsState ==
          CarRecommendedLocationModelState.success) {
        _getCarLandingFirebaseEvents(FirebaseEvent.carLanding);
      }
    });
    requestBannerData();
    _carRecommendedLocationBloc.getCarRecommendations(_kServiceTypeCar);
    _getRecentSearchData();
  }

  _setupSwitchButton() {
    if (_animationController == null) {
      CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel =
          Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: _kTime));
      _circleAnimation = AlignmentTween(
              begin: carDatesLocationUpdateViewModel.isDifferentDropOff
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              end: carDatesLocationUpdateViewModel.isDifferentDropOff
                  ? Alignment.centerLeft
                  : Alignment.centerRight)
          .animate(CurvedAnimation(
              parent: _animationController!, curve: Curves.linear));
    }
  }

  _getRecentSearchData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LoginModel loginModel = Provider.of<LoginModel>(context, listen: false);
      if (loginModel.userType == UserType.loggedInUser) {
        _carLandingBloc.getRecentSearches(_serviceType, _dataSearchType);
      }
    });
  }

  @override
  void dispose() {
    _carLandingBloc.dispose();
    _carRecommendedLocationBloc.dispose();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupSwitchButton();
    return BlocBuilder(
      bloc: _carLandingBloc,
      builder: () {
        if (_carRecommendedLocationBloc.state.recommendationsState ==
            CarRecommendedLocationModelState.failureNetwork) {
          return _buildNoInternetBody();
        }
        return _successBody();
      },
    );
  }

  Widget _successBody() {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: _kDefaultOpacity,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.gradient1,
              ),
              child: _appBar(true),
            ),
          ),
          Consumer<CarDatesLocationUpdateViewModel>(
            builder: (BuildContext context,
                CarDatesLocationUpdateViewModel value, Widget? child) {
              return SafeArea(
                bottom: false,
                child: Container(
                  margin: const EdgeInsets.only(top: kSize54),
                  decoration: const BoxDecoration(
                    color: AppColors.kTrueWhite,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(kSize20),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(top: kSize8),
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kSize24),
                        child: CarLandingLocationWidget(
                          carLandingBloc: _carLandingBloc,
                          carDatesLocationUpdateViewModel: value,
                          isLanding: true,
                        ),
                      ),
                      if (_carLandingBloc.state.carRentalType ==
                          CarRentalType.carRent)
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kSize24),
                          child: CarLandingDifferentDropToggle(
                            onTap: () {
                              if (value.isDifferentDropOff) {
                                CarSearchResultFirebase.searchDropKey =
                                    CarSearchResultFirebase.searchPickKey;
                              } else {
                                CarSearchResultFirebase.searchDropKey = "";
                              }
                              if (_animationController!.isCompleted) {
                                _animationController!.reverse();
                              } else {
                                _animationController!.forward();
                              }
                              if (value.isFromRecentSearch) {
                                value.updateIsDifferentDropOff(
                                    !value.isRecentDifferentDropOff);
                              } else {
                                value.updateIsDifferentDropOff(
                                    !value.isDifferentDropOff);
                              }
                            },
                            animationController: _animationController!,
                            circleAnimation: _circleAnimation,
                          ),
                        ),
                      BlocBuilder(
                          bloc: _carLandingBloc,
                          builder: () {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSize24),
                              child: CarDateTimePicker(
                                value: value,
                                isLanding: true,
                              ),
                            );
                          }),
                      if (_carLandingBloc.state.carRentalType ==
                          CarRentalType.carRent)
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kSize24),
                          child: CarLandingDriverAge(
                            key: const Key(_kOtaCarDriverAgeButton),
                            value: value,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSize24, vertical: kSize24),
                        child: OtaTextButton(
                          key: const Key(_kOtaTextSearchButton),
                          title: getTranslated(context,
                              AppLocalizationsStrings.accommodationSearch),
                          isDisabled: !_carLandingBloc.enableSearchButton(value,
                              isLanding: true),
                          onPressed: () {
                            CarSearchParametersFirebase.isFromSearch = true;
                            if (CarSearchParametersFirebase.isFromSearch) {
                              _getSearchFirebaseEvents(
                                  FirebaseEvent.carSearchInput, value);
                            }
                            _navigateToSearchResultScreen(value);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kSize24),
                        child: OtaHorizontalDivider(
                          height: kSize1,
                          dividerColor: AppColors.kGrey10,
                        ),
                      ),
                      _getBanners(),
                      _buildRecommendedLocationWidget(value),
                      const SizedBox(height: kSize19),
                      _showRecentSearchCards(),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  OtaAppBar _appBar(bool isWhiteBack) {
    return OtaAppBar(
      key: const Key(_kOtaAppBar),
      title: getTranslated(context, AppLocalizationsStrings.carRentalText),
      titleColor: isWhiteBack ? AppColors.kWhiteColor : AppColors.kGrey70,
      backButtonColor: isWhiteBack ? AppColors.kWhiteColor : AppColors.kGrey70,
      backgroundColor: isWhiteBack ? Colors.transparent : Colors.white,
      onLeftButtonPressed: () {
        CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel =
            Provider.of<CarDatesLocationUpdateViewModel>(context,
                listen: false);
        carDatesLocationUpdateViewModel.resetValues();
        Navigator.pop(context);
      },
    );
  }

  Widget _buildNoInternetBody() {
    return Scaffold(
      appBar: _appBar(false),
      body: CarLandingErrorWidget(
        height: MediaQuery.of(context).size.height - kSize100,
        onRefresh: () async {
          await _carRecommendedLocationBloc
              .getCarRecommendations(_kServiceTypeCar);
          await _carLandingBloc.getRecentSearches(
              _serviceType, _dataSearchType);
        },
      ),
    );
  }

  Widget _getBanners() {
    return BlocBuilder(
        bloc: _bannerBloc,
        builder: () {
          return _bannerBloc.state.bannerViewModelState ==
                  BannerViewModelState.success
              ? Padding(
                  padding: const EdgeInsets.only(top: kSize23),
                  child: BannerWidget(
                    bannerList: _bannerBloc.state.data,
                    launchBannerInApp: true,
                    onBannerTap: (index) {
                      _getBannerFirebaseEvents(_bannerBloc.state.data[index],
                          FirebaseEvent.carBanner, index);
                    },
                  ),
                  //TODO-tag merge
                )
              : const SizedBox.shrink();
        });
  }

  Future<void> requestBannerData() {
    return _bannerBloc.getBannerData(_kBannerType);
  }

  _goToCarSearchResult(CarDatesLocationUpdateViewModel value) async {
    value.updateisFromRecentSearch(false);
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    if (CarSearchDBHelper.getCarRecentSearchData().length <=
            _kRecentCardsLimit &&
        loginModel.userType == UserType.guestUser) {
      saveSearchDataToLocal(value);
    }
    await Navigator.of(context).pushNamed(
      AppRoutes.carSearchResult,
      arguments: CarSearchResultArgumentModel(
        staticSearchValue: StaticFilterValue(userId: 'userId'),
        landingFilterValue: LandingFilterValue(
          pickupLocationId: value.pickupLocation?.locationId ?? "",
          returnLocationId: value.isDifferentDropOff
              ? value.dropOffLocation?.locationId
              : value.pickupLocation?.locationId,
          pickupLocation: value.pickupLocation?.location ?? "",
          returnLocation: value.isDifferentDropOff
              ? value.dropOffLocation?.location
              : value.pickupLocation?.location,
          age: value.age,
          includeDriver: _carLandingBloc.state.carRentalType ==
              CarRentalType.carRentWithDriver,
        ),
      ),
    );

    if (value.isDifferentDropOff) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
    value.updateisFromRecentSearch(false);
    if (loginModel.userType == UserType.loggedInUser) {
      if (await internetConnectionInfo?.isConnected ?? false) {
        _carLandingBloc.getRecentSearches(_serviceType, _dataSearchType);
      }
    }
  }

  saveSearchDataToLocal(CarDatesLocationUpdateViewModel value) {
    CarRecentSearchData carRecentSearchData = CarRecentSearchData(
        isSearchSave: false,
        returnLocationId: value.isDifferentDropOff
            ? value.dropOffLocation?.locationId ?? ''
            : value.pickupLocation?.locationId ?? '',
        pickupLocationId: value.pickupLocation?.locationId ?? "",
        returnTime: Helpers.gethhmmss(value.dropOffDate),
        pickupTime: Helpers.gethhmmss(value.pickupDate),
        pickupDate: Helpers.getYYYYmmddFromDateTime(value.pickupDate),
        returnDate: Helpers.getYYYYmmddFromDateTime(value.dropOffDate),
        includeDriver: _carLandingBloc.state.carRentalType ==
            CarRentalType.carRentWithDriver,
        age: value.age,
        dataSearchType: _dataSearchType,
        pickupLocationName: value.pickupLocation?.location ?? "",
        languageCode: AppConfig().appLocale.languageCode,
        returnLocationName: (value.isDifferentDropOff
                ? value.dropOffLocation?.location
                : value.pickupLocation?.location) ??
            "");

    CarSearchDBHelper.saveCarRecentSearchData(carRecentSearchData);
  }

  getTimeFromDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  void _navigateToSearchResultScreen(CarDatesLocationUpdateViewModel value) {
    if (_carLandingBloc.enableSearchButton(value)) {
      _goToCarSearchResult(value);
    }
  }

  Widget _buildRecommendedLocationWidget(
      CarDatesLocationUpdateViewModel value) {
    return BlocBuilder(
      bloc: _carRecommendedLocationBloc,
      builder: () {
        if (_carRecommendedLocationBloc.isSuccess &&
            !_carRecommendedLocationBloc.isRecommendationsEmpty) {
          final recommendationList =
              _carRecommendedLocationBloc.state.recommendedLocationList;
          return Padding(
            key: const Key(_kRecommendationButton),
            padding: const EdgeInsets.only(top: kSize24),
            child: CarRecommendedLocationsWidget(
              recommendedLocationList:
                  _carRecommendedLocationBloc.state.recommendedLocationList,
              recommendedLocationTitle: getTranslated(
                  context, AppLocalizationsStrings.recommendedCarRentalAreas),
              key: const Key(_kRecommendationButton),
              onTap: (index) {
                _getCarLocationRecommendationFirebaseEvents(
                    FirebaseEvent.carLocationRecommendation,
                    recommendationList[index]);
                Navigator.pushNamed(
                  context,
                  AppRoutes.carSearchPickUpPointsScreen,
                  arguments: CarSearchArgumentModel(
                    isLanding: true,
                    carLandingBloc: _carLandingBloc,
                    cityId: recommendationList[index].cityId,
                    isDifferentDropOff: value.isDifferentDropOff,
                    locationName: recommendationList[index].searchKey,
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildRecentSearchCards(CarDatesLocationUpdateViewModel value) {
    return BlocBuilder(
        bloc: _carLandingBloc,
        builder: () {
          if (_carLandingBloc.isSuccess ||
              CarSearchDBHelper.getCarRecentSearchData().isNotEmpty) {
            final recentSearchListRemote =
                _carLandingBloc.state.carRecentSearchList;
            final recentSearchListLocal = CarSearchDBHelper
                    .getCarRecentSearchData()
                .map((e) => search_model.CarRecentSearchList.fromMap(e.toMap()))
                .toList();
            List<CarRecentSearchListViewModel> recentSearchViewListLocal =
                recentSearchListLocal
                    .map((e) =>
                        CarRecentSearchListViewModel.fromCarRecentModel(e))
                    .toList();
            List<CarRecentSearchListViewModel> appendedList = [
              ...recentSearchViewListLocal.reversed,
              if (recentSearchListRemote != null) ...recentSearchListRemote
            ].cast<CarRecentSearchListViewModel>();

            return CarRecentlyViewedCards(
                carRecentSearchList: appendedList,
                onClearConfirm: () => {
                      _carLandingBloc.clearRecentSearches(
                          _serviceType, _dataSearchType),
                      CarSearchDBHelper.removeAll()
                    },
                onPress: (index) => {
                      _getPlayListFirebaseEvents(FirebaseEvent.carPlayList,
                          appendedList[index], value),
                      _moveToSearchScreen(appendedList[index], value),
                    });
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _buildRecentSearchCardsGuestUser(
      CarDatesLocationUpdateViewModel value) {
    if (CarSearchDBHelper.getCarRecentSearchData().isNotEmpty) {
      return ValueListenableBuilder<Box<CarRecentSearchData>>(
          valueListenable: OTAHiveBoxes.getRecentSearches().listenable(),
          builder: (_, box, child) {
            final recentSearchList = CarSearchDBHelper.getCarRecentSearchData()
                .map((e) => search_model.CarRecentSearchList.fromMap(e.toMap()))
                .toList();
            List<CarRecentSearchListViewModel> recentSearchViewList =
                recentSearchList
                    .map((e) =>
                        CarRecentSearchListViewModel.fromCarRecentModel(e))
                    .toList();
            return CarRecentlyViewedCards(
                carRecentSearchList: recentSearchViewList.reversed.toList(),
                onClearConfirm: () {
                  CarSearchDBHelper.removeAll();
                  setState(() {});
                },
                onPress: (index) => {
                      _getPlayListFirebaseEvents(FirebaseEvent.carPlayList,
                          recentSearchViewList[index], value),
                      _moveToSearchScreen(recentSearchViewList[index], value),
                    });
          });
    } else {
      return const SizedBox();
    }
  }

  void _moveToSearchScreen(CarRecentSearchListViewModel recentSearchList,
      CarDatesLocationUpdateViewModel value) async {
    CarSearchParametersFirebase.isFromSearch = true;
    _getCarSearchInputFirebaseParameters(
        FirebaseEvent.carSearchInput, recentSearchList, value);
    value.updateisFromRecentSearch(true);
    LocationModel pickupLocationModel = LocationModel();
    pickupLocationModel.location = recentSearchList.pickupLocationName;
    pickupLocationModel.locationId = recentSearchList.pickupLocationId;
    LocationModel returnLocationModel = LocationModel();
    returnLocationModel.location = recentSearchList.returnLocationName;
    returnLocationModel.locationId = recentSearchList.returnLocationId;
    value.updateCarLocationRecentSearch(
        locationModelPickup: pickupLocationModel,
        locationModelDropOff: returnLocationModel);
    value.updateRecentAge(recentSearchList.age ?? 0);
    value.updateCarDateRecentSearch(
        StringToDate.getDateFromString(recentSearchList.pickupDate ?? '',
            recentSearchList.pickupTime ?? ''),
        StringToDate.getDateFromString(recentSearchList.returnDate ?? '',
            recentSearchList.returnTime ?? ''));
    if (recentSearchList.returnLocationName != null &&
        recentSearchList.returnLocationName!.isNotEmpty) {
      value.updateIsRecentDifferentDropOff(true);
    }

    await Navigator.of(context).pushNamed(
      AppRoutes.carSearchResult,
      arguments: CarSearchResultArgumentModel(
        staticSearchValue: StaticFilterValue(userId: 'userId'),
        landingFilterValue: LandingFilterValue(
          pickupLocationId: recentSearchList.pickupLocationId ?? "",
          returnLocationId: recentSearchList.returnLocationName != null
              ? recentSearchList.returnLocationId
              : recentSearchList.pickupLocationId,
          pickupLocation: recentSearchList.pickupLocationName,
          returnLocation: recentSearchList.returnLocationName ??
              recentSearchList.pickupLocationName,
          age: recentSearchList.age,
          includeDriver: _carLandingBloc.state.carRentalType ==
              CarRentalType.carRentWithDriver,
        ),
      ),
    );
    value.updateisFromRecentSearch(false);
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    if (loginModel.userType == UserType.loggedInUser) {
      if (await internetConnectionInfo?.isConnected ?? false) {
        _carLandingBloc.getRecentSearches(_serviceType, _dataSearchType);
      }
    }
  }

  _showRecentSearchCards() {
    LoginModel loginModel = Provider.of<LoginModel>(context, listen: false);
    CarDatesLocationUpdateViewModel value =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);

    if (loginModel.userType == UserType.loggedInUser) {
      return _buildRecentSearchCards(value);
    } else {
      return _buildRecentSearchCardsGuestUser(value);
    }
  }

  _getCarLandingFirebaseEvents(String eventName) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addCommaSeparatedList(
        value: _carRecommendedLocationBloc.state.recommendedLocationList
            .map((e) => e.cityId)
            .toList(),
        key: CarLandingParametersFirebase.allRecommendationIdSequence);
    logger.publishToSuperApp(eventName);
  }

  _getCarLocationRecommendationFirebaseEvents(String eventName,
      CarRecommendedLocationModel carRecommendedLocationModel) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: carRecommendedLocationModel.cityId,
        key: CarRecommendationLocationFirebase.recommendationLocationId);
    logger.addKeyValue(
        value: carRecommendedLocationModel.placeName,
        key: CarRecommendationLocationFirebase.recommendationLocationName);
    logger.addCommaSeparatedList(
        value: _carRecommendedLocationBloc.state.recommendedLocationList
            .map((e) => e.cityId)
            .toList(),
        key: CarRecommendationLocationFirebase.allRecommendlocationIdSequence);
    logger.publishToSuperApp(eventName);
  }

  _getPlayListFirebaseEvents(
      String eventName,
      CarRecentSearchListViewModel carRecentSearchListViewModel,
      CarDatesLocationUpdateViewModel value) {
    _updatePickupReturnDateTime(carRecentSearchListViewModel, value);
    CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel =
        Provider.of<CarDatesLocationUpdateViewModel>(
            GlobalKeys.navigatorKey.currentContext!,
            listen: false);
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addDateTimeValue(
        value: carDatesLocationUpdateViewModel.recentSearchPickupDate,
        key: CarPlayListFirebase.carPickupDatetime);
    logger.addDateTimeValue(
        value: carDatesLocationUpdateViewModel.recentSearchDropOffDate,
        key: CarPlayListFirebase.carReturnDatetime);
    logger.addKeyValue(
        value: carRecentSearchListViewModel.pickupLocationName,
        key: CarPlayListFirebase.carPickupLocation);
    logger.addKeyValue(
        value: carRecentSearchListViewModel.returnLocationName,
        key: CarPlayListFirebase.carReturnLocation);
    logger.addIntValue(
        value: carRecentSearchListViewModel.age,
        key: CarPlayListFirebase.carDriverAge);
    logger.publishToSuperApp(eventName);
  }

  _updatePickupReturnDateTime(
      CarRecentSearchListViewModel carRecentSearchListViewModel,
      CarDatesLocationUpdateViewModel value) {
    value.updateCarDateRecentSearch(
        StringToDate.getDateFromString(
            carRecentSearchListViewModel.pickupDate ?? '',
            carRecentSearchListViewModel.pickupTime ?? ''),
        StringToDate.getDateFromString(
            carRecentSearchListViewModel.returnDate ?? '',
            carRecentSearchListViewModel.returnTime ?? ''));
  }

  _getSearchFirebaseEvents(String eventName,
      CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel) {
    FirebaseHelper.addKeyValue(
        key: CarSearchParametersFirebase.carPickupLocation,
        value: carDatesLocationUpdateViewModel.pickupLocation?.location,
        eventName: eventName);
    FirebaseHelper.addKeyValue(
        key: CarSearchParametersFirebase.carReturnLocation,
        value: carDatesLocationUpdateViewModel.isDifferentDropOff
            ? carDatesLocationUpdateViewModel.dropOffLocation?.location
            : carDatesLocationUpdateViewModel.pickupLocation?.location,
        eventName: eventName);
    FirebaseHelper.addIntValue(
        key: CarSearchParametersFirebase.carPickupReturnDiffLocation,
        value: carDatesLocationUpdateViewModel.isDifferentDropOff ? 1 : 0,
        eventName: eventName);
    FirebaseHelper.addDateTimeValue(
        key: CarSearchParametersFirebase.carPickupDatetime,
        value: carDatesLocationUpdateViewModel.pickupDate,
        eventName: eventName);
    FirebaseHelper.addDateTimeValue(
        key: CarSearchParametersFirebase.carReturnDatetime,
        value: carDatesLocationUpdateViewModel.dropOffDate,
        eventName: eventName);
    FirebaseHelper.addIntValue(
        key: CarSearchParametersFirebase.carDriverAge,
        value: carDatesLocationUpdateViewModel.age,
        eventName: eventName);
  }

  _getBannerFirebaseEvents(
      BannerDataModel bannerDataModel, String eventName, int index) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: bannerDataModel.bannerId,
        key: CarBannerParametersFirebase.bannerId);
    logger.addKeyValue(
        value: bannerDataModel.function,
        key: CarBannerParametersFirebase.bannerSection);
    logger.addIntValue(
        value: index + 1, key: CarBannerParametersFirebase.bannerSequence);
    logger.addKeyValue(
        value: bannerDataModel.imageUrl,
        key: CarBannerParametersFirebase.bannerName);
    logger.addKeyValue(
        value: bannerDataModel.deepLinkUrl,
        key: CarBannerParametersFirebase.bannerUrl);
    logger.addKeyValue(
        value: bannerDataModel.deepLinkUrl,
        key: CarBannerParametersFirebase.bannerUrl);
    logger.addCommaSeparatedList(
        value: _bannerBloc.state.data.map((e) => e.bannerId).toList(),
        key: CarBannerParametersFirebase.allBannerIdSequence);
    logger.publishToSuperApp(eventName);
  }

  _getCarSearchInputFirebaseParameters(
      String eventName,
      CarRecentSearchListViewModel recentSearchList,
      CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel) {
    FirebaseHelper.addKeyValue(
        key: CarSearchParametersFirebase.carPickupLocation,
        value: recentSearchList.pickupLocationName,
        eventName: eventName);
    FirebaseHelper.addKeyValue(
        key: CarSearchParametersFirebase.carReturnLocation,
        value: recentSearchList.returnLocationName ??
            recentSearchList.pickupLocationName,
        eventName: eventName);
    FirebaseHelper.addIntValue(
        key: CarSearchParametersFirebase.carPickupReturnDiffLocation,
        value: recentSearchList.pickupLocationName !=
                recentSearchList.returnLocationName
            ? 1
            : 0,
        eventName: eventName);
    FirebaseHelper.addDateTimeValue(
        key: CarSearchParametersFirebase.carPickupDatetime,
        value: StringToDate.getDateFromString(recentSearchList.pickupDate ?? '',
            recentSearchList.pickupTime ?? ''),
        eventName: eventName);
    FirebaseHelper.addDateTimeValue(
        key: CarSearchParametersFirebase.carReturnDatetime,
        value: StringToDate.getDateFromString(recentSearchList.returnDate ?? '',
            recentSearchList.returnTime ?? ''),
        eventName: eventName);
    FirebaseHelper.addIntValue(
        key: CarSearchParametersFirebase.carDriverAge,
        value: recentSearchList.age,
        eventName: eventName);
  }
}
