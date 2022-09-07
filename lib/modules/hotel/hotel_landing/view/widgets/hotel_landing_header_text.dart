import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';

const int _kMaxLines = 1;

class HotelLandingHeaderText extends StatelessWidget {
  final String text;
  const HotelLandingHeaderText({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: _kMaxLines,
      style: AppTheme.kBodyMedium,
    );
  }
}
