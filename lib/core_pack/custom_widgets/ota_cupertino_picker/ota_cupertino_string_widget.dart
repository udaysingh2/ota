import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import 'ota_cupertino_controller.dart';

const double _kHeaderHeight = 68.0;
const double _kContainerHeight = 126;
const double _kListCacheExtent = 10000;

class OtaCupertinoStringWidget extends StatelessWidget {
  final String title;
  final List<String> list;
  final String selectedBedTypeKey;
  final ValueChanged<String>? onAgreeClicked;
  final OtaCupertinoController _bloc = OtaCupertinoController();

  OtaCupertinoStringWidget({
    Key? key,
    required this.title,
    required this.list,
    required this.selectedBedTypeKey,
    this.onAgreeClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialIndex = list.indexOf(selectedBedTypeKey);
    _bloc.setSelectedIndex(initialIndex);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeaderView(context),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildCupertinoPicker(),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey4),
          _buildBottomBar(context)
        ],
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      height: _kHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            title,
            style: AppTheme.kHeading1Medium,
          ),
          IconButton(
            key: const Key('childAgePopUp'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: kSize20,
            splashRadius: kSize14,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.kGrey50,
              size: kSize20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _submitAge(BuildContext context) {
    if (onAgreeClicked != null) {
      onAgreeClicked!(
          list.isNotEmpty ? list[_bloc.getSelectedIndex()].trim() : '');
    }
    Navigator.pop(context);
  }

  Widget _buildBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      containerHeight: kSize88,
      showHorizontalDivider: false,
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.agree),
        isSelected: true,
        onPressed: () {
          _submitAge(context);
        },
      ),
    );
  }

  Widget _buildCupertinoPicker() {
    return BlocBuilder(
        bloc: _bloc,
        builder: () {
          return SizedBox(
            height: _kContainerHeight,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  top: kSize0, bottom: kSize0, left: kSize24, right: kSize24),
              controller: ScrollController(
                  keepScrollOffset: false,
                  initialScrollOffset: _bloc.state.index * kSize56),
              cacheExtent: _kListCacheExtent,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: kSize56,
                    child: OtaTextButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      title: getTranslated(context, list[index].trim()),
                      backgroundColor: Colors.transparent,
                      child: Text(getTranslated(context, list[index].trim()),
                          style: _bloc.getSelectedIndex() == index
                              ? AppTheme.kBodyMedium
                                  .copyWith(color: AppColors.kSecondary)
                              : AppTheme.kBodyRegular
                                  .copyWith(color: AppColors.kGrey20)),
                    ),
                  ),
                  onTap: () {
                    _bloc.setSelectedIndex(index);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const OtaHorizontalDivider(
                  height: kSize12,
                  dividerColor: AppColors.kGrey10,
                );
              },
            ),
          );
        });
  }
}
