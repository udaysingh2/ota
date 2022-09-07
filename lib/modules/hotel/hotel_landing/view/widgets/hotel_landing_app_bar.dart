import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';

const double _kDefaultAppBarHeight = 89;

class HotelLandingAppBar extends StatelessWidget {
  final Widget child;
  const HotelLandingAppBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getAppBar(context);
  }

  Widget getAppBar(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: SizedBox(
            height: _kDefaultAppBarHeight - MediaQuery.of(context).padding.top,
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kSize24),
                  topRight: Radius.circular(kSize24),
                )),
            child: child,
          ),
        )
      ],
    );
  }
}
