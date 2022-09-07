import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class HotelRoomFacility extends StatelessWidget {
  final List<String>? facilityList;

  const HotelRoomFacility({Key? key, required this.facilityList})
      : super(key: key);

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.roomFacilities),
      style: AppTheme.kHeading1Medium,
    );
  }

  Widget _getFacilityList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: kSize16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: facilityList?.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: kSize8),
          child: Text(
            getTranslated(context, facilityList![index]),
            style: AppTheme.kBodyRegular,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _getHeading(context),
          _getFacilityList(context),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }
}
