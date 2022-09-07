import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import '../../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

const _kCarDriverTextButton = "CarDriverTextButton";

class CarLandingDriverAge extends StatelessWidget {
  const CarLandingDriverAge({Key? key, required this.value}) : super(key: key);
  final CarDatesLocationUpdateViewModel value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _labelText(context: context),
          _driverAgeButton(context),
        ],
      ),
    );
  }

  Widget _driverAgeButton(BuildContext context) {
    return SizedBox(
      height: kSize40,
      width: kSize52,
      child: TextButton(
        key: const Key(_kCarDriverTextButton),
        onPressed: () {
          _showDriverAgeSheet(context, value);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.kGrey4),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Text(
          _setAge(value),
          style: AppTheme.kBodyRegular,
        ),
      ),
    );
  }

  Widget _labelText({required BuildContext context}) {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.driversAge),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(width: kSize8),
        Text(
          '${AppConfig().configModel.carDriverMinAge}+',
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        ),
      ],
    );
  }

  void _showDriverAgeSheet(
      BuildContext context, CarDatesLocationUpdateViewModel value) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.kLight100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kSize24),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoWidget(
            title: getTranslated(context, AppLocalizationsStrings.driversAge),
            maxInputValueLimit: AppConfig().configModel.carDriverMaxAge,
            minInputValueLimit: AppConfig().configModel.carDriverMinAge,
            oldAge: (value.age - AppConfig().configModel.carDriverMinAge) + 1,
            onAgreeClicked: (newAge) {
              value.updateisFromRecentSearch(false);
              value.updateAge(
                  AppConfig().configModel.carDriverMinAge + (newAge - 1));
            },
          ),
        );
      },
    );
  }

  _setAge(CarDatesLocationUpdateViewModel value) {
    if (value.isFromRecentSearch) {
      return value.recentAge.toString();
    } else {
      return value.age.toString();
    }
  }
}
