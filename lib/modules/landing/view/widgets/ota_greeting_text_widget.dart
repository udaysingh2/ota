import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kGreetingTextTopMargin = 140;
const _kSize0Point5 = 0.5;
const _kSizeMinus9 = -9.0;
const int _kMaxLines = 1;

class GreetingTextWidget extends StatelessWidget {
  final String greetingtext;
  final String customerName;
  const GreetingTextWidget({Key? key, this.greetingtext = "", this.customerName = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: _kGreetingTextTopMargin,right: kSize32),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetingtext,
              style: AppTheme.kHeadline2.copyWith(
                letterSpacing: _kSize0Point5,
                shadows: [kTextHardShadow],
              ),
            ),
            Container(
              transform:
                  Matrix4.translationValues(kSize0, _kSizeMinus9, kSize0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  customerName,
                  style: AppTheme.kHeadline4.copyWith(
                    color: AppColors.kLight100,
                    shadows: [kTextHardShadow],
                  ),
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ));
  }
}
