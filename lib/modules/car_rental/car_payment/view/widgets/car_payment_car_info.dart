import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/string_extension.dart';

import '../../../../../common/utils/app_colors.dart';
import '../../../../../common/utils/app_localization_strings.dart';
import '../../../../../common/utils/app_theme.dart';
import '../../../../../common/utils/consts.dart';
import '../../../../../common/utils/helper.dart';
import '../../../../../core_components/bloc/bloc_builder.dart';
import '../../../../../core_pack/custom_widgets/ota_icon_button.dart';
import '../../../../../core_pack/i18n/language_constants.dart';
import '../../../car_reservation/view/widgets/car_reservation_controller.dart';
import '../../../car_reservation/view/widgets/car_reservation_info_model.dart';
import 'car_payment_price_widget.dart';

const int _kMaxLines = 1;
const int _kMaxLines2 = 2;

const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kInfoIcon = 'assets/images/icons/uil_info-circle.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";
const String _kAotomaticType = 'A';
const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';

class CarPaymentCarInfo extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? serviceProvider;
  final DateTime pickUpDate;
  final DateTime returnDate;

  final Function()? onPress;
  final int? noOfSeats;
  final String? gear;
  final int? noOfDoors;
  final int? noOfLargeBag;
  final int? noOfSmallBag;
  final String? cancellationPolicy;
  final double? totalPrice;

  final CarInfoReservationController controller =
      CarInfoReservationController();

  CarPaymentCarInfo({
    this.imageUrl,
    this.onPress,
    this.noOfSeats,
    this.gear,
    this.noOfDoors,
    this.noOfLargeBag,
    this.noOfSmallBag,
    this.name,
    this.serviceProvider,
    required this.pickUpDate,
    required this.returnDate,
    this.cancellationPolicy,
    this.totalPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        children: [
          _getCarListHeader(context),
          _getCarDetails(context),
        ],
      ),
    );
  }

  Widget _getCarDetails(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Offstage(
            offstage: controller.state.state ==
                CarInfoReservationModelState.collapsed,
            child: _getCarPaymentCarInfo(context),
          );
        });
  }

  Widget _getCarPaymentCarInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kSize56),
      child: Column(
        children: [
          const SizedBox(
            height: kSize16,
          ),
          _getCarPaymentCarInfoItem(
            context: context,
            icon: _kNoOfSeatIcon,
            title: noOfSeats.toString() +
                getTranslated(
                        context, AppLocalizationsStrings.carRentalOnlySeats)
                    .addLeadingSpace(),
          ),
          _getCarPaymentCarInfoItem(
            context: context,
            icon: _kNoOfDoorsIcon,
            title: noOfDoors.toString() +
                getTranslated(context, AppLocalizationsStrings.doors)
                    .addLeadingSpace(),
          ),
          noOfLargeBag != 0
              ? _getCarPaymentCarInfoItem(
                  context: context,
                  icon: _kNoOfBagsIcon,
                  title:
                      getTranslated(context, AppLocalizationsStrings.bagsOnly) +
                          noOfLargeBag.toString() +
                          getTranslated(context,
                                  AppLocalizationsStrings.carRentalOnlyBags)
                              .addLeadingSpace(),
                )
              : const SizedBox.shrink(),
          _getCarPaymentCarInfoItem(
            context: context,
            icon: _kAutomaticIcon,
            title: getTranslated(
                context,
                gear == _kAotomaticType
                    ? AppLocalizationsStrings.automatic
                    : AppLocalizationsStrings.manual),
          ),
          _getCarPaymentCarInfoItem(
            context: context,
            icon: _kInfoIcon,
            title: cancellationPolicy!,
          ),
          CarPaymentPriceWidget(
            totalPrice: totalPrice ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _getCarPaymentCarInfoItem({
    required BuildContext context,
    required String icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: [
          SizedBox(
            height: kSize20,
            width: kSize20,
            child: Center(
              child: SvgPicture.asset(
                icon,
                color: AppColors.kGrey70,
              ),
            ),
          ),
          const SizedBox(width: kSize8),
          Expanded(
            child: Text(
              title,
              style: AppTheme.kSmall1.copyWith(color: AppColors.kGrey70),
              maxLines: _kMaxLines2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCarListHeader(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: kSize44,
                    height: kSize44,
                    child: imageUrl != null
                        ? _getImageCard()
                        : _getDefaultImage(context),
                  ),
                  const SizedBox(width: kSize16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (name != null)
                          _getName(
                            name!,
                            AppTheme.kBodyMedium,
                            maxLines: _kMaxLines2,
                          ),
                        const SizedBox(
                          height: kSize4,
                        ),
                        if (serviceProvider != null)
                          _getName(
                            serviceProvider!,
                            AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                              height: kSize1,
                            ),
                            maxLines: _kMaxLines2,
                          ),
                        const SizedBox(
                          height: kSize8,
                        ),
                        _getName(
                          Helpers.getwwddMMMyy(pickUpDate).addTrailingDash() +
                              Helpers.getwwddMMMyy(returnDate),
                          AppTheme.kSmallRegular.copyWith(
                            color: AppColors.kGrey50,
                            height: kSize1,
                          ),
                          maxLines: _kMaxLines,
                        ),
                        if (cancellationPolicy != null)
                          const SizedBox(
                            height: kSize4,
                          ),
                        if (cancellationPolicy != null &&
                            controller.state.state !=
                                CarInfoReservationModelState.expanded)
                          Text(
                            cancellationPolicy!,
                            style: AppTheme.kSmallRegular
                                .copyWith(color: AppColors.kGrey70),
                            maxLines: _kMaxLines,
                          ),
                      ],
                    ),
                  ),
                  Container(
                      transform: Matrix4.translationValues(
                          kSize8, -kSize8, Offset.zero.dy),
                      child: _getTrailing()),
                ],
              ),
            ],
          );
        });
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: SvgPicture.asset(_kPlaceholderImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width - kSize48),
    );
  }

  Widget _getTrailing() {
    return OtaIconButton(
      icon: controller.state.state == CarInfoReservationModelState.expanded
          ? SvgPicture.asset(
              _arrowUp,
              width: kSize20,
              height: kSize20,
            )
          : SvgPicture.asset(
              _arrowDown,
              width: kSize20,
              height: kSize20,
            ),
      onTap: () {
        controller.toggle();
      },
    );
  }

  Widget _getName(String name, TextStyle? textStyle, {int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines ?? _kMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
