import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kBookingTypeOptionsKey = 'booking_type_options_key';

class OtaChipBooking extends StatelessWidget {
  final Function(int) onPressed;
  final int selectedIndex;
  OtaChipBooking({
    Key? key,
    required this.selectedIndex,
    required this.onPressed,
  }) : super(key: key);

  final List<String> _labelList = [
    AppLocalizationsStrings.ongoing,
    AppLocalizationsStrings.completed,
    AppLocalizationsStrings.canceled,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kSize45,
      child: ListView.separated(
        padding:
            const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize8),
        scrollDirection: Axis.horizontal,
        itemCount: _labelList.length,
        itemBuilder: (context, index) {
          return OtaChipButton(
            key: const Key(_kBookingTypeOptionsKey),
            title: getTranslated(
              context,
              _labelList[index],
            ),
            isSelected: selectedIndex == index,
            isLighterGreyColor: true,
            onPressed: () {
              onPressed(index);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: kSize8);
        },
      ),
    );
  }
}
