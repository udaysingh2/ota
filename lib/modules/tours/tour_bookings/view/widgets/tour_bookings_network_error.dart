import 'package:flutter/cupertino.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_widget.dart';

const double _kTopPadding = 24;

class TourBookingsNetworkErrorWidget extends StatelessWidget {
  final double height;
  const TourBookingsNetworkErrorWidget({Key? key, required this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return getErrorWidget(context);
  }

  Widget getErrorWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: height - _kTopPadding,
          child: const OtaNetworkErrorWidget(),
        )
      ],
    );
  }
}
