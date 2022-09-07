import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

const double kWidth = 10;

class OtaCancelDefaultGradient extends StatelessWidget {
  final String imageUrl;
  final String cancelText;
  final TextStyle? style;
  final Widget? textWidget;
  final Function()? onTap;

  const OtaCancelDefaultGradient(
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
            ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.gradient1.createShader(
                    Offset.zero & bounds.size,
                  );
                },
                child: getTextWidget())
          ],
        ),
      ),
    );
  }

  Widget getTextWidget() {
    return textWidget ?? Text(cancelText, style: style);
  }
}
