import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';

const String _kCrockeryIcon = 'assets/images/icons/crockery.svg';

class FreeFoodDeliveryWidget extends StatelessWidget {
  const FreeFoodDeliveryWidget({
    Key? key,
    required this.urlString,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String urlString;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (urlString.isNotEmpty) {
          Navigator.pushNamed(context, AppRoutes.webViewScreen,
              arguments: urlString);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: kSize16, horizontal: kSize18),
        decoration: BoxDecoration(
          color: AppColors.kPrimary24,
          borderRadius: BorderRadius.circular(kSize8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              _kCrockeryIcon,
              height: kSize17,
              width: kSize15,
              color: AppColors.kSecondary,
            ),
            const SizedBox(width: kSize10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: AppTheme.kSmallMedium
                        .copyWith(color: AppColors.kSecondary),
                  ),
                  Text(
                    description ?? '',
                    style: AppTheme.kSmallRegular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
