import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class CarDetailInfoListingItem extends StatelessWidget {
  final String imageUrl;
  final String header;
  final List<String> subHeaders;
  final bool isHtml;
  const CarDetailInfoListingItem(
      {Key? key,
      required this.imageUrl,
      required this.header,
      this.isHtml = false,
      required this.subHeaders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTrianglerWidget();
  }

  Widget _getTrianglerWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize18),
      child: _getLocationWidget(),
    );
  }

  Widget _getLocationWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: kSize16,
          child: Padding(
            padding: const EdgeInsets.only(top: kSize6),
            child: SvgPicture.asset(
              imageUrl,
              color: AppColors.kGrey70,
              height: kSize16,
              width: kSize16,
            ),
          ),
        ),
        const SizedBox(width: kSize8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: AppTheme.kBodyMedium,
              ),
              _getListOfItems(subHeaders),
            ],
          ),
        )
      ],
    );
  }

  Widget _getListOfItems(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(
        items.length,
        (index) {
          if (isHtml) {
            return Html(
              data: items.elementAt(index),
              style: {
                htmlTagP: Style.fromTextStyle(AppTheme.kSmallRegular)
                  ..margin = EdgeInsets.zero
                  ..padding = EdgeInsets.zero,
                htmlTagStrong: Style.fromTextStyle(AppTheme.kBodyMedium)
                  ..margin = EdgeInsets.zero
                  ..padding = EdgeInsets.zero,
                htmlTagBody:
                    Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
                htmlTagFigure: Style(margin: EdgeInsets.zero),
              },
            );
          }
          return Text(
            items.elementAt(index),
            style: AppTheme.kSmallRegular,
          );
        },
      ),
    );
  }
}
