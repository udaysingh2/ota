import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/helpers/car_booking_detail_helper.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const String _kNextArrowIcon = "assets/images/icons/arrow_right.svg";
const int _kMaxLine = 1;
const String _kCarRentalDetailKey = "car_rental_detail_key";

class CarRentalDetail extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  const CarRentalDetail({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarBookingDetailModel? carBookingDetails =
        carBookingDetailBloc.state.bookingDetail?.carBookingDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize15),
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated(
                    context, AppLocalizationsStrings.carRentalDetails),
                style: AppTheme.kBodyMedium,
              ),
            ),
            OtaIconButton(
              key: const Key(_kCarRentalDetailKey),
              icon: SvgPicture.asset(
                _kNextArrowIcon,
              ),
              onTap: () => _goToPickupDropoff(
                  CarDetailInfoPickType.carDetailInfoPickup, context),
            )
          ],
        ),
        const SizedBox(height: kSize10),
        _getTitleText(
          getTranslated(context, AppLocalizationsStrings.pickUp),
        ),
        const SizedBox(height: kSize8),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.pickUpDate),
          detail: Helpers.getwwddMMMyyhhmm(
            carBookingDetails?.pickUpDate ?? DateTime.now(),
          ),
        ),
        const SizedBox(height: kSize8),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.carPickupPoint),
          detail: carBookingDetails?.pickupCounter?.name ?? '',
        ),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        _getTitleText(
          getTranslated(context, AppLocalizationsStrings.dropOff),
        ),
        const SizedBox(height: kSize8),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.dropOffDate),
          detail: Helpers.getwwddMMMyyhhmm(
            carBookingDetails?.dropOffDate ?? DateTime.now(),
          ),
        ),
        const SizedBox(height: kSize8),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.dropOffPoint),
          detail: carBookingDetails?.returnCounter?.name ?? '',
        ),
        if (carBookingDetailBloc.state.bookingDetail?.carBookingDetails!
                    .returnExtraCharge !=
                null &&
            carBookingDetailBloc.state.bookingDetail!.carBookingDetails!
                    .returnExtraCharge! >
                0)
          _setDropText(context),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.duration),
          detail: (carBookingDetails?.rentalDays ?? 0).toString() +
              getTranslated(context, AppLocalizationsStrings.days)
                  .addLeadingSpace(),
        ),
        const SizedBox(height: kSize8),
        _getDetailOption(
          title: getTranslated(context, AppLocalizationsStrings.carSupplier),
          detail: carBookingDetails?.supplier?.name ?? '',
        ),
        if ((carBookingDetails?.driverName ?? '').isNotEmpty ||
            (carBookingDetails?.flightNumber ?? '').isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: kSize16),
            child: OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
          ),
        if ((carBookingDetails?.driverName ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: kSize16),
            child: _getDetailOption(
              title:
                  getTranslated(context, AppLocalizationsStrings.driversName),
              detail: carBookingDetails?.driverName ?? '',
            ),
          ),
        if ((carBookingDetails?.flightNumber ?? '').isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: kSize8),
            child: _getDetailOption(
              title:
                  getTranslated(context, AppLocalizationsStrings.flightNumber),
              detail: carBookingDetails?.flightNumber ?? '',
            ),
          ),
        const SizedBox(height: kSize24),
      ],
    );
  }

  void _goToPickupDropoff(
      CarDetailInfoPickType carDetailInfoPickType, BuildContext context) {
    CarBookingDetailModel? carBookingDetails =
        carBookingDetailBloc.state.bookingDetail?.carBookingDetails;

    CarDetailInfoDataViewModel carDetailInfoDataViewModel =
        CarBookingDetailHelper.getCarDetailInfo(carBookingDetails, context);
    Navigator.pushNamed(
      context,
      AppRoutes.carDetailInfoScreen,
      arguments: CarDetailInfoArgumentModel(
        carDetailInfoCarInfo: CarDetailInfoCarInfo(
          carDetails: carDetailInfoDataViewModel.carDetails,
          facilityList: carBookingDetails?.car?.facilities ?? [],
          pricing: carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoDropOff: CarDetailInfoDropOff(
          carDetails: carDetailInfoDataViewModel.carDetailsDropOff,
          carInfo: carDetailInfoDataViewModel.carInfo,
          pricing: carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoPickup: CarDetailInfoPickup(
          carDetails: carDetailInfoDataViewModel.carDetailsPickUp,
          carInfo: carDetailInfoDataViewModel.carInfo,
          pricing: carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoPickType: carDetailInfoPickType,
        isPriceWidgetVisible: false,
        showMap: true,
        pickupLocation: LocationDataModel(
            lattitude: carDetailInfoDataViewModel.pickupLocation?.lattitude,
            longitude: carDetailInfoDataViewModel.pickupLocation?.longitude),
        dropOffLocation: LocationDataModel(
            lattitude: carDetailInfoDataViewModel.dropOffLocation?.lattitude,
            longitude: carDetailInfoDataViewModel.dropOffLocation?.longitude),
      ),
    );
  }

  Widget _getTitleText(String title) {
    return Text(
      title,
      style: AppTheme.kBodyMedium,
      maxLines: _kMaxLine,
    );
  }

  Widget _getDetailOption({required String title, required String detail}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLine,
        ),
        const SizedBox(width: kSize20),
        Expanded(
          child: Text(
            detail,
            style: AppTheme.kBodyMedium,
            textAlign: TextAlign.end,
            maxLines: _kMaxLine,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  _setDropText(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        Text(
          getTranslated(context, AppLocalizationsStrings.dropOffFeeText),
          style: AppTheme.kSmallRegular,
        ),
      ],
    );
  }
}
