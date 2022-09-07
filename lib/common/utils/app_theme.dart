import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';

import 'consts.dart';

class AppTheme {
  static const TextStyle kHeading1 = TextStyle(
    fontSize: kSize18,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  static const TextStyle kHeading2 = TextStyle(
    fontSize: kSize20,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const TextStyle kHeadline1 = TextStyle(
    fontSize: kSize18,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle kHeadline2 = TextStyle(
    fontSize: kSize22,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle kHeadline4 = TextStyle(
    fontSize: kSize36,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle kHeading4 = TextStyle(
    fontSize: kSize18,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle kHeading5 = TextStyle(
    fontSize: kSize14,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.05,
  );
  static const TextStyle kHeading6 = TextStyle(
    fontSize: kSize22,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.5,
  );
  static const TextStyle kButtonText = TextStyle(
    fontSize: kSize20,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );
  static const TextStyle kHeading3 = TextStyle(
    fontSize: kSize22,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle kBodyGrey50 = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey50,
    fontWeight: FontWeight.w300,
  );
  static const TextStyle kSmall2 = TextStyle(
    fontSize: kSize14,
    color: AppColors.kGrey50,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.25,
  );
  static const TextStyle kHeadline3 = TextStyle(
    fontSize: kSize22,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const TextStyle kHBody = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const TextStyle kBody = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.5,
  );
  static const TextStyle kTitle = TextStyle(
    fontSize: kSize24,
    color: AppColors.kTrueWhite,
    fontWeight: FontWeight.w500,
  );

  static const BorderRadius kBorderRadiusAll20 =
      BorderRadius.all(Radius.circular(20));
  static const BorderRadius kBorderRadiusAll24 =
      BorderRadius.all(Radius.circular(24));

  static const BorderRadius kBorderRadiusTop24 = BorderRadius.only(
    topLeft: (Radius.circular(24)),
    topRight: (Radius.circular(24)),
  );
  static const BorderRadius kBorderRadiusTop12 = BorderRadius.only(
    topLeft: (Radius.circular(12)),
    topRight: (Radius.circular(12)),
  );

  static const TextStyle kSmall1 = TextStyle(
    fontSize: kSize14,
    fontWeight: FontWeight.w400,
    letterSpacing: kLetterSpacing25,
    color: AppColors.kGrey50,
  );

  static const Border kborderAllGrey10 = Border(
    left: BorderSide(width: 1, color: AppColors.kGrey10),
    right: BorderSide(width: 1, color: AppColors.kGrey10),
    bottom: BorderSide(width: 1, color: AppColors.kGrey10),
    top: BorderSide(width: 1, color: AppColors.kGrey10),
  );

  static const TextStyle kBody12 = TextStyle(
    fontSize: kSize12,
    color: AppColors.kLoadingText,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  );

  static const TextStyle kofferPercentageLeading = TextStyle(
    fontSize: kSize14,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
  static const TextStyle kofferPercentageNumber = TextStyle(
    fontSize: kSize20,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );
  static const TextStyle kofferPercentageFooter = TextStyle(
    fontSize: kSize14,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
  static const TextStyle kofferDiscountFooter = TextStyle(
    fontSize: kSize12,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
  static const TextStyle kofferDiscountHeader = TextStyle(
    fontSize: kSize8,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle kButton2 = TextStyle(
    fontSize: kSize14,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    fontFamily: kFontFamily,
  );
  static const TextStyle kAlertTitle = TextStyle(
    fontSize: kSize16,
    color: AppColors.kBlack1,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );
  static const TextStyle kHeading2Alternate = TextStyle(
    fontSize: kSize22,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  );
  static const TextStyle kButton3 = TextStyle(
    fontSize: kSize16,
    color: AppColors.kLight100,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    fontFamily: kFontFamily,
  );

  static const TextStyle kLoadingText = TextStyle(
    fontSize: kSize30,
    color: AppColors.kGrey4,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  );

  static const TextStyle htmlBodyText = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: kFontFamily,
  );

  static const TextStyle kPreferenceDescriptionText = TextStyle(
    fontSize: kSize15,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  ///New style as per v1.5
  static const TextStyle kHeading2Medium = TextStyle(
    fontSize: kSize36,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kHeading2Regular = TextStyle(
    fontSize: kSize36,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kHeading1Medium = TextStyle(
    fontSize: kSize20,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );
  static const TextStyle kHeading1Regular = TextStyle(
    fontSize: kSize20,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kBodyMedium = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kBodyRegular = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kSmallMedium = TextStyle(
    fontSize: kSize14,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static const TextStyle kSmallRegular = TextStyle(
    fontSize: kSize14,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );
  static const TextStyle kSmallerMedium = TextStyle(
    fontSize: kSize12,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );
  static const TextStyle kSmallerRegular = TextStyle(
    fontSize: kSize12,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );
  static const TextStyle kButton = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    fontFamily: kFontFamily,
  );

  static TextStyle get kBodyRegularGrey50 {
    return kBodyRegular.copyWith(color: AppColors.kGrey50);
  }

  static TextStyle get kSmallRegularGradient {
    return kSmallRegular.copyWith(color: AppColors.kLight100);
  }

  static const TextStyle htmlBodyWithHeight = TextStyle(
    fontSize: kSize16,
    color: AppColors.kGrey70,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle kRichTextStyle(TextStyle style) {
    return style.copyWith(fontFamily: kFontFamily);
  }
}
