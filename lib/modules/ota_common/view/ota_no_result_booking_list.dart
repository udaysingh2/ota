import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class OtaBookingNoResult extends StatelessWidget {
  final String errorMsg;

  const OtaBookingNoResult({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Text(
          getTranslated(
            context,
            errorMsg,
          ),
          style: AppTheme.kSmallRegular.copyWith(
            color: AppColors.kGrey50,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
