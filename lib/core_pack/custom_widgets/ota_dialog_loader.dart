import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';

const double _kDialogOpacity = 0.4;
bool _isLoaderShowing = false;

class OtaDialogLoader {
  showLoader(BuildContext context) {
    if (_isLoaderShowing) return;
    _isLoaderShowing = true;
    showDialog(
      barrierDismissible: false,
      barrierColor: AppColors.kBlackOpacity80.withOpacity(_kDialogOpacity),
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: kSize96,
            width: kSize96,
            decoration: BoxDecoration(
              color: AppColors.kLoadingBackground,
              borderRadius: BorderRadius.circular(kSize10),
            ),
            child: const OTALoadingIndicator(),
          ),
        );
      },
    );
  }

  void hideLoader(BuildContext context) {
    if (_isLoaderShowing) {
      _isLoaderShowing = false;
      Navigator.of(context).pop();
    }
  }
}
