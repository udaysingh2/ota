import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/modules/tours/package_detail/helper/package_detail_helper.dart';

class PackageSectionWidgetWithoutBullet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<String>? elementsList;
  final String? body;
  final bool isHtml;

  const PackageSectionWidgetWithoutBullet({
    Key? key,
    required this.title,
    this.subtitle,
    this.elementsList,
    this.body,
    this.isHtml = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Text(
          title,
          style: AppTheme.kHeading1,
        ),
        const SizedBox(height: kSize16),
        if (subtitle != null)
          Text(
            subtitle!,
            style: AppTheme.kBody,
          ),
        if (subtitle != null) const SizedBox(height: kSize16),
        if (body != null)
          isHtml
              ? Html(
                  data: body!,
                  style: PackageDetailHelper.getHtmlStyleMap,
                )
              : Text(
                  body!,
                  style: AppTheme.kBody,
                ),
        if (elementsList != null)
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: elementsList!.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Text(
                  elementsList![index],
                  style: AppTheme.kBody,
                );
              }),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          height: kSize1,
          dividerColor: AppColors.kGrey10,
        ),
      ],
    );
  }
}
