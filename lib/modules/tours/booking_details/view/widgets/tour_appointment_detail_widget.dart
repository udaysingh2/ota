import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class TourAppointmentDetailWidget extends StatelessWidget {
  final Function()? onTap;
  final String titleKey;

  const TourAppointmentDetailWidget(
      {Key? key, this.onTap, required this.titleKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, titleKey),
              style: AppTheme.kHeading1Medium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            OtaNextButton(onPress: onTap),
          ],
        ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
      ],
    );
  }
}
