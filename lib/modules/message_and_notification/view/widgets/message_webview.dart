import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/message_and_notification/helper/message_and_notification_helper.dart';

const double _kSize33 = 33;
const double _kSize50 = 50;
const EdgeInsetsGeometry _ktitleBarPadding =
    EdgeInsets.only(left: _kSize33, top: kSize14, bottom: kSize12);

class MessageWebViewWidget extends StatelessWidget {
  final String type;
  final String title;
  final String? body;
  final String createDate;
  const MessageWebViewWidget({
    Key? key,
    required this.type,
    required this.title,
    this.body,
    required this.createDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - kSize100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kSize10),
                topRight: Radius.circular(kSize10)),
            child: OtaAppBar(
              key: Key("WebviewAppbarKey"),
              backgroundColor: AppColors.kWhiteColor,
            ),
          ),
          _getTitleBar(context),
          const SizedBox(
            height: _kSize50,
          ),
          _getDetails(),
        ],
      ),
    );
  }

  Widget _getTitleBar(BuildContext context) {
    return Stack(children: [
      Container(
        color: AppColors.kSecondary,
        height: kSize60,
        padding: _ktitleBarPadding,
        child: Row(
          children: [
            const SizedBox(
              width: kSize80,
            ),
            Text(
              getTranslated(context, AppLocalizationsStrings.newsPromotion),
              textAlign: TextAlign.center,
              style: AppTheme.kHeading1Medium
                  .copyWith(color: AppColors.kLoadingBackground),
            )
          ],
        ),
      ),
      Padding(
        padding: _ktitleBarPadding,
        child: _getIcon(),
      ),
    ]);
  }

  Widget _getIcon() {
    return Container(
      height: kSize64,
      width: kSize64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.kGrey40,
        border: Border.all(color: AppColors.kBorderColor),
      ),
      child: Center(
        child: SvgPicture.asset(
          MessageAndNotificationHelper.getSvg(type),
          height: kSize24,
          width: kSize24,
        ),
      ),
    );
  }

  Widget _getDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _kSize33),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: AppTheme.kBodyMedium.copyWith(color: AppColors.kGrey70),
            ),
            const SizedBox(
              height: kSize8,
            ),
            Text(
              createDate,
              style: AppTheme.kSmallRegular.copyWith(
                color: AppColors.kGrey50,
              ),
            ),
            const SizedBox(
              height: kSize24,
            ),
            Text(
              body ?? "",
              style: AppTheme.kBodyRegular,
            ),
          ],
        ),
      ),
    );
  }
}
