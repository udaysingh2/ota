import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radion_option_list.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _otaRadioButtonHorizontalPadding = 36;
const double _kHeaderHeight = 78.0;
const String _kCrossIcon = 'assets/images/icons/cross.svg';
const String _kCheckBox = "assets/images/icons/checkbox_gradient.svg";

class SearchSort extends StatelessWidget {
  final Function(String)? onPressed;
  final String title;
  final List<String> labelList;
  final int selectedIndex;

  const SearchSort({
    Key? key,
    this.onPressed,
    required this.title,
    required this.labelList,
    required this.selectedIndex,
  }) : super(key: key);

  Widget _getSortView(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              _buildHeaderView(context),
              const OtaHorizontalDivider(
                thickness: kSize1,
                dividerColor: AppColors.kGrey10,
              ),
              OtaRadioButtonList(
                crossAxisAlignment: CrossAxisAlignment.center,
                circledRadio: true,
                horizontalPadding: _otaRadioButtonHorizontalPadding,
                iconSize: kSize22,
                selectedWidget: Ink(
                  height: kSize24,
                  width: kSize24,
                  child: SvgPicture.asset(
                    _kCheckBox,
                  ),
                ),
                unSelectedWidget: Padding(
                  padding: const EdgeInsets.all(kSize2),
                  child: Ink(
                    height: kSize20,
                    width: kSize20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.kPurpleOutline,
                      ),
                    ),
                  ),
                ),
                isTextFontRegular: true,
                labelList: labelList,
                onWidgetStateReady: (otaRadioOptionListBloc) {
                  otaRadioOptionListBloc.onRadioButtonClicked(selectedIndex);
                },
                onPressed: (index) {
                  if (onPressed != null) {
                    onPressed!(index);
                  }
                },
              ),
              const OtaHorizontalDivider(
                thickness: kSize1,
                dividerColor: AppColors.kGrey4,
              ),
              OtaBottomButtonBar(
                containerHeight: kSize74,
                showHorizontalDivider: false,
                padding: const EdgeInsets.only(
                    left: kSize24,
                    right: kSize24,
                    top: kSize16,
                    bottom: kSize9),
                button1: OtaTextButton(
                    title: getTranslated(context, AppLocalizationsStrings.ok),
                    isSelected: true,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kSize24, right: kSize16, top: kSize24, bottom: kSize24),
      height: _kHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: kSize22,
          ),
          Text(
            title,
            style: AppTheme.kHeading1Medium,
          ),
          OtaIconButton(
            icon: SvgPicture.asset(
              _kCrossIcon,
              color: AppColors.kGrey50,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getSortView(context);
  }
}
