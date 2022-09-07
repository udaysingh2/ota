import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

import '../../../core/app_routes.dart';
import '../ota_horizontal_divider.dart';
import 'ota_free_food_promotion_model.dart';

const double _kSize28 = 28;
const _kHeaderMaxLines = 1;
const _kSubHeaderMaxLines = 2;

const String _kCrokeryIcon = "assets/images/icons/crockery.svg";

class OtaFreeFoodBannerWidget extends StatelessWidget {
  final List<OtaFreeFoodPromotionModel> freeFoodPromotionList;

  const OtaFreeFoodBannerWidget({
    Key? key,
    required this.freeFoodPromotionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSize8)),
          color: AppColors.kPrimary93,
        ),
        child: _buildWidgetField(context));
  }

  Widget _buildWidgetField(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          );
        },
        itemCount: freeFoodPromotionList.length,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
            onTap: () {
              if (freeFoodPromotionList[index].deepLinkUrl.isNotEmpty) {
                Navigator.pushNamed(context, AppRoutes.webViewScreen,
                    arguments: freeFoodPromotionList[index].deepLinkUrl);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(kSize16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: freeFoodPromotionList[index].headerIcon,
                        fit: BoxFit.cover,
                        width: kSize20,
                        height: kSize20,
                        errorWidget: (context, url, error) => SvgPicture.asset(
                          _kCrokeryIcon,
                          height: kSize20,
                          width: kSize20,
                          color: AppColors.kSecondary,
                        ),
                      ),
                      const SizedBox(
                        width: kSize8,
                      ),
                      Expanded(
                        child: Text(
                          freeFoodPromotionList[index].headerText,
                          style: AppTheme.kSmallMedium
                              .copyWith(color: AppColors.kSecondary),
                          maxLines: _kHeaderMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kSize4,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: _kSize28,
                      ),
                      Expanded(
                        child: Text(
                          freeFoodPromotionList[index].subHeaderText,
                          style: AppTheme.kSmallRegular
                              .copyWith(color: AppColors.kGrey70),
                          maxLines: _kSubHeaderMaxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
