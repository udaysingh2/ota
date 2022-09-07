import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class TourBookingMeetingPointWidget extends StatelessWidget {
  final String meetingPoint;
  const TourBookingMeetingPointWidget({Key? key, required this.meetingPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Text(
          getTranslated(context, AppLocalizationsStrings.meetingPoint),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        Html(data: meetingPoint, style: _getHtmlStyleMap),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
      ],
    );
  }

  Map<String, Style> get _getHtmlStyleMap {
    return {
      htmlTagH1: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagH2: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagP: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagUL: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagLI: Style.fromTextStyle(AppTheme.htmlBodyText),
      htmlTagBody: Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      htmlTagFigure: Style(margin: EdgeInsets.zero),
    };
  }
}
