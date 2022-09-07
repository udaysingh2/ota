import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const int _kMaxLines = 1;
const double _kInnerPadding = kSize8;
const double _kOuterPadding = kSize4;

class KeyAmenitiesWidget extends StatelessWidget {
  final List<String> amenitiesList;
  const KeyAmenitiesWidget(
    this.amenitiesList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double maxAvailableWidth = constraints.maxWidth;
      List<Widget> firstRowWidgets = [];
      List<Widget> secondRowWidgets = [];

      _buildFirstRowWidgets(
          firstRowWidgets, amenitiesList, maxAvailableWidth, context);
      _buildSecondRowWidgets(secondRowWidgets, amenitiesList, maxAvailableWidth,
          firstRowWidgets.length, context);

      return Padding(
        padding: const EdgeInsets.only(top: kSize7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: firstRowWidgets,
            ),
            if (secondRowWidgets.isNotEmpty) ...[
              const SizedBox(height: kSize4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: secondRowWidgets,
              ),
            ],
          ],
        ),
      );
    });
  }
}

void _buildSecondRowWidgets(
    List<Widget> secondRowWidgets,
    List<String> amenitiesList,
    double maxAvailableWidth,
    int index,
    BuildContext context) {
  int additional = 0;
  double secondRowWidth = 0.0;

  for (int i = index; i < amenitiesList.length; i++) {
    String ammenity = _getAmmenity(amenitiesList[i]);
    double widgetWidth = _getWidgetWidth(ammenity, context);
    if (secondRowWidth + widgetWidth < maxAvailableWidth) {
      secondRowWidgets.add(_buildChip(ammenity));
      index++;
      secondRowWidth += widgetWidth;
    } else {
      additional = amenitiesList.length - index;
      final additionalWidth = _getWidgetWidth('+$additional', context);
      if (secondRowWidth + additionalWidth < maxAvailableWidth) {
        secondRowWidgets.add(_buildChip('+$additional'));
        break;
      } else {
        secondRowWidgets.removeLast();
        index--;
        additional = amenitiesList.length - index;
        secondRowWidgets.add(_buildChip('+$additional'));
        break;
      }
    }
  }
}

void _buildFirstRowWidgets(
    List<Widget> firstRowWidgets,
    List<String> amenitiesList,
    double maxAvailableWidth,
    BuildContext context) {
  double firstRowWidth = 0.0;

  for (int i = 0; i < amenitiesList.length; i++) {
    String ammenity = _getAmmenity(amenitiesList[i]);
    double widgetWidth = _getWidgetWidth(ammenity, context);
    if (firstRowWidth + widgetWidth < maxAvailableWidth) {
      firstRowWidgets.add(_buildChip(ammenity));
      firstRowWidth += widgetWidth;
    } else {
      break;
    }
  }
}

String _getAmmenity(String ammenity) {
  return ammenity.length <= 18 ? ammenity : ammenity.substring(0, 18);
}

double _getWidgetWidth(String string, BuildContext context) {
  return (_kInnerPadding * 2) +
      (_kOuterPadding) +
      _getTextWidth(string, context);
}

double _getTextWidth(String string, BuildContext context) {
  final textSpan = TextSpan(
    text: string,
    style: AppTheme.kSmallerRegular.copyWith(color: AppColors.kPurpleOutline),
  );
  final textPainter = TextPainter(
    text: textSpan,
    textScaleFactor: MediaQuery.of(context).textScaleFactor,
    maxLines: _kMaxLines,
    textDirection: TextDirection.ltr,
  )..layout();
  return textPainter.width;
}

Widget _buildChip(String ammenity) {
  return Container(
    margin: const EdgeInsets.only(right: kSize4),
    decoration: const BoxDecoration(
        color: AppColors.kPrimary93,
        borderRadius: BorderRadius.all(Radius.circular(kSize20))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize8, vertical: kSize1),
      child: Text(
        ammenity,
        style:
            AppTheme.kSmallerRegular.copyWith(color: AppColors.kPurpleOutline),
        maxLines: _kMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
