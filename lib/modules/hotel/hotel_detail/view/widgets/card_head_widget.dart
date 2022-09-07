import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_vertical_divider.dart';

const double _kHotelInfoPadding = 24;
const double _kDividerHeight = 40;
const double _kPadding8 = 8;
const double _kPadding4 = 4;

class CardHeadCalender extends StatelessWidget {
  final String sectionOneHeader;
  final String sectionOneFooter;
  final String sectionTwoHeader;
  final String sectionTwoFooter;
  final String sectionThreeHeader;
  final String sectionThreeFooter;
  final String sectionFourHeader;
  final String sectionFourFooter;
  final bool isSticky;
  final Function()? onPressed;

  const CardHeadCalender({
    Key? key,
    this.sectionOneFooter = "",
    this.sectionOneHeader = "",
    this.sectionTwoFooter = "",
    this.sectionTwoHeader = "",
    this.sectionThreeFooter = "",
    this.sectionThreeHeader = "",
    this.sectionFourFooter = "",
    this.sectionFourHeader = "",
    this.isSticky = true,
    this.onPressed,
  }) : super(key: key);

  Widget getTile({isCenter = true, header = "", footer = ""}) {
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Text(header,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
        _buildGradientText(
          text: footer,
          style: AppTheme.kSmallMedium,
          gradient: const LinearGradient(
            tileMode: TileMode.mirror,
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.kGradientStart, AppColors.kGradientEnd],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: _kPadding8),
                child: OtaHorizontalDivider(),
              ),
              Padding(
                padding: isSticky
                    ? const EdgeInsets.symmetric(horizontal: _kHotelInfoPadding)
                    : const EdgeInsets.symmetric(
                        horizontal: _kHotelInfoPadding, vertical: _kPadding8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getTile(
                              isCenter: false,
                              header: sectionOneHeader,
                              footer: sectionOneFooter),
                          const Spacer(),
                          getTile(
                              isCenter: false,
                              header: sectionTwoHeader,
                              footer: sectionTwoFooter),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: _kDividerHeight, child: OtaVerticalDivider()),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: kSize16, right: _kPadding4),
                        child: getTile(
                            header: sectionThreeHeader,
                            footer: sectionThreeFooter)),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: _kPadding4, right: _kPadding4),
                        child: getTile(
                            header: sectionFourHeader,
                            footer: sectionFourFooter)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: _kPadding8),
                child: OtaHorizontalDivider(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientText(
      {dynamic text, required TextStyle style, required Gradient gradient}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
