import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class TourBookingCancellationWidget extends StatelessWidget {
  final EdgeInsets padding;
  final String? cancellationStatus;
  final List<String>? bookingTermsList;
  final bool showDivider;
  const TourBookingCancellationWidget({
    Key? key,
    this.padding = kPaddingHori24,
    this.cancellationStatus,
    this.bookingTermsList,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize16),
          Text(
            getTranslated(
                context, AppLocalizationsStrings.tourCancellationPolicy),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(height: kSize10),
          if (cancellationStatus != null)
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.gradient1
                    .createShader(Offset.zero & bounds.size);
              },
              child: Text(
                getCancellationStatus(context, cancellationStatus!),
                style:
                    AppTheme.kBodyRegular.copyWith(color: AppColors.kTrueWhite),
                textAlign: TextAlign.center,
              ),
            ),
          if (cancellationStatus != null) const SizedBox(height: kSize10),
          if (bookingTermsList != null && bookingTermsList!.isNotEmpty)
            getTermsList(context),
          const SizedBox(height: kSize24),
          if (showDivider)
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }

  String getCancellationStatus(BuildContext context, String statusKey) {
    return statusKey;
  }

  Widget getTermsList(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          String bookingText = (index == bookingTermsList!.length - 1)
              ? bookingTermsList![index]
              : StringUpdate(bookingTermsList![index]).addNextLine();
          return Text(
            bookingText,
            style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
          );
        },
        itemCount: bookingTermsList!.length);
  }
}
