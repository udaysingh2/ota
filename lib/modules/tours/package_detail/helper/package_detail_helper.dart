import 'package:flutter/cupertino.dart';
import 'package:flutter_html/style.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

class PackageDetailHelper {
  static Map<String, Style> get getHtmlStyleMap {
    return {
      htmlTagH1: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagH2: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagP: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagLI: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagUL: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagDiv: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagSpan: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagBody: Style.fromTextStyle(AppTheme.htmlBodyWithHeight).copyWith(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
      htmlTagFigure: Style(margin: EdgeInsets.zero),
    };
  }
}
