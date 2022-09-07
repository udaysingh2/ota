import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/modules/tours/package_detail/helper/package_detail_helper.dart';

class PackageSectionWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String>? elementsList;
  final String? svgAsset;
  final String? body;
  final bool isHtml;
  final bool isList;

  const PackageSectionWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.elementsList,
    this.svgAsset,
    this.body,
    this.isHtml = false,
    this.isList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Text(
          title,
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        if (subtitle != null)
          Text(
            subtitle!,
            style: AppTheme.kBodyRegular,
          ),
        if (subtitle != null) const SizedBox(height: kSize16),
        isList ? _getList() : _getBody(),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          height: kSize1,
          dividerColor: AppColors.kGrey10,
        ),
      ],
    );
  }

  Widget _getList() {
    if (elementsList != null) {
      return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: elementsList!.length,
          itemBuilder: (BuildContext context, int index) {
            String bookingText = elementsList![index];
            return Padding(
              padding: const EdgeInsets.only(bottom: kSize8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (svgAsset != null)
                    SvgPicture.asset(
                      svgAsset!,
                      fit: BoxFit.contain,
                      color: AppColors.kGrey70,
                      height: kSize24,
                      width: kSize24,
                    ),
                  if (svgAsset != null) const SizedBox(width: kSize4),
                  Expanded(
                    child: isHtml
                        ? Html(
                            data: elementsList![index],
                            style: PackageDetailHelper.getHtmlStyleMap)
                        : Text(bookingText, style: AppTheme.kBodyRegular),
                  ),
                ],
              ),
            );
          });
    } else {
      return const SizedBox();
    }
  }

  Widget _getBody() {
    if (body != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: kSize8),
        child: isHtml
            ? Html(data: body!, style: PackageDetailHelper.getHtmlStyleMap)
            : Text(body!, style: AppTheme.kBodyRegular),
      );
    } else {
      return const SizedBox();
    }
  }
}

// display: Display.LIST_ITEM,
// listStyleType: ListStyleType.DISC,
// padding: EdgeInsets.only(left: kSize4),
