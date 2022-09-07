import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_result_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/app_routes.dart';
import '../../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'car_landing_location_box.dart';

class CarLandingLocationWidget extends StatelessWidget {
  final CarLandingBloc carLandingBloc;
  final CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel;
  final bool isLanding;

  const CarLandingLocationWidget(
      {Key? key,
      required this.carLandingBloc,
      required this.carDatesLocationUpdateViewModel,
      required this.isLanding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (carDatesLocationUpdateViewModel.isFromRecentSearch) {
      return carLandingBloc.state.carRentalType == CarRentalType.carRent &&
              !carDatesLocationUpdateViewModel.isRecentDifferentDropOff
          ? _getCarRentLocationBox(context, carDatesLocationUpdateViewModel)
          : _getCarRentWithDriverLocationBox(
              context, carDatesLocationUpdateViewModel);
    } else {
      return carLandingBloc.state.carRentalType == CarRentalType.carRent &&
              !carDatesLocationUpdateViewModel.isDifferentDropOff
          ? _getCarRentLocationBox(context, carDatesLocationUpdateViewModel)
          : _getCarRentWithDriverLocationBox(
              context, carDatesLocationUpdateViewModel);
    }
  }

  Widget _getCarRentLocationBox(
      BuildContext context, CarDatesLocationUpdateViewModel value) {
    return CarLandingLocationBox(
        placeholderText: getTranslated(
            context, AppLocalizationsStrings.searchPickUpAndDropOffPoint),
        headerText: getTranslated(
            context, AppLocalizationsStrings.pickUpAndDropOffPoint),
        onTap: () => _goToCarSearchScreen(context, isLanding: isLanding),
        locationText: _setPickupText(value, isLanding));
  }

  Widget _getCarRentWithDriverLocationBox(
      BuildContext context, CarDatesLocationUpdateViewModel value) {
    return Column(
      children: [
        CarLandingLocationBox(
          placeholderText:
              getTranslated(context, AppLocalizationsStrings.searchPickUpPoint),
          headerText:
              getTranslated(context, AppLocalizationsStrings.carPickupPoint),
          onTap: () => _goToCarSearchScreen(context, isLanding: isLanding),
          locationText: _setPickupText(value, isLanding),
        ),
        CarLandingLocationBox(
          placeholderText: getTranslated(
              context, AppLocalizationsStrings.searchDropOffPoint),
          headerText:
              getTranslated(context, AppLocalizationsStrings.dropOffPoint),
          onTap: () => _goToCarSearchScreen(context,
              isPickupLocationUpdate: false, isLanding: isLanding),
          locationText: _setDropText(value, isLanding),
        )
      ],
    );
  }

  _updateLocations(
    bool isPickupLocationUpdate,
    LocationModel locationModel,
    CarDatesLocationUpdateViewModel dateUpdate,
    BuildContext context,
  ) {
    if (dateUpdate.isFromRecentSearch) {
      dateUpdate.updateisFromRecentSearch(true);
      carDatesLocationUpdateViewModel.updateCarLocationRecentSearch(
          locationModelPickup: isPickupLocationUpdate
              ? locationModel
              : dateUpdate.recentSearchPickupLocation,
          locationModelDropOff: isPickupLocationUpdate
              ? dateUpdate.recentSearchDropOffLocation
              : locationModel);
    } else {
      dateUpdate.updateisFromRecentSearch(false);
      carDatesLocationUpdateViewModel.updateCarLocation(
          locationModelPickup: isPickupLocationUpdate
              ? locationModel
              : dateUpdate.pickupLocation,
          locationModelDropOff: isPickupLocationUpdate
              ? dateUpdate.dropOffLocation
              : locationModel);
    }
  }

  _goToCarSearchScreen(BuildContext context,
      {bool isLanding = false, bool isPickupLocationUpdate = true}) async {
    var data = await Navigator.of(context).pushNamed(
        AppRoutes.carSearchSuggestionScreen,
        arguments: [carLandingBloc, isPickupLocationUpdate, isLanding]);
    if (isPickupLocationUpdate) {
      CarSearchResultFirebase.searchPickKey = CarSearchResultFirebase.searchKey;
      if (!carDatesLocationUpdateViewModel.isDifferentDropOff) {
        CarSearchResultFirebase.searchDropKey =
            CarSearchResultFirebase.searchKey;
      }
    } else {
      CarSearchResultFirebase.searchDropKey = CarSearchResultFirebase.searchKey;
    }

    if (data != null) {
      LocationModel locationModel = data as LocationModel;
      CarDatesLocationUpdateViewModel dateUpdate =
          Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);

      if (isPickupLocationUpdate) {
        //pickup
        _updateLocations(
            isPickupLocationUpdate, locationModel, dateUpdate, context);
      } else {
        _updateLocations(
            //drop
            isPickupLocationUpdate,
            locationModel,
            dateUpdate,
            context);
      }
    }
  }

  _setPickupText(CarDatesLocationUpdateViewModel value, bool isLanding) {
    getPickUpKeyword();
    if (value.isFromRecentSearch && value.isRecentDifferentDropOff) {
      return carDatesLocationUpdateViewModel
          .recentSearchPickupLocation?.location;
    } else {
      return carDatesLocationUpdateViewModel.pickupLocation?.location;
    }
  }

  void getPickUpKeyword() {
    getKeyWordFirebase(
        FirebaseEvent.carSearchInput,
        CarSearchParametersFirebase.carKeywordsearchPickup,
        CarSearchResultFirebase.searchPickKey);
    if (!carDatesLocationUpdateViewModel.isDifferentDropOff) {
      getDropOffKeyword();
    }
  }

  _setDropText(CarDatesLocationUpdateViewModel value, bool isLanding) {
    getDropOffKeyword();
    if (value.isFromRecentSearch && value.isRecentDifferentDropOff) {
      return carDatesLocationUpdateViewModel
          .recentSearchDropOffLocation?.location;
    } else {
      return carDatesLocationUpdateViewModel.dropOffLocation?.location;
    }
  }

  getDropOffKeyword() {
    getKeyWordFirebase(
        FirebaseEvent.carSearchInput,
        CarSearchParametersFirebase.carKeywordsearchReturn,
        CarSearchResultFirebase.searchDropKey);
  }

  getKeyWordFirebase(String eventName, String key, String? value) {
    FirebaseHelper.addKeyValue(eventName: eventName, key: key, value: value);
  }
}
