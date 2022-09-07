import 'dart:ui';

import 'package:flutter/material.dart';

class OtaFrostedTransition extends AnimatedWidget {
  final Widget? child;
  final Animation<double>? animation;

  OtaFrostedTransition({
    Key? key,
    this.child,
    this.animation,
  }) : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: animation!.value,
        sigmaX: animation!.value,
      ),
      child: Container(child: child),
    );
  }
}
