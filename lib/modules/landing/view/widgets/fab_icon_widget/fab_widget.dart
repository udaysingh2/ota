import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_fab_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_controller.dart';

const _kDuration = Duration(milliseconds: 275);
const _kHeartIcon = "assets/images/icons/heart.svg";
const _kMyOrderListIcon = "assets/images/icons/my_order_list.svg";
const _kTextBoxIcon = "assets/images/icons/text_box.svg";
const _kMainMenuIcon = "assets/images/icons/main_menu.svg";
const String _kHotelKey = "hotel_key";

class OTAFabWidget extends StatelessWidget {
  final FabWidgetController fabWidgetController;

  const OTAFabWidget({Key? key, required this.fabWidgetController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: fabWidgetController,
      builder: () {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              AnimatedSwitcher(
                duration: _kDuration,
                child: fabWidgetController.isExpanded()
                    ? GestureDetector(
                        onTap: () {
                          fabWidgetController.toggle();
                        },
                        child: Container(
                          color: AppColors.kBlackOpacity40,
                        ),
                      )
                    : const SizedBox(),
              ),
              _buildFAB(
                context: context,
                isExpanded: fabWidgetController.isExpanded(),
                iconSvgAsset: _kHeartIcon,
                index: 3,
                onPressed: () {
                  fabWidgetController.toggle();
                  Navigator.of(context)
                      .pushNamed(AppRoutes.otaFavouritesListingScreen);
                },
                text: AppLocalizationsStrings.favourites,
              ),
              // _buildFAB(
              //   context: context,
              //   isExpanded: fabWidgetController.isExpanded(),
              //   iconSvgAsset: "assets/images/icons/credit_card.svg",
              //   index: 3,
              //   onPressed: () {},
              //   text: AppLocalizationsStrings.payment,
              // ),
              _buildFAB(
                context: context,
                isExpanded: fabWidgetController.isExpanded(),
                iconSvgAsset: _kMyOrderListIcon,
                index: 2,
                onPressed: () {
                  fabWidgetController.toggle();
                  Navigator.of(context).pushNamed(AppRoutes.otaBookingScreen,
                      arguments: _kHotelKey);
                },
                text: AppLocalizationsStrings.myOrderList,
              ),
              _buildFAB(
                context: context,
                isExpanded: fabWidgetController.isExpanded(),
                iconSvgAsset: _kTextBoxIcon,
                index: 1,
                onPressed: () {
                  fabWidgetController.toggle();
                  Navigator.of(context)
                      .pushNamed(AppRoutes.messageAndNotificationScreen);
                },
                text: AppLocalizationsStrings.messages,
              ),
              Positioned(
                bottom: kSize20 + MediaQuery.of(context).padding.bottom,
                right: kSize14,
                child: OtaFABButton(
                  onPressed: () {
                    fabWidgetController.toggle();
                  },
                  withStroke: true,
                  iconSvgAsset: _kMainMenuIcon,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFAB({
    required BuildContext context,
    required bool isExpanded,
    required String iconSvgAsset,
    required String text,
    required Function() onPressed,
    required int index,
  }) {
    return AnimatedPositioned(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: _kDuration,
      bottom: kSize20 +
          (isExpanded ? (index * kSize68) : kSize0) +
          MediaQuery.of(context).padding.bottom,
      right: kSize14,
      child: AnimatedOpacity(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: _kDuration,
        opacity: isExpanded ? 1 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              getTranslated(context, text),
              style: AppTheme.kAlertTitle.copyWith(color: AppColors.kLight100),
            ),
            const SizedBox(
              width: kSize14,
            ),
            OtaFABButton(
              iconSvgAsset: iconSvgAsset,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
