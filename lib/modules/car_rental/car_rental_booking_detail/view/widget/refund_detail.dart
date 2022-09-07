import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const int _kMaxLine = 1;

class RefundDetail extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  const RefundDetail({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRefundShow =
        carBookingDetailBloc.state.bookingDetail?.activityStatus ==
                CarActivityStatus.userCancelled ||
            carBookingDetailBloc.state.bookingDetail?.activityStatus ==
                CarActivityStatus.rejected;

    if (!isRefundShow) {
      return const SizedBox.shrink();
    }
    CarBookingDetailModel? carBookingDetails =
        carBookingDetailBloc.state.bookingDetail?.carBookingDetails;
    double totalPayablePrice = carBookingDetails?.totalPayablePrice ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.refundDetails),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize24),
        _getServiceOption(
          title: getTranslated(context, AppLocalizationsStrings.paidAmount),
          price: totalPayablePrice,
        ),
        const SizedBox(height: kSize4),
        _getServiceOption(
          title: getTranslated(
              context, AppLocalizationsStrings.carCancellationFee),
          price: carBookingDetails?.cancellationCharge ?? 0,
        ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        _getServiceOption(
          title:
              getTranslated(context, AppLocalizationsStrings.totalRefundAmount),
          price: carBookingDetails?.totalRefundAmount ?? 0,
          style: AppTheme.kBodyMedium,
          isGradientText: true,
        ),
        const SizedBox(height: kSize24),
      ],
    );
  }

  Widget _getServiceOption({
    required String title,
    required double price,
    TextStyle style = AppTheme.kBodyRegular,
    bool isGradientText = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: style,
          maxLines: _kMaxLine,
        ),
        const SizedBox(width: kSize20),
        Expanded(
          child: isGradientText
              ? OtaGradientText(
                  gradientText: CurrencyUtil().getFormattedPrice(price),
                  gradientTextStyle: AppTheme.kBodyMedium,
                  textAlign: TextAlign.end,
                  maxlines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  CurrencyUtil().getFormattedPrice(price),
                  style: AppTheme.kBodyMedium,
                  textAlign: TextAlign.end,
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ],
    );
  }
}
