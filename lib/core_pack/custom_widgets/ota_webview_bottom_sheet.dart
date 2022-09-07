import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';

class OtaWebViewBottomSheet {
  final double radiusTopLeft;
  final double radiusTopRight;
  final double bottomSheetHeight;
  final bool isScrollControlled;
  final bool enableDrag;
  final bool isDismissible;

  const OtaWebViewBottomSheet(
      {this.radiusTopLeft = kSize0,
      this.radiusTopRight = kSize0,
      this.bottomSheetHeight = kSize200,
      this.isScrollControlled = true,
      this.enableDrag = true,
      this.isDismissible = true});

  Future<void> showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTopLeft),
          topRight: Radius.circular(radiusTopLeft),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: bottomSheetHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kSize10, horizontal: kSize10),
              child: OtaBackButton(onPress: () {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
