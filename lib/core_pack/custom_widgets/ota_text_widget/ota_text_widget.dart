import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _kMaxLines = 1;
const double _kHeight = 40;

class OtaTextWidget extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isSelected;

  const OtaTextWidget({
    Key? key,
    required this.title,
    this.onPressed,
    this.isSelected = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: isSelected
            ? Container(
                height: _kHeight,
                margin: const EdgeInsets.symmetric(horizontal: kSize24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
                  border: Border.all(color: AppColors.kSecondary),
                  color: AppColors.kPrimary93,
                ),
                child: _buildTextField())
            : Container(
                height: _kHeight,
                margin: const EdgeInsets.symmetric(horizontal: kSize24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
                  border: Border.all(color: AppColors.kBorderGrey),
                ),
                child: _buildTextField()));
  }

  _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        title,
        maxLines: _kMaxLines,
        style: isSelected
            ? AppTheme.kBodyRegular.copyWith(color: AppColors.kSecondary)
            : AppTheme.kBodyRegular,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
