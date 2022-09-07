import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/utils/app_colors.dart';
import '../../../common/utils/app_theme.dart';
import '../../../common/utils/consts.dart';
import 'ota_promotion_model.dart';

const _kTickIcon = "assets/images/icons/check_circle.svg";

class OtaRoomSpecialPromotionWidget extends StatelessWidget {
  final String header;
  final List<OtaPromotionModel> specialPromotionList;
  final String bottomDetail;
  final EdgeInsets padding;
  const OtaRoomSpecialPromotionWidget({
    Key? key,
    required this.header,
    required this.specialPromotionList,
    this.bottomDetail = "",
    this.padding = const EdgeInsets.only(top: kSize24),
  }) : super(key: key);

  Widget _getHeading(BuildContext context) {
    return Text(
      header,
      style: AppTheme.kHeading1Medium,
    );
  }

  Widget _promotionDetail(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              _kTickIcon,
              height: kSize20,
              width: kSize20,
              color: AppColors.kSecondary,
            ),
            const SizedBox(width: kSize8),
            Expanded(
              child: Text(
                specialPromotionList[index].promotionHeader,
                style: AppTheme.kSmallRegular
                    .copyWith(color: AppColors.kSecondary),
              ),
            )
          ],
        ),
        const SizedBox(
          height: kSize4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: kSize28),
          child: Text(
            specialPromotionList[index].promotionDetail,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          ),
        )
      ],
    );
  }

  Widget _getSpecialPromotionList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: kSize16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: specialPromotionList.length,
      itemBuilder: (BuildContext context, int index) {
        return _promotionDetail(index);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: kSize8);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _getHeading(context),
          _getSpecialPromotionList(),
          bottomDetail.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: kSize24),
                  child: Text(
                    bottomDetail,
                    style: AppTheme.kSmallRegular,
                  ),
                ),
        ],
      ),
    );
  }
}
