import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;

class TourBookingNoResultWithRefresh extends StatelessWidget {
  final double height;
  const TourBookingNoResultWithRefresh({
    Key? key,
    required this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: height - _kTopPadding,
          child: OtaSearchNoResultWidget(
            errorTextHeader: getTranslated(
              context,
              AppLocalizationsStrings.sorry,
            ),
            errorTextFooter: getTranslated(
              context,
              AppLocalizationsStrings.informationNotAvialable,
            ),
            paddingHeight: kSize8,
          ),
        )
      ],
    );
  }
}
