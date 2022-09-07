import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/consts.dart';

const double kWidth = 10;

class OtaCancelIcon extends StatelessWidget {
  final String imageUrl;
  final String cancelText;
  final TextStyle? style;
  final Widget? textWidget;
  final Function()? onTap;

  const OtaCancelIcon(
      {required this.imageUrl,
      required this.cancelText,
      required this.style,
      this.textWidget,
      this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kSize10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(imageUrl),
            const SizedBox(
              width: kWidth,
            ),
            textWidget ?? Text(cancelText, style: style),
          ],
        ),
      ),
    );
  }
}
