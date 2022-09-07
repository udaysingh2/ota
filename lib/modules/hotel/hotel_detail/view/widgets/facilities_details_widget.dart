import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/back_button.dart';

const _kAnimationDuration = 200;

const _kIconSize = 24.0;

class FacilityDetailsView extends StatefulWidget {
  const FacilityDetailsView({Key? key}) : super(key: key);
  @override
  FacilityDetailsViewState createState() => FacilityDetailsViewState();
}

class FacilityDetailsViewState extends State<FacilityDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getFacilityItem(),
      appBar: AppBar(
        leadingWidth: kSize72,
        backgroundColor: Colors.transparent,
        leading: AnimatedSwitcher(
          duration: const Duration(milliseconds: _kAnimationDuration),
          child: BackNavigationButton(
            onClicked: () => Navigator.of(context).pop(),
            removeOval: true,
          ),
        ),
        elevation: kSize0,
        title: Text(
          getTranslated(context, AppLocalizationsStrings.facilities),
          overflow: TextOverflow.ellipsis,
          style: AppTheme.kHeading3,
        ),
      ),
    );
  }

  Widget _getFacilityItem() {
    final Map<String, dynamic>? facilityList =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final Iterable<String>? allKeys = facilityList?.keys;
    final Iterable<dynamic>? allValues = facilityList?.values;
    if (allKeys != null &&
        allKeys.isNotEmpty &&
        allValues != null &&
        allValues.isNotEmpty) {
      return Padding(
        padding: kPaddingAll24,
        child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (allValues.elementAt(index) is String)
                    _getTileView(
                        name: allValues.elementAt(index),
                        asset: FacilityHelper.getAssetName(
                            allKeys.elementAt(index))),
                  if (allValues.elementAt(index) is String)
                    const SizedBox(height: kSize16),
                ]);
          },
          itemCount: allKeys.length,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getTileView({required String name, required String asset}) {
    return Row(children: [
      SvgPicture.asset(
        asset,
        height: _kIconSize,
        width: _kIconSize,
        fit: BoxFit.contain,
      ),
      const SizedBox(
        width: kSize16,
      ),
      Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey70),
      )
    ]);
  }
}
