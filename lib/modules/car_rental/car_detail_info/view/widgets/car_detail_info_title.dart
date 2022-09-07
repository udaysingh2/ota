import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';

class CarDetailInfoTitle extends StatelessWidget {
  final String title;
  const CarDetailInfoTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getTitle();
  }

  Widget _getTitle() {
    return Text(
      title,
      style: AppTheme.kHeading1Medium,
    );
  }
}
