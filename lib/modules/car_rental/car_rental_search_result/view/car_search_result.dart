import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_result_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_selected_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/bloc/car_search_result_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/helpers/car_search_result_helper.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/widget/car_custom_error_widget.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/widget/car_search_result_tile.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/loading/view/loading_screen.dart';
import 'package:provider/provider.dart';

import '../view_model/car_dates_location_update_view_model.dart';

const double _kTopHeight = 180;
const String _kServiceName = "CARRENTAL";
const String _kDataSearchType = "PLAYLIST";
const String _kCarSearchResultListKey = "car_search_result_list_key";
const String _sortingMode = "rbh_suggest";

class CarSearchResult extends StatefulWidget {
  const CarSearchResult({Key? key}) : super(key: key);

  @override
  CarSearchResultState createState() => CarSearchResultState();
}

class CarSearchResultState extends State<CarSearchResult> {
  final CarSearchResultBloc _carSearchResultBloc = CarSearchResultBloc();
  CarSearchResultArgumentModel? _arguments;
  bool _isSplashLoaded = false;
  bool _isScrolling = false;
  FirebaseLogger firebaseLogger = FirebaseLogger();

  @override
  void dispose() {
    _carSearchResultBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _arguments = ModalRoute.of(context)?.settings.arguments
          as CarSearchResultArgumentModel;
      _getCarSearchData();
      _clearFilterLists();
    });
    _carSearchResultBloc.stream.listen((event) {
      OtaDialogLoader().hideLoader(context);
      if (_carSearchResultBloc.state.pageState ==
              CarSearchResultPageState.success &&
          (_carSearchResultBloc.state.carSearchResult?.carModelList?.length ??
                  0) <=
              20) {
        getSearchResultCount(FirebaseEvent.carSearchInput,
            _carSearchResultBloc.state.carSearchResult?.carModelList);
        _launchFirebaseViewEvent();
      }
      if (_carSearchResultBloc.state.pageState ==
          CarSearchResultPageState.filterLoading) {
        OtaDialogLoader().showLoader(context);
      } else if (_carSearchResultBloc.state.pageState ==
              CarSearchResultPageState.failureNetwork &&
          !event.isInternetFailurePopUpShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _carSearchResultBloc.setInternetFailurePopUpShown();
      }
    });
  }

  _onScrollStart(ScrollMetrics metrics) {
    setState(() {
      _isScrolling = false;
    });
  }

  _onScrollUpdate(ScrollMetrics metrics) {
    setState(() {
      _isScrolling = true;
    });
  }

  _onScrollEnd(ScrollMetrics metrics) {
    setState(() {
      _isScrolling = false;
    });
  }

  _getCarSearchData({bool isFilterLoading = false}) async {
    CarDatesLocationUpdateViewModel value =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    await _carSearchResultBloc.getCarSearchResult(
        _arguments!,
        value.isFromRecentSearch
            ? value.recentSearchPickupDate
            : value.pickupDate,
        value.isFromRecentSearch
            ? value.recentSearchDropOffDate
            : value.dropOffDate,
        value.isFromRecentSearch
            ? value.recentSearchPickupLocation
            : value.pickupLocation,
        _getLocation(value),
        _kDataSearchType,
        _sortingMode,
        isFilterLoading: isFilterLoading,
        isSearchSave: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _carSearchResultBloc,
      builder: () {
        if (_carSearchResultBloc.state.pageState ==
                CarSearchResultPageState.loading &&
            _carSearchResultBloc.pageNumber == 1 &&
            !_isSplashLoaded) {
          _isSplashLoaded = true;
          return const LoadingScreen(_kServiceName);
        }
        return Consumer<CarDatesLocationUpdateViewModel>(builder:
            (BuildContext context, CarDatesLocationUpdateViewModel value,
                Widget? child) {
          return Scaffold(
            appBar: _buildAppBar(value),
            body: _buildBody(),
          );
        });
      },
    );
  }

  PreferredSizeWidget _buildAppBar(CarDatesLocationUpdateViewModel value) {
    bool isOtaLandingSearch = _arguments?.isOtaLandingSearch ?? false;
    String selectedLocation = isOtaLandingSearch
        ? _arguments?.landingFilterValue?.pickupLocation ?? ''
        : value.isFromRecentSearch
            ? value.recentSearchPickupLocation?.location ?? ''
            : value.pickupLocation?.location ?? '';
    String selectedDate = "${Helpers.getddMMMMyyhhmm(
      value.isFromRecentSearch
          ? value.recentSearchPickupDate
          : value.pickupDate,
    )} - ${Helpers.getddMMMMyyhhmm(
      value.isFromRecentSearch
          ? value.recentSearchDropOffDate
          : value.dropOffDate,
    )}";

    return OtaAppBar(
      isElevation: _isScrolling,
      actions: const [OtaAppBarAction.backButton, OtaAppBarAction.filterButton],
      isCenterTitle: false,
      titleWidget: Text(
        selectedLocation,
        style: AppTheme.kBodyMedium,
      ),
      subTitleWidget: Text(
        selectedDate,
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
      ),
      onFilterButterPressed: () {
        if (_carSearchResultBloc.state.carSearchResult?.carModelList != null &&
            _carSearchResultBloc
                .state.carSearchResult!.carModelList!.isNotEmpty) {
          _navigateToFilterScreen();
        }
      },
      onSubtitlePressed: () => _showEditSearchScreen(context, value),
    );
  }

  Widget _buildBody() {
    if (_carSearchResultBloc.state.carSearchResult?.carModelList?.isNotEmpty ??
        false) {
      return _buildSuccessView();
    } else {
      if (_carSearchResultBloc.state.pageState ==
              CarSearchResultPageState.failure ||
          _carSearchResultBloc.state.pageState ==
                  CarSearchResultPageState.failureNetwork &&
              (_carSearchResultBloc
                      .state.carSearchResult?.carModelList?.isEmpty ??
                  true)) {
        return OtaNetworkErrorWidgetWithRefresh(
          onRefresh: () => _onRefresh(),
          height: MediaQuery.of(context).size.height - _kTopHeight,
        );
      } else if (_carSearchResultBloc.state.pageState ==
          CarSearchResultPageState.loading) {
        return const OTALoadingIndicator();
      } else {
        return CarCustomErrorWidgetWithRefresh(
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () => _onRefresh(),
          errorTextFooter:
              getTranslated(context, AppLocalizationsStrings.noSearchResultMsg),
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
        );
      }
    }
  }

  Widget _buildSuccessView() {
    List<CarSearchDetailModel> carModelList =
        _carSearchResultBloc.state.carSearchResult?.carModelList ?? [];
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          _onScrollStart(notification.metrics);
        } else if (notification is ScrollUpdateNotification) {
          _onScrollUpdate(notification.metrics);
        } else if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;
          if (metrics.atEdge) {
            bool isTop = metrics.pixels == 0;
            if (isTop) {
              _onScrollEnd(notification.metrics);
            }
          }
        }
        return false;
      },
      child: ListView.builder(
        key: const Key(_kCarSearchResultListKey),
        padding: const EdgeInsets.only(top: kSize16),
        itemBuilder: (context, index) {
          if (index == carModelList.length) {
            _getCarSearchData();
            if (!_carSearchResultBloc.state.isInternetFailurePopUpShown) {
              return const Center(
                child: SizedBox(
                  height: kSize52,
                  width: kSize52,
                  child: OTALoadingIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            CarSearchDetailModel? carModel = carModelList[index];
            return CarSearchResultTile(
              imageUrl: carModel.images?.full ?? '',
              craftType: carModel.carInfo?.carTypeName ?? '',
              brandName: carModel.brandName ?? '',
              carName: carModel.modelName ?? '',
              providerCount: carModel.numSuppliers ?? 0,
              startPrice: carModel.startingPrice ?? 0,
              promotionList: carModel.overlayPromotion,
              capsulePromotion: CarSearchResultHelper.getCapsulePromotionList(
                  carModel.capsulePromotion ?? []),
              onPressed: () {
                _launchFirebaseClickEvent(carModel);
                _navigateToCarSupplierScreen(carModel);
              },
            );
          }
        },
        itemCount:
            carModelList.length + (_carSearchResultBloc.pageNumber > 0 ? 1 : 0),
      ),
    );
  }

  void _navigateToCarSupplierScreen(CarSearchDetailModel carModel) {
    CarDatesLocationUpdateViewModel dateUpdate =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    CarSupplierArgumentViewModel argumentModel = CarSupplierArgumentViewModel();
    dateUpdate.checkIfDropOffAndPickUpSame();
//TODO-3
    if (_arguments != null) {
      argumentModel = CarSupplierArgumentViewModel(
        pickupLocationId: dateUpdate.isFromRecentSearch
            ? dateUpdate.recentSearchPickupLocation?.locationId
            : dateUpdate.pickupLocation?.locationId,
        returnLocationId: _returnLocationId(dateUpdate),
// =======
//     CarSupplierArgumentViewModel argumentModel = CarSupplierArgumentViewModel();
//     if (_arguments != null) {
//       argumentModel = CarSupplierArgumentViewModel(
//         pickupLocationId: dateUpdate.pickupLocation?.locationId,
//         returnLocationId: dateUpdate.dropOffLocation?.locationId ??
//             dateUpdate.pickupLocation?.locationId,
// >>>>>>> 1e99ad27a (develop-1 Flutter 3.0 upgrade)
        pickupLocation: _arguments?.landingFilterValue?.pickupLocation,
        returnLocation: _arguments?.landingFilterValue?.returnLocation,
        pickupDate: dateUpdate.isFromRecentSearch
            ? dateUpdate.recentSearchPickupDate
            : dateUpdate.pickupDate,
        returnDate: dateUpdate.isFromRecentSearch
            ? dateUpdate.recentSearchDropOffDate
            : dateUpdate.dropOffDate,
        carId: carModel.carId,
        includeDriver:
            _arguments?.landingFilterValue?.includeDriver == true ? 'Y' : 'N',
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: _arguments?.landingFilterValue?.age,
        brandName: carModel.brandName,
        craftType: carModel.carInfo?.carTypeName,
        thumbImage: carModel.images?.thumb,
        carName: carModel.modelName,
      );
    }
    Navigator.pushNamed(
      context,
      AppRoutes.carSupplierScreen,
      arguments: argumentModel,
    );
  }

  Future<void> _onRefresh() async {
    _carSearchResultBloc.updatePageNumber(1);
    _carSearchResultBloc.state.isInternetFailurePopUpShown = false;
    await _getCarSearchData();
  }

  _navigateToFilterScreen() async {
    CarSearchParametersFirebase.isFromSearch = false;
    var data = await Navigator.of(context).pushNamed(
      AppRoutes.carSearchFilter,
      arguments: CarSearchFilterArgumentViewModel(
        availableFilterViewModel: _carSearchResultBloc
            .state.carSearchResult?.availableFilterViewModel,
        selectedFilter: _arguments?.filterValue,
      ),
    );
    if (data != null) {
      _arguments?.filterValue = data as FilterValue;
      _carSearchResultBloc.updatePageNumber(1);
      _getCarSearchData(isFilterLoading: true);
    }
  }

  _showEditSearchScreen(
      BuildContext context, CarDatesLocationUpdateViewModel dateUpdate) async {
    CarSearchParametersFirebase.isFromSearch = true;
    var data = await Navigator.pushNamed(context, AppRoutes.editSearchScreen);
    if (data != null) {
      if (data as bool) {
        _getSearchData();
      }
    }
  }

  _getSearchData() {
    _carSearchResultBloc.updatePageNumber(1);
    _getCarSearchData(isFilterLoading: true);
  }

  LocationModel? _getLocation(CarDatesLocationUpdateViewModel value) {
    if (value.isFromRecentSearch) {
      return value.recentSearchDropOffLocation;
    } else {
      if (value.isDifferentDropOff) {
        return value.dropOffLocation;
      } else {
        return value.pickupLocation;
      }
    }
  }

  void _getFirebaseViewParameters() {
    CarDatesLocationUpdateViewModel value =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carKeywordPickUp,
        value: CarSearchResultFirebase.searchPickKey);
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carKeywordDropOff,
        value: value.isDifferentDropOff == true
            ? CarSearchResultFirebase.searchDropKey
            : "");
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carPickUpLocation,
        value: _arguments?.landingFilterValue?.pickupLocation);
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carDropOffLocation,
        value: _arguments?.landingFilterValue?.returnLocation);
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carIsDifferentDropOff,
        value: value.isDifferentDropOff == true ? "1" : "0");
    firebaseLogger.addDateTimeValue(
        key: CarSearchResultFirebase.carPickUpDateTime,
        value: value.isFromRecentSearch
            ? value.recentSearchPickupDate
            : value.pickupDate);
    firebaseLogger.addDateTimeValue(
        key: CarSearchResultFirebase.carReturnUpDateTime,
        value: value.isFromRecentSearch
            ? value.recentSearchDropOffDate
            : value.dropOffDate);
    firebaseLogger.addIntValue(
        key: CarSearchResultFirebase.carDriverAge,
        value: _arguments?.landingFilterValue?.age);
    firebaseLogger.addKeyValue(
        key: CarSearchResultFirebase.carIsSearchSuccess,
        value: _carSearchResultBloc
                    .state.carSearchResult?.carModelList?.isNotEmpty ??
                false
            ? "1"
            : "0");
    firebaseLogger.addDoubleValue(
        key: CarSearchResultFirebase.carFilterPriceMin,
        value: _arguments?.filterValue?.minPrice);
    firebaseLogger.addDoubleValue(
        key: CarSearchResultFirebase.carFilterPriceMax,
        value: _arguments?.filterValue?.maxPrice);

    firebaseLogger.addCommaSeparatedList(
      key: CarSearchResultFirebase.carFilterType,
      value: CarSearchResultFirebase.carTypeFilterList,
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchResultFirebase.carFilterBrand,
      value: CarSearchResultFirebase.brandFilterList,
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchResultFirebase.carFilterSupplier,
      value: CarSearchResultFirebase.supplierFilterList,
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchResultFirebase.carShow,
      value: _getCarIdsList(
          _carSearchResultBloc.state.carSearchResult?.carModelList),
    );
  }

  void _launchFirebaseViewEvent() {
    _getFirebaseViewParameters();
    firebaseLogger.publishToSuperApp(FirebaseEvent.carSearchResultEvent);
    CarSearchResultFirebase.searchKey = "";
  }

  void _getFirebaseClickParameters() {
    CarDatesLocationUpdateViewModel value =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carKeywordPickUp,
        value: CarSearchResultFirebase.searchPickKey);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carKeywordDropOff,
        value: value.isDifferentDropOff == true
            ? CarSearchResultFirebase.searchDropKey
            : "");
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carPickUpLocation,
        value: _arguments?.landingFilterValue?.pickupLocation);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carDropOffLocation,
        value: _arguments?.landingFilterValue?.returnLocation);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carIsDifferentDropOff,
        value: value.isDifferentDropOff == true ? "1" : "0");
    firebaseLogger.addDateTimeValue(
        key: CarSearchSelectedFirebase.carPickUpDateTime,
        value: value.isFromRecentSearch
            ? value.recentSearchPickupDate
            : value.pickupDate);
    firebaseLogger.addDateTimeValue(
        key: CarSearchSelectedFirebase.carReturnUpDateTime,
        value: value.isFromRecentSearch
            ? value.recentSearchDropOffDate
            : value.dropOffDate);
    firebaseLogger.addIntValue(
        key: CarSearchSelectedFirebase.carDriverAge,
        value: _arguments?.landingFilterValue?.age);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carIsSearchSuccess,
        value: _carSearchResultBloc
                    .state.carSearchResult?.carModelList?.isNotEmpty ??
                false
            ? "1"
            : "0");
    firebaseLogger.addDoubleValue(
        key: CarSearchSelectedFirebase.carFilterPriceMin,
        value: _arguments?.filterValue?.minPrice);
    firebaseLogger.addDoubleValue(
        key: CarSearchSelectedFirebase.carFilterPriceMax,
        value: _arguments?.filterValue?.maxPrice);

    firebaseLogger.addCommaSeparatedList(
      key: CarSearchSelectedFirebase.carFilterType,
      value: CarSearchResultFirebase.carTypeFilterList,
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchSelectedFirebase.carFilterBrand,
      value: CarSearchResultFirebase.brandFilterList,
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchSelectedFirebase.carFilterSupplier,
      value: CarSearchResultFirebase.supplierFilterList,
    );
  }

  void _launchFirebaseClickEvent(CarSearchDetailModel model) {
    _getFirebaseClickParameters();
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carModelId, value: model.brandId);
    firebaseLogger.addKeyValue(
        key: CarSearchSelectedFirebase.carModelName, value: model.modelName);
    firebaseLogger.addDoubleValue(
        key: CarSearchSelectedFirebase.carStartPrice,
        value: model.startingPrice);

    firebaseLogger.addIntValue(
        key: CarSearchSelectedFirebase.carSequence, value: model.sortSequence);

    firebaseLogger.addCommaSeparatedList(
      key: CarSearchSelectedFirebase.carPromotionTag,
      value: model.capsulePromotion?.map((e) => e.name ?? "").toList() ?? [],
    );
    firebaseLogger.addCommaSeparatedList(
      key: CarSearchSelectedFirebase.carShow,
      value: _getCarIdsList(
          _carSearchResultBloc.state.carSearchResult?.carModelList),
    );

    firebaseLogger.publishToSuperApp(FirebaseEvent.carSelectSearchResultEvent);
    CarSearchResultFirebase.searchKey = "";
  }

  getSearchResultCount(
      String eventName, List<CarSearchDetailModel>? carSearchResultModel) {
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: CarSearchParametersFirebase.carSearchSuccess,
        value: carSearchResultModel != null
            ? carSearchResultModel.isEmpty
                ? 0
                : 1
            : 0);
    if (CarSearchParametersFirebase.isFromSearch) {
      FirebaseHelper.stopCapturingEvent(eventName);
    }
  }

  _returnLocationId(CarDatesLocationUpdateViewModel dateUpdate) {
    if (dateUpdate.isFromRecentSearch) {
      return dateUpdate.recentSearchDropOffLocation?.locationId;
    } else {
      if (dateUpdate.isDifferentDropOff) {
        return dateUpdate.dropOffLocation?.locationId;
      } else {
        return dateUpdate.pickupLocation?.locationId;
      }
    }
  }

  List<String> _getCarIdsList(
      List<CarSearchDetailModel>? carSearchResultModel) {
    List<String> listOfCarId = [];
    if (carSearchResultModel != null) {
      for (int i = 0; i < carSearchResultModel.length; i++) {
        listOfCarId.add(carSearchResultModel[i].carId ?? '');
      }
      return listOfCarId;
    }
    return [];
  }

  _clearFilterLists() {
    CarSearchResultFirebase.supplierFilterList.clear();
    CarSearchResultFirebase.brandFilterList.clear();
    CarSearchResultFirebase.carTypeFilterList.clear();
  }
}
