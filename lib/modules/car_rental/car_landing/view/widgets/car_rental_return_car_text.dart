import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

import '../../../../../common/utils/app_theme.dart';

class CarRentalReturnCarText extends StatelessWidget {
  final String text;
  const CarRentalReturnCarText(this.text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTheme.kBody.copyWith(color: AppColors.kGrey50));
  }
}
