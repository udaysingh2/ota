import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';

const _kIconSize = 24.0;

class FacilityView extends StatefulWidget {
  final Map<String, dynamic>? facilityList;
  final Map<String, dynamic>? facilityMain;
  const FacilityView({Key? key, this.facilityList, this.facilityMain})
      : super(key: key);

  @override
  FacilityViewState createState() => FacilityViewState();
}

class FacilityViewState extends State<FacilityView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kSize0,
      margin: const EdgeInsets.all(kSize0),
      child: _getFacilitiesView(),
    );
  }

  Widget _getFacilitiesView() {
    List<Widget> facilitiesArray = [];
    facilitiesArray.add(_getTitleBar());
    facilitiesArray.add(const SizedBox(height: kSize8));
    facilitiesArray.addAll(_getFacilitiesTile());
    return Container(
      padding: const EdgeInsets.only(left: kSize24, right: kSize16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: facilitiesArray,
      ),
    );
  }

  List<Widget> _getFacilitiesTile() {
    List<Widget> facilityList = [];
    final Iterable<String>? allKeys = widget.facilityMain?.keys;
    final Iterable<dynamic>? allValues = widget.facilityMain?.values;
    if (allKeys != null &&
        allKeys.isNotEmpty &&
        allValues != null &&
        allValues.isNotEmpty) {
      for (int i = 0; i < allKeys.length; i++) {
        if (allValues.elementAt(i) is String) {
          String isEnabled = allValues.elementAt(i);
          if (isEnabled == '1') {
            facilityList.add(_getTileView(allKeys.elementAt(i)));
            facilityList.add(const SizedBox(height: kSize8));
          }
        }
      }
    }
    return facilityList;
  }

  Widget _getTitleBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        getTranslated(context, AppLocalizationsStrings.facilities),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.kHeading1Medium,
      ),
      OtaNextButton(
        key: const Key("facilities_additional"),
        onPress: () => {
          FirebaseHelper.stopCapturingEvent(FirebaseEvent.hotelViewFacility),
          Navigator.pushNamed(context, AppRoutes.facilityDetails,
              arguments: widget.facilityList)
        },
      )
    ]);
  }

  Widget _getTileView(String assetId) {
    String asset = FacilityHelper.getAssetName(assetId);
    return Row(children: [
      SvgPicture.asset(
        asset,
        height: _kIconSize,
        width: _kIconSize,
        fit: BoxFit.contain,
      ),
      const SizedBox(
        width: kSize8,
      ),
      Text(
        FacilityHelper.getLocalizedText(assetId, context),
        overflow: TextOverflow.ellipsis,
        style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70),
      )
    ]);
  }
}
