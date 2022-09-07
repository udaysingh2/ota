import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_phone_function.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kPhoneAsset = "assets/images/icons/phone.svg";

class TourBookingContactDetailsWidget extends StatelessWidget {
  final String? providerInformation;
  final String? phoneNumber;
  final bool isIconVisible;
  const TourBookingContactDetailsWidget({
    Key? key,
    this.providerInformation,
    this.phoneNumber,
    this.isIconVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize24),
        Text(
          getTranslated(
              context, AppLocalizationsStrings.serviceProviderInformation),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        if (providerInformation != null && providerInformation!.isNotEmpty)
          Text(
            providerInformation!,
            style: AppTheme.kBodyMedium,
          ),
        if (providerInformation != null && providerInformation!.isNotEmpty)
          const SizedBox(height: kSize8),
        if (phoneNumber != null && phoneNumber!.isNotEmpty)
          InkWell(
            onTap: () => OtaPhoneFunction().makePhoneCall(phoneNumber!),
            child: Row(
              children: [
                if (isIconVisible)
                  SvgPicture.asset(_kPhoneAsset,
                      height: kSize24, width: kSize24),
                if (isIconVisible) const SizedBox(width: kSize8),
                OtaGradientTextWidget(
                  text: getTranslated(
                      context, AppLocalizationsStrings.contactProvider),
                  style: AppTheme.kBodyRegular,
                )
              ],
            ),
          ),
        SizedBox(
            height: (phoneNumber != null && phoneNumber!.isNotEmpty)
                ? kSize24
                : kSize16),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10)
      ],
    );
  }
}
