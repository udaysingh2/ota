import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_pick_up_points_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_network_error_widget_with_refresh.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_pickup_points_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/app_localization_strings.dart';
import '../../../../common/utils/app_theme.dart';
import '../../../../common/utils/consts.dart';
import '../../../../core/app_routes.dart';
import '../../../../core_pack/custom_widgets/ota_app_bar.dart';
import '../../../../core_pack/i18n/language_constants.dart';
import '../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import '../view_model/car_search_suggestion_model.dart';

const String _kSuggestionTileKey = 'car_search_suggestion_tile_widget_key';
const double _kLoaderWidth = 2.5;
const _kTopHeight = 180;

class CarSearchPickUpPointsScreen extends StatefulWidget {
  const CarSearchPickUpPointsScreen({Key? key}) : super(key: key);

  @override
  State<CarSearchPickUpPointsScreen> createState() =>
      _CarSearchPickUpPointsScreenState();
}

class _CarSearchPickUpPointsScreenState
    extends State<CarSearchPickUpPointsScreen> {
  final CarSearchPickUpPointsBloc _pickUpPointsBloc =
      CarSearchPickUpPointsBloc();

  CarSearchArgumentModel? _carSearchArgumentModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _carSearchArgumentModel = (ModalRoute.of(context)?.settings.arguments
          as CarSearchArgumentModel);
      _pickUpPointsBloc
          .fetchPickUpLocations(_carSearchArgumentModel?.locationName ?? "");
    });

    _pickUpPointsBloc.stream.listen((event) {
      if (_pickUpPointsBloc.state.carSearchPickUpPointsState ==
          CarSearchPickUpPointsState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _pickUpPointsBloc,
        builder: () {
          bool isPickUpAvailable = _pickUpPointsBloc.isStatePickUpsAvailable;
          bool isFailure = _pickUpPointsBloc.isStateFailure;
          bool isLoading = _pickUpPointsBloc.isStateLoading;
          return Scaffold(
            appBar: _buildAppBar(),
            body: isLoading
                ? Center(child: _buildProgressIndicator())
                : isPickUpAvailable
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: kSize24),
                            child: _buildTitleText(),
                          ),
                          _buildPickUpPointsList()
                        ],
                      )
                    : isFailure
                        ? Padding(
                            padding: const EdgeInsets.only(top: kSize24),
                            child: Material(
                              child: CarNetworkErrorWidgetWithRefresh(
                                height: MediaQuery.of(context).size.height -
                                    _kTopHeight,
                                onRefresh: () => _onRefresh(),
                              ),
                            ),
                          )
                        : const SizedBox(),
          );
        });
  }

  Future<void> _onRefresh() async {
    await _pickUpPointsBloc
        .fetchPickUpLocations(_carSearchArgumentModel?.locationName ?? "");
  }

  OtaAppBar _buildAppBar() {
    return OtaAppBar(
      title: _carSearchArgumentModel?.locationName,
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.customTrailingWidget
      ],
    );
  }

  Widget _buildTitleText() {
    bool isToggleOn = false;
    bool isRedirected = false;
    if (_carSearchArgumentModel != null) {
      if (_carSearchArgumentModel!.isDifferentDropOff ?? false) {
        isToggleOn = true;
      }
      if (_carSearchArgumentModel!.isRedirected ?? false) {
        isRedirected = true;
      }
    }
    return isToggleOn
        ? isRedirected
            ? Text(
                getTranslated(
                    context, AppLocalizationsStrings.selectDropOffPoint),
                style: AppTheme.kBodyMedium,
              )
            : Text(
                getTranslated(
                    context, AppLocalizationsStrings.selectPickUpPoint),
                style: AppTheme.kBodyMedium,
              )
        : Text(
            getTranslated(context, AppLocalizationsStrings.carSelectLocation),
            style: AppTheme.kBodyMedium,
          );
  }

  Widget _buildCarSuggestionTileWidget(Item suggestion, ServiceType type) {
    return CarSearchSuggestionTileWidget(
        key: const Key(_kSuggestionTileKey),
        title: suggestion.locationName?.trim() ?? '',
        serviceType: type,
        onSearchSuggestionTap: () {
          _pickUpPointsBloc.saveCarSearchHistoryData(
            CarSaveSearchHistoryViewArgumentModel.from(
              item: suggestion,
              serviceType: CarSearchSuggestionsHelper.getServiceType(type),
            ),
          );

          if (_carSearchArgumentModel != null) {
            if (_carSearchArgumentModel!.isPickUpUpdate == null) {
              if (_carSearchArgumentModel!.isDifferentDropOff ?? false) {
                if (_carSearchArgumentModel!.locationModel == null) {
                  _goToDropOffPointScreen(suggestion);
                } else {
                  _updatePickupAndDropOffInLandingScreen(suggestion);
                }
              } else {
                _goToLandingScreen(suggestion, true);
              }
            } else {
              _goToLandingScreen(
                  suggestion, _carSearchArgumentModel!.isPickUpUpdate!);
            }
          }
        });
  }

  _buildPickUpPointsList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _pickUpPointsBloc.pickUpPointsList.length,
          itemBuilder: (_, index) => _buildCarSuggestionTileWidget(
              _pickUpPointsBloc.pickUpPointsList[index], ServiceType.location)),
    );
  }

  Widget _buildProgressIndicator() {
    return Offstage(
      offstage: !_pickUpPointsBloc.isStateLoading,
      child: const SizedBox(
        height: kSize16,
        width: kSize16,
        child: CircularProgressIndicator(strokeWidth: _kLoaderWidth),
      ),
    );
  }

  _updatePickupAndDropOffInLandingScreen(Item suggestion) {
    LocationModel locationModel = LocationModel(
        location: suggestion.locationName, locationId: suggestion.id);
    Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false)
        .updateCarLocation(
            locationModelPickup: _carSearchArgumentModel!.locationModel!,
            locationModelDropOff: locationModel);

    Navigator.popUntil(
        context, (route) => route.settings.name == AppRoutes.carLandingScreen);
  }

  _goToLandingScreen(Item suggestion, bool isPickupLocationUpdate) {
    LocationModel locationModel = LocationModel(
        location: suggestion.locationName, locationId: suggestion.id);
    CarDatesLocationUpdateViewModel dateUpdate =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    if (isPickupLocationUpdate) {
      _updateLocations(isPickupLocationUpdate, locationModel, dateUpdate);
    } else {
      _updateLocations(isPickupLocationUpdate, locationModel, dateUpdate);
    }
    if (_carSearchArgumentModel?.isLanding != null &&
        _carSearchArgumentModel!.isLanding!) {
      Navigator.popUntil(context,
          (route) => route.settings.name == AppRoutes.carLandingScreen);
    } else {
      Navigator.popUntil(context,
          (route) => route.settings.name == AppRoutes.editSearchScreen);
    }
  }

  _updateLocations(bool isPickupLocationUpdate, LocationModel locationModel,
      CarDatesLocationUpdateViewModel dateUpdate) {
    Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false)
        .updateCarLocation(
            locationModelPickup: isPickupLocationUpdate
                ? locationModel
                : dateUpdate.pickupLocation,
            locationModelDropOff: isPickupLocationUpdate
                ? dateUpdate.dropOffLocation
                : locationModel);
  }

  _goToDropOffPointScreen(Item suggestion) {
    Navigator.pushNamed(
      context,
      AppRoutes.carSearchPickUpPointsScreen,
      arguments: CarSearchArgumentModel(
          carLandingBloc: _carSearchArgumentModel!.carLandingBloc,
          cityId: _carSearchArgumentModel!.cityId,
          isPickUpUpdate: _carSearchArgumentModel?.isPickUpUpdate,
          isDifferentDropOff: _carSearchArgumentModel!.isDifferentDropOff,
          isRedirected: true,
          locationModel: LocationModel(
            location: suggestion.locationName,
            locationId: suggestion.id,
          ),
          locationName: _carSearchArgumentModel?.locationName),
    );
  }
}
