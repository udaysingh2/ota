import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';

class OtaProgressDot extends StatelessWidget {
  final int numberOfDots;
  final int onIndex;
  const OtaProgressDot({Key? key, required this.numberOfDots, this.onIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: kSize8),
          height: kSize10,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: numberOfDots,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: kSize4Point8),
                  height: kSize5,
                  width: kSize4Point8,
                  decoration: index == onIndex
                      ? const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.kSecondary)
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.kGreyGradient),
                );
              }),
        ),
      ),
    );
  }
}
