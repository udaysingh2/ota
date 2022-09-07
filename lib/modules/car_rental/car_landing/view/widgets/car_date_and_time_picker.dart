import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';

import '../../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';

const _kBorderRadiusAll8 = BorderRadius.all(Radius.circular(kSize8));
const int _kMaxLines = 1;
const int _kPadLeft = 2;
const _keyCarDateTimePicker = "CarDateTimePickerButton";

class CarDateTimePicker extends StatelessWidget {
  final CarDatesLocationUpdateViewModel value;
  final bool isLanding;

  const CarDateTimePicker(
      {Key? key, required this.value, required this.isLanding})
      : super(key: key);

  void _showDateSelectionSheet(
      BuildContext context, CarDatesLocationUpdateViewModel dateUpdate) async {
    var data = await Navigator.of(context).pushNamed(
      AppRoutes.carDateTimeSelectionScreen,
      arguments: CarDateTimePickerArgumentModel(
        pickUpDate: dateUpdate.isFromRecentSearch
            ? dateUpdate.recentSearchPickupDate
            : dateUpdate.pickupDate,
        dropOffDate: dateUpdate.isFromRecentSearch
            ? dateUpdate.recentSearchDropOffDate
            : dateUpdate.dropOffDate,
      ),
    );
    if (data != null) {
      CarDateTimePickerArgumentModel argumentModel =
          data as CarDateTimePickerArgumentModel;

      if (value.isFromRecentSearch) {
        value.updateisFromRecentSearch(true);
        value.updateCarDateRecentSearch(
            argumentModel.pickUpDate, argumentModel.dropOffDate);
      } else {
        value.updateisFromRecentSearch(false);
        value.updateCarDate(
            argumentModel.pickUpDate, argumentModel.dropOffDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.pickUpAndDropOffDate),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize8),
        Row(
          children: [
            Expanded(
              child: _carDateTimePickerCard(
                  date: _setPickupDate(value),
                  onTap: () => _showDateSelectionSheet(context, value)),
            ),
            const Padding(
              padding: EdgeInsets.all(kSize8),
              child: Icon(
                Icons.remove,
                size: kSize20,
                color: AppColors.kGrey20,
              ),
            ),
            Expanded(
              child: _carDateTimePickerCard(
                  date: _setDropDate(value),
                  onTap: () => _showDateSelectionSheet(context, value)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _carDateTimePickerCard({
    required DateTime date,
    required Function() onTap,
  }) {
    return GestureDetector(
      key: const Key(_keyCarDateTimePicker),
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: _kBorderRadiusAll8,
          color: AppColors.kGrey4,
        ),
        padding:
            const EdgeInsets.symmetric(vertical: kSize12, horizontal: kSize10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Helpers.getwwddMMMyy(date),
              style: AppTheme.kBodyMedium,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: kSize4),
            Text(
              '${date.hour.toString().padLeft(_kPadLeft, '0')}:${date.minute.toString().padLeft(_kPadLeft, '0')}',
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey70),
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  _setPickupDate(CarDatesLocationUpdateViewModel value) {
    if (value.isFromRecentSearch) {
      return value.recentSearchPickupDate;
    } else {
      return value.pickupDate;
    }
  }

  _setDropDate(CarDatesLocationUpdateViewModel value) {
    if (value.isFromRecentSearch) {
      return value.recentSearchDropOffDate;
    } else {
      return value.dropOffDate;
    }
  }
}
