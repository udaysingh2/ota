import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const double _kDefaultElevation = 4.0;
enum OtaAppBarAction {
  backButton,
  filterButton,
  closeButton,
  customTrailingWidget
}

const String _kCloseIconKey = "close_icon";
const String _kFilterIconKey = "filter_icon_key";
const String _kBackIconKey = "back_icon_key";
const String _kSubmitButtonKey = "submitt_button_key";

class OtaAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final List<OtaAppBarAction> actions;
  final bool isElevation;
  final bool isCenterTitle;
  final String? title;
  final String? subTitle;
  final Widget? titleWidget;
  final Widget? subTitleWidget;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Brightness statusBarBrightnessAndroid;
  final Brightness statusBarBrightnessiOS;
  final void Function()? onFilterButterPressed;
  final void Function()? onLeftButtonPressed;
  final void Function()? onCloseButtonPressed;
  final Widget? trailingWidget;
  final Color? backButtonColor;
  final void Function()? onSubtitlePressed;

  const OtaAppBar({
    Key? key,
    this.actions = const [OtaAppBarAction.backButton],
    this.isElevation = false,
    this.isCenterTitle = true,
    this.title = '',
    this.subTitle,
    this.titleWidget,
    this.subTitleWidget,
    this.backgroundColor = Colors.white,
    this.statusBarBrightnessAndroid = Brightness.dark,
    this.titleColor = AppColors.kGrey70,
    this.subTitleColor = AppColors.kGrey50,
    this.onFilterButterPressed,
    this.onLeftButtonPressed,
    this.onCloseButtonPressed,
    this.statusBarBrightnessiOS = Brightness.light,
    this.backButtonColor = AppColors.kGrey70,
    this.onSubtitlePressed,
    this.trailingWidget,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: isElevation ? _kDefaultElevation : 0.0,
      backgroundColor: backgroundColor,
      centerTitle: isCenterTitle,
      title: _buildTitleView(),
      leading: _buildBackButtonView(context, backButtonColor!),
      actions: _buildRightButtonsView(context),
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Platform.isIOS
            ? statusBarBrightnessiOS
            : statusBarBrightnessAndroid,
        statusBarIconBrightness: Platform.isIOS
            ? statusBarBrightnessiOS
            : statusBarBrightnessAndroid,
      ),
    );
  }

  Widget _buildTitleView() {
    return GestureDetector(
      onTap: onSubtitlePressed,
      child: Container(
        key: const Key(_kSubmitButtonKey),
        color: onSubtitlePressed == null
            ? Colors.transparent
            : AppColors.kTrueWhite,
        child: Column(
          crossAxisAlignment: isCenterTitle
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            titleWidget == null
                ? title == null
                    ? const SizedBox.shrink()
                    : Text(
                        title!,
                        style: subTitle == null
                            ? AppTheme.kHeading1Medium
                                .copyWith(color: titleColor)
                            : AppTheme.kHeading1Medium
                                .copyWith(fontSize: kSize16, color: titleColor),
                      )
                : titleWidget!,
            subTitleWidget == null
                ? subTitle == null
                    ? const SizedBox.shrink()
                    : Text(
                        subTitle!,
                        style: AppTheme.kSmall1.copyWith(
                            color: subTitleColor, fontWeight: FontWeight.w300),
                      )
                : subTitleWidget!
          ],
        ),
      ),
    );
  }

  Widget _buildBackButtonView(BuildContext context, Color color) {
    return Offstage(
      offstage: !actions.contains(OtaAppBarAction.backButton),
      child: IconButton(
        key: const Key(_kBackIconKey),
        padding: const EdgeInsets.only(left: kSize14),
        icon: const Icon(Icons.arrow_back_ios),
        color: color,
        iconSize: kSize24,
        onPressed: onLeftButtonPressed ??
            () {
              Navigator.of(context).maybePop();
            },
      ),
    );
  }

  List<Widget> _buildRightButtonsView(BuildContext context) {
    return <Widget>[
      Offstage(
        offstage: !actions.contains(OtaAppBarAction.filterButton),
        child: IconButton(
          key: const Key(_kFilterIconKey),
          padding: const EdgeInsets.only(right: kSize14),
          icon: SvgPicture.asset("assets/images/icons/icon_filter.svg"),
          iconSize: kSize24,
          onPressed: onFilterButterPressed ?? onFilterButterPressed,
        ),
      ),
      Offstage(
        offstage: !actions.contains(OtaAppBarAction.closeButton),
        child: IconButton(
          key: const Key(_kCloseIconKey),
          padding: const EdgeInsets.only(right: kSize14),
          icon: const Icon(Icons.close),
          color: AppColors.kGrey6,
          iconSize: kSize24,
          onPressed: onCloseButtonPressed ??
              () {
                Navigator.of(context).pop();
              },
        ),
      ),
      Offstage(
        offstage: !actions.contains(OtaAppBarAction.customTrailingWidget),
        child: Padding(
          padding: const EdgeInsets.only(right: kSize16),
          child: trailingWidget ?? const SizedBox(),
        ),
      )
    ];
  }
}
