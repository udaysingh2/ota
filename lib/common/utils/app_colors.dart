import 'package:flutter/material.dart';

class AppColors {
  static const kGrey20 = Color(0xFFABADBA);
  static const kGrey20Alpha50 = Color(0x80ABADBA);
  static const kGrey70 = Color(0xFF454754);
  static const kGrey40 = Color(0xFFF7F7F8);
  static const kGrey40Alpha80 = Color(0xCCF7F7F8);
  static const kGrey40Alpha50 = Color(0x80F7F7F8);
  static const kGrey50 = Color(0xFF73768C);
  static const kLight100 = Color(0xFFFFFFFF);
  static const kGradientStart = Color(0xFFCF1E9E);
  static const kGradientEnd = Color(0xFF7F50B2);
  static const kGradientStartOpacity70 = Color(0xCECF1E9E);
  static const kGradientEndOpacity70 = Color(0xCE7F50B2);
  static const kTextGradientStart = Color(0xFFC524A0);
  static const kTextGradientEnd = Color(0xFF874BB0);
  static const kPrimary = Color(0xFFDB99DB);
  static const kPrimaryHighlight = Color(0xFFBC2AA3);
  static const kSecondarySplash = Color(0x0FA33AA3);
  static const kSecondary = Color(0xFFA33AA3);
  static const kGrey70Alpha50 = Color(0x80454754);
  static const kGreyScale = Color(0xFF615E66);

  static const kBorderGrey = Color(0xFFE3E4E8);
  static const kInnerBorderGrey = Color(0xFFEEEEEE);
  static const kPrimary73 = Color(0xFFDB99DB);
  static const kGrey10 = Color(0xFFE3E4E8);
  static const kGreyLineStroke = Color(0xFFE7E5E4);
  static const LinearGradient gradient1 =
      LinearGradient(colors: <Color>[Color(0xFFCF1E9E), Color(0xFF7F50B2)]);
  static const LinearGradient gradient2 =
      LinearGradient(colors: <Color>[Color(0xFFA33AA3), Color(0xFFA33AA3)]);

  static const kLight100Alpha50 = Color(0x80FFFFFF);
  static const kTrueWhite = Color(0xFFFFFFFF);
  static const kTrueBlack = Color(0xFF000000);
  static const kGrey4 = Color(0xFFF7F7F8);
  static const kGrey6 = Color(0xFFF2F2F2);
  static const kGalleryPlaceholder = Color(0xFFF5F5F7);
  static const kBlack1 = Color(0xFF111111);
  static const kGrey77 = Color(0xFF777777);
  static const kLoadingText = Color(0xFFBDBDBD);
  static const kBlackOpacity40 = Color(0x66000000);
  static const kBlackOpacity50 = Color(0x80000000);
  static const kBlackOpacity80 = Color(0xCC000000);
  static const kPrimary24 = Color(0xFFF6E5F6);
  static const kBlackOpacity08 = Color(0x14000000);
  static const kGrey2 = Color(0xFF4F4F4F);

  static const LinearGradient kPurpleGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFF7F50B2), Color(0xFFCF1E9E)],
    stops: [0.3, 1.0],
    transform: GradientRotation((310.99 * (22 / 7) / 180)),
  );

  static const LinearGradient kGreyGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xFFC4C4C4), Color(0xFFD7D7D7)],
    stops: [0.3, 1.0],
    transform: GradientRotation((310.99 * (22 / 7) / 180)),
  );

  static const LinearGradient kTransparentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    colors: [Color(0x00000000), Color(0x80000000)],
  );

  static const kDefaultHeartSelectedColor = Color(0xFFBC2AA3);
  static const kPurpleOutline = Color(0xFFA33AA3);
  static const kButtonShadowLight = Color(0x50979797);
  static const kSliderUnSelectedColor = Color(0xFFE3E1E5);
  static const kBottomSheetGreyColor = Color(0xFFFAFBFB);
  static const kSystemWrong = Color(0xFFEB6666);
  static const kPrimary93 = Color(0xFFF6E5F6);
  static const kTertiary = Color(0xFFF2C94C);
  static const kBannerColor = Color(0xFFEB6666);
  static const kBannerCSuccessColor = Color(0xFF6FCF97);
  static const kLoadingBackground = Color(0xFFF7F7F7);
  static const kCancelColor = Color(0xFFEB6666);
  static const kBlackColor = Color(0xFF382E38);
  static const kBlackOpacity25 = Color(0x40000000);
  static const kWhiteColor = Color(0xFFFBFBFC);
  static const kBorderColor = Color(0xFF7631C1);
  static const kSystemSuccess = Color(0xFF6FCF97);
  static const LinearGradient gradient1Opacity70 =
      LinearGradient(colors: <Color>[Color(0xB3CF1E9E), Color(0xB37F50B2)]);
  static const kBlackOpacity4 = Color(0x0A000000);

  static const kUnselectedRadioButton = Color(0xFFD9D9D9);
  static const LinearGradient fabGradient =
      LinearGradient(colors: <Color>[Color(0xFF8D48AF), Color(0xFFBF28A2)]);
  static const kShadowAppBar = Color(0X29A28FA3);
  static const kWhiteOpacity65 = Color(0xA6FFFFFF);
}
