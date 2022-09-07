import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kMaxLines = 2;

class CustomMaterialBanner extends StatelessWidget {
  final String text;
  final String iconString;
  final Color backgroundColor;
  final CrossAxisAlignment? crossAxisAlignment;
  const CustomMaterialBanner(
      {Key? key,
      required this.text,
      required this.iconString,
      required this.backgroundColor,
      this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildAnimation(
      context,
    );
  }

  Widget buildAnimation(BuildContext context) {
    return Material(
      child: Container(
        color: backgroundColor,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: kSize21,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              child: Center(
                child: Row(
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconString,
                      height: kSize24,
                      width: kSize24,
                      color: AppColors.kLight100,
                    ),
                    const SizedBox(width: kSize7),
                    Expanded(
                      child: Text(
                        text,
                        style:
                            AppTheme.kBody.copyWith(color: AppColors.kLight100),
                        maxLines: _kMaxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
