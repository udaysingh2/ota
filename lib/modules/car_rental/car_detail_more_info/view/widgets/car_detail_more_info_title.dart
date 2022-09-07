import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class CarDetailMoreInfoTitle extends StatelessWidget {
  final String title;
  const CarDetailMoreInfoTitle({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTitle();
  }

  Widget _getTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: kSize24, top: kSize30),
      child: Text(
        title,
        style: AppTheme.kHeadline1,
      ),
    );
  }
}
