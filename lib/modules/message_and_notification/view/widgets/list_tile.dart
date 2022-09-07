import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/message_and_notification/helper/message_and_notification_helper.dart';

const _kStatusSvg = "assets/images/icons/status.svg";
const int _kMaxLines1 = 1;
const int _kMaxLines2 = 2;

class MessageListTile extends StatelessWidget {
  final String title;
  final String type;
  final String? body;
  final double iconWidth;
  final Function()? onTap;
  final bool readFlag;
  final double iconAdditionalPadding;
  final double? statusIconSize;
  const MessageListTile({
    Key? key,
    required this.title,
    required this.type,
    this.body,
    this.iconWidth = kSize40,
    this.onTap,
    this.readFlag = true,
    this.iconAdditionalPadding = kSize0,
    this.statusIconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize7),
      isThreeLine: body != null,
      leading: Container(
        margin: EdgeInsets.only(top: iconAdditionalPadding),
        height: iconWidth,
        width: iconWidth,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            SvgPicture.asset(
              MessageAndNotificationHelper.getSvgType(type),
              fit: BoxFit.fill,
            ),
            Offstage(
              offstage: readFlag,
              child: SvgPicture.asset(
                _kStatusSvg,
                height: statusIconSize,
                width: statusIconSize,
              ),
            ),
          ],
        ),
      ),
      title: Padding(
        padding: (body ?? '').length > kSize10
            ? const EdgeInsets.only(top: kSize15)
            : const EdgeInsets.only(top: kSize10),
        child: Text(
          title,
          style: AppTheme.kBodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: _kMaxLines1,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: kSize5, top: kSize1),
        child: Text(
          body ?? "",
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          overflow: TextOverflow.ellipsis,
          maxLines: _kMaxLines2,
        ),
      ),
    );
  }
}
