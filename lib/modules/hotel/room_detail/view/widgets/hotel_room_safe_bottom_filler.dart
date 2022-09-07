import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

const double _kBottomPositioned = 0;

class HomeRoomSafeBottomFilter extends StatelessWidget {
  const HomeRoomSafeBottomFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _kBottomPositioned,
      child: Container(
        height: MediaQuery.of(context).padding.bottom,
        width: MediaQuery.of(context).size.width,
        color: AppColors.kLight100,
      ),
    );
  }
}
