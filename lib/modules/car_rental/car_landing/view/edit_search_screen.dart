import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view/widgets/car_landing_location_widget.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core_pack/custom_widgets/ota_text_button.dart';
import '../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import 'widgets/car_date_and_time_picker.dart';
import 'widgets/car_landing_diffrent_drop_toggel.dart';
import 'widgets/car_landing_driver_age_widget.dart';

const String _kOtaTextSearchButton = "ota_text_search_button";
const int _kTime = 100;

class EditSearchScreen extends StatefulWidget {
  const EditSearchScreen({Key? key}) : super(key: key);

  @override
  EditSearchScreenState createState() => EditSearchScreenState();
}

class EditSearchScreenState extends State<EditSearchScreen>
    with SingleTickerProviderStateMixin {
  final CarLandingBloc _carLandingBloc = CarLandingBloc();
  AnimationController? _animationController;
  late Animation _circleAnimation;

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
      if (carDatesLocationUpdateViewModel.isFromRecentSearch &&
          carDatesLocationUpdateViewModel.isRecentDifferentDropOff) {
        _animationController!.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _carLandingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupSwitchButton();
    return Scaffold(
        appBar: OtaAppBar(
          title: getTranslated(context, AppLocalizationsStrings.infoAboutCar),
        ),
        body: _body());
  }

  Widget _body() {
    return BlocBuilder(
      bloc: _carLandingBloc,
      builder: () {
        return Consumer<CarDatesLocationUpdateViewModel>(
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kSize24),
                      child: CarLandingLocationWidget(
                        carLandingBloc: _carLandingBloc,
                        carDatesLocationUpdateViewModel: value,
                        isLanding: false,
                      ),
                    ),
                    if (_carLandingBloc.state.carRentalType ==
                        CarRentalType.carRent)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kSize24),
                        child: CarLandingDifferentDropToggle(
                          onTap: () {
                            if (_animationController!.isCompleted) {
                              _animationController!.reverse();
                            } else {
                              _animationController!.forward();
                            }

                            if (value.isFromRecentSearch) {
                              value.updateIsRecentSearch(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: kSize24),
                            child: CarDateTimePicker(
                              value: value,
                              isLanding: false,
                            ),
                          );
                        }),
                    if (_carLandingBloc.state.carRentalType ==
                        CarRentalType.carRent)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kSize24),
                        child: CarLandingDriverAge(
                          value: value,
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kSize24, vertical: kSize36),
                      child: OtaHorizontalDivider(
                        height: kSize1,
                        dividerColor: AppColors.kGrey10,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSize24, vertical: kSize24),
                    child: OtaTextButton(
                      key: const Key(_kOtaTextSearchButton),
                      title: getTranslated(
                          context, AppLocalizationsStrings.search),
                      isDisabled: !_carLandingBloc.enableSearchButton(value,
                          isLanding: false),
                      onPressed: () {
                        _getSearchFirebaseEvents(
                            FirebaseEvent.carSearchInput, value);
                        _navigateToSearchResultScreen(value);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _navigateToSearchResultScreen(CarDatesLocationUpdateViewModel value) {
    if (_carLandingBloc.enableSearchButton(value)) {
      Navigator.pop(context, true);
    }
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
}
