import 'package:flutter/material.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_controller.dart';

import 'fab_widget.dart';

class OtaFabIcon extends StatelessWidget {
  final Function()? onPressed;
  final FabWidgetController fabWidgetController = FabWidgetController();
  OtaFabIcon({Key? key, 
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded();
  }

  Widget expanded() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: OTAFabWidget(
        fabWidgetController: fabWidgetController,
      ),
    );
  }
}
