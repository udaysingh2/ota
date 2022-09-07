import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'tour_search_suggestions_tile_widget.dart';

const int _kMaxLengthForAll = 5;
const int _kDefaultInt = 1;
const int _kDefaultKey = 0;

class TourLiveListViewWidget extends StatefulWidget {
  final List suggestionList;
  final ServiceType type;
  final Function(int index) getTileWidget;

  const TourLiveListViewWidget(
      {Key? key,
      required this.suggestionList,
      required this.type,
      required this.getTileWidget})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourLiveListViewWidgetState();
}

class _TourLiveListViewWidgetState extends State<TourLiveListViewWidget>
    with AutomaticKeepAliveClientMixin<TourLiveListViewWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.separated(
      key: const PageStorageKey<int>(_kDefaultKey),
      padding: const EdgeInsets.only(top: kSize8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.suggestionList.length <= _kMaxLengthForAll
          ? widget.suggestionList.length + _kDefaultInt
          : _kMaxLengthForAll + _kDefaultInt,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: Text(
              widget.type == ServiceType.location
                  ? getTranslated(context, AppLocalizationsStrings.destinations)
                  : widget.type == ServiceType.ticket
                      ? getTranslated(context, AppLocalizationsStrings.tickets)
                      : getTranslated(context, AppLocalizationsStrings.tours),
              style: AppTheme.kBodyMedium,
            ),
          );
        }
        return widget.getTileWidget(index);
      },
      separatorBuilder: (_, __) {
        return const SizedBox(height: kSize8);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
