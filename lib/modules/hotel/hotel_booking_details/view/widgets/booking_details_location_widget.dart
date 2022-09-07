import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/custom_widgets/ota_location_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_map_launcher.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _kPhoneNumberIcon = "assets/images/icons/phone_alt.svg";
const _kMapIcon = "assets/images/icons/map_marker.svg";
const _kRightArrowIcon = "assets/images/icons/arrow_right_16.svg";
const String _kLeadingOptionsKey = 'Leading_options_key';
const String _kTrailingOptionOptionsKey = 'Trailing_options_key';

class BookingDetailLocationWidget extends StatelessWidget {
  final String phoneNumber;
  final double latitude;
  final double longitude;
  const BookingDetailLocationWidget(
      {Key? key,
      required this.phoneNumber,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: phoneNumber.isNotEmpty
              ? OtaLocationWidget(
                  key: const Key(_kLeadingOptionsKey),
                  onTap: () {},
                  locationText: phoneNumber,
                  style: AppTheme.kSmallRegular,
                  leadingIcon: _kPhoneNumberIcon,
                  isEnabled: false)
              : const SizedBox(),
        ),
        OtaLocationWidget(
            key: const Key(_kTrailingOptionOptionsKey),
            onTap: () => OtaMapLauncher.launchMap(
                latitude: latitude, longitude: longitude),
            locationText:
                getTranslated(context, AppLocalizationsStrings.viewMap),
            style: AppTheme.kSmallRegular,
            leadingIcon: _kMapIcon,
            trailingIcon: _kRightArrowIcon),
      ],
    );
  }

  Future<void> openMapInBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
