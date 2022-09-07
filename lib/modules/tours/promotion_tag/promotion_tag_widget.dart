import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/tours/promotion_tag/view_model/promotion_tag_view_model.dart';

const _kImagePath = "assets/images/icons/food.svg";
const _kMaxLineOne = 1;
const _kMaxLineTwo = 2;

class PromotionTagWidget extends StatelessWidget {
  final PromotionTagViewModel model;
  final Function(String url) onTap;

  const PromotionTagWidget({Key? key, required this.model, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: kSize16, horizontal: kSize18),
        decoration: const BoxDecoration(
            color: AppColors.kPrimary24,
            borderRadius: BorderRadius.all(Radius.circular(kSize10))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(_kImagePath),
            const SizedBox(width: kSize10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title!,
                    maxLines: _kMaxLineOne,
                    style: AppTheme.kSmallMedium
                        .copyWith(color: AppColors.kSecondary),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: kSize4),
                  Text(
                    model.description!,
                    maxLines: _kMaxLineTwo,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.kSmallRegular,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => onTap(model.web!),
    );
  }
}
