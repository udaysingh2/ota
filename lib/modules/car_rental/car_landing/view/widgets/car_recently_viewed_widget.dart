import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/car_rental/car_landing/helpers/string_to_date.dart';

import '../../../../../common/utils/app_localization_strings.dart';
import '../../../../../common/utils/helper.dart';
import '../../../../../core_pack/custom_widgets/ota_button_bottom_bar.dart';
import '../../../../../core_pack/custom_widgets/ota_gradient_text_widget.dart';
import '../../../../../core_pack/custom_widgets/ota_horizontal_divider.dart';
import '../../../../../core_pack/i18n/language_constants.dart';
import '../../view_model/car_landing_view_model.dart';

const _kWidth = 310.0;
const _kHeight = 152.0;
const _maxLine = 2;
const _kBoxHeight = 250.0;
const _kImage = 'assets/images/icons/car.svg';
const _kHeightBottomSheet = 180.0;
const _maxLines = 2;
const Offset _offset = Offset(0, 4);

class CarRecentlyViewedCards extends StatelessWidget {
  final List<CarRecentSearchListViewModel> carRecentSearchList;
  final Function(int)? onPress;
  final Function()? onClearConfirm;

  const CarRecentlyViewedCards(
      {Key? key,
      required this.carRecentSearchList,
      this.onPress,
      this.onClearConfirm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kBoxHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          children: [
            if (carRecentSearchList.isNotEmpty) _topHeader(context),
            const SizedBox(height: kSize16),
            _recentlySearchedList(carRecentSearchList),
            const SizedBox(height: kSize40),
          ],
        ),
      ),
    );
  }

  Widget _topHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getTranslated(context, AppLocalizationsStrings.recentlyView),
            style: AppTheme.kHeading1Medium),
        InkWell(
          onTap: () => _landingBottomSheet(context),
          child: Text(getTranslated(context, AppLocalizationsStrings.clearAll),
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
        )
      ],
    );
  }

  Widget _recentlySearchedList(
      List<CarRecentSearchListViewModel> carRecentSearchList) {
    return Expanded(
      child: ListView.separated(
        itemCount: carRecentSearchList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kSize5),
            child:
                _recentSearchItem(carRecentSearchList[index], context, index),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: kSize8);
        },
      ),
    );
  }

  Widget _recentSearchItem(CarRecentSearchListViewModel carRecentSearchModel,
      BuildContext context, int index) {
    return InkWell(
      onTap: () => onPress != null ? onPress!(index) : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: kSize2,
                offset: _offset,
                color: Colors.black.withOpacity(0.04))
          ],
          border: Border.all(width: kSize1, color: AppColors.kGrey4),
          borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
        ),
        width: _kWidth,
        height: _kHeight,
        child: Padding(
          padding: const EdgeInsets.all(kSize16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getLocationView(carRecentSearchModel),
              const SizedBox(height: kSize16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize4),
                child: OtaHorizontalDivider(
                  height: kSize1,
                  dividerColor: AppColors.kGrey4,
                ),
              ),
              const SizedBox(height: kSize16),
              Text(
                ("${Helpers.getwwddMMMyyhhmm(StringToDate.getDateFromString(carRecentSearchModel.pickupDate ?? '', carRecentSearchModel.pickupTime ?? ''))}${' - '}${Helpers.getwwddMMMyyhhmm(StringToDate.getDateFromString(carRecentSearchModel.returnDate ?? '', carRecentSearchModel.returnTime ?? ''))}"),
                overflow: TextOverflow.ellipsis,
                maxLines: _maxLine,
                style: AppTheme.kSmallRegular,
              ),
              const SizedBox(height: kSize4),
              Text(
                "${getTranslated(context, AppLocalizationsStrings.driversAge)}${' '}${carRecentSearchModel.age.toString()}",
                overflow: TextOverflow.ellipsis,
                maxLines: _maxLine,
                style:
                    AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getLocationView(CarRecentSearchListViewModel carRecentSearchModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(_kImage),
        const SizedBox(
          width: kSize16,
        ),
        Expanded(
          child: Text(
            "${carRecentSearchModel.pickupLocationName}${' - '}${carRecentSearchModel.returnLocationName}",
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallMedium,
            maxLines: _maxLines,
          ),
        ),
      ],
    );
  }

  _landingBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(kSize20)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(kSize24),
            child: SafeArea(
              child: SizedBox(
                height: _kHeightBottomSheet,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        getTranslated(context,
                            AppLocalizationsStrings.clearAllRecentlyViewed),
                        style: AppTheme.kHeading1Medium),
                    const SizedBox(height: kSize8),
                    Text(
                        getTranslated(
                            context,
                            AppLocalizationsStrings
                                .allRecentViewedInformationWillbeDeleted),
                        textAlign: TextAlign.center,
                        style: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50)),
                    const SizedBox(height: kSize24),
                    _getBottomBar(context),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _getBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      containerHeight: kSize74,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize9),
      button1: InkWell(
        key: const Key("NavigateToLandingPage"),
        borderRadius: AppTheme.kBorderRadiusAll24,
        splashColor: AppColors.kGradientEnd,
        hoverColor: AppColors.kGradientEnd,
        highlightColor: AppColors.kGradientEnd,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.kLight100.withOpacity(0.94),
            borderRadius: AppTheme.kBorderRadiusAll24,
          ),
          child: Center(
            child: OtaGradientText(
              gradientText:
                  getTranslated(context, AppLocalizationsStrings.cancel),
              gradientTextStyle: AppTheme.kButton,
              textGradientStartColor: AppColors.kGradientStart,
              textGradientEndColor: AppColors.kGradientEnd,
              gradientTextBegin: Alignment.bottomCenter,
              gradientTextEnd: Alignment.topLeft,
              maxlines: _maxLine,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      button2: Material(
        child: InkWell(
          key: const Key("NavigateToActivityPage"),
          borderRadius: AppTheme.kBorderRadiusAll24,
          splashColor: AppColors.kGradientEnd,
          hoverColor: AppColors.kGradientEnd,
          highlightColor: AppColors.kGradientEnd,
          child: Ink(
            decoration: const BoxDecoration(
              color: AppColors.kPurpleOutline,
              borderRadius: AppTheme.kBorderRadiusAll24,
              gradient: AppColors.kPurpleGradient,
            ),
            child: Center(
              child: Text(
                getTranslated(context, AppLocalizationsStrings.confirm),
                style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
                maxLines: _maxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          onTap: () => onTap(context),
        ),
      ),
    );
  }

  onTap(BuildContext context) {
    onClearConfirm != null ? onClearConfirm!() : null;
    Navigator.pop(context);
  }
}
