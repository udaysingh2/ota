import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const String _kCarPlaceholder =
    'assets/images/illustrations/car_booking_detail_placeholder.png';

class CarBookingDetailHeader extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  const CarBookingDetailHeader({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBookingStatus(context),
        const SizedBox(height: kSize10),
        _buildBookingID(context),
        Text(
          '${getTranslated(context, AppLocalizationsStrings.referenceId)}: ${carBookingDetailBloc.state.bookingDetail?.bookingUrn ?? ''}',
          style: AppTheme.kSmallMedium.copyWith(color: AppColors.kGrey50),
        ),
        const SizedBox(height: kSize16),
        _getImageCard(),
        const SizedBox(height: kSize16),
        _buildSupplierDetail(context),
        const SizedBox(height: kSize16),
      ],
    );
  }

  Widget _buildBookingID(BuildContext context) {
    String? bookingId =
        carBookingDetailBloc.state.bookingDetail?.bookingId ?? '';

    return carBookingDetailBloc.showBookingId
        ? Padding(
            padding: const EdgeInsets.only(bottom: kSize4),
            child: Text(
              '${getTranslated(context, AppLocalizationsStrings.reservationId)}: $bookingId',
              style: AppTheme.kBodyMedium,
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildBookingStatus(BuildContext context) {
    String displayStatus =
        carBookingDetailBloc.state.bookingDetail?.displayStatus ?? '';
    String onlyText = getTranslated(context, AppLocalizationsStrings.onlyOn);
    onlyText = onlyText.isEmpty ? onlyText : onlyText.addLeadingSpace();
    return carBookingDetailBloc.showFailedBookingStatus
        ? Text(
            displayStatus +
                (carBookingDetailBloc.state.bookingDetail?.activityStatus ==
                        CarActivityStatus.userCancelled
                    ? onlyText.addTrailingSpace() +
                        Helpers.getddMMMyyyy(carBookingDetailBloc
                                .state
                                .bookingDetail
                                ?.carBookingDetails
                                ?.cancellationDate ??
                            DateTime.now())
                    : ''),
            style: AppTheme.kBodyMedium.copyWith(color: AppColors.kSystemWrong),
          )
        : Row(
            children: [
              Ink(
                height: kSize20,
                width: kSize20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.kPurpleGradient,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.kLight100,
                  size: kSize14,
                ),
              ),
              const SizedBox(width: kSize12),
              OtaGradientText(
                gradientText: displayStatus,
                gradientTextStyle: AppTheme.kBodyMedium,
              )
            ],
          );
  }

  Widget _getImageCard() {
    String imageUrl = carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.car?.images?.full ??
        '';
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: imageUrl.isEmpty
          ? _getDefaultPlaceholder()
          : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: kSize152,
              errorWidget: (context, url, error) => _getDefaultPlaceholder(),
              placeholder: (context, url) => _getDefaultPlaceholder(),
            ),
    );
  }

  Widget _getDefaultPlaceholder() {
    return Image.asset(
      _kCarPlaceholder,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      height: kSize152,
      width: double.infinity,
    );
  }

  Widget _buildSupplierDetail(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (carBookingDetailBloc.state.bookingDetail?.carBookingDetails
                            ?.car?.brand ??
                        '') +
                    (carBookingDetailBloc.state.bookingDetail?.carBookingDetails
                                ?.car?.name ??
                            '')
                        .addLeadingSpace(),
                style: AppTheme.kHeading1Medium,
              ),
              Text(
                (carBookingDetailBloc.state.bookingDetail?.carBookingDetails
                            ?.car?.crafttype ??
                        '') +
                    getTranslated(context, AppLocalizationsStrings.orSimilar)
                        .addLeadingSpace(),
                style:
                    AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              ),
            ],
          ),
        ),
        _getSupplierLogoImage(),
      ],
    );
  }

  Widget _getSupplierLogoImage() {
    String logoUrl = carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.supplier?.logo ??
        '';
    return logoUrl.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kBorderGrey,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  logoUrl,
                ),
                fit: BoxFit.contain,
              ),
            ),
            height: kSize40,
            width: kSize40,
          );
  }
}
