import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';

class OTALoadingIndicator extends StatelessWidget {
  const OTALoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: kPaddingAll16,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
