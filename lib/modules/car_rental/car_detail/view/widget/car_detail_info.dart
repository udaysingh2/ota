import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_status_bar_bloc.dart';

const double _kOpacityMax = 1;
const double _kOpacityMin = 0;
const _kAnimationDuration = 200;
const int _kMaxLines = 1;

class CarDetailInfo extends StatelessWidget {
  final CarDetailStatusBarBloc statusBarBloc;
  final String? typeText;
  final String? headerText;
  final String? logo;

  const CarDetailInfo({
    Key? key,
    required this.statusBarBloc,
    this.typeText,
    this.headerText,
    this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kSize24,
      ),
      child: BlocBuilder(
        bloc: statusBarBloc,
        builder: () {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: _kAnimationDuration),
            opacity: statusBarBloc.state.statusBarBlocState ==
                    CarDetailStatusBarState.opened
                ? _kOpacityMax
                : _kOpacityMin,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headerText ?? '',
                        style: AppTheme.kHeading1Medium,
                        maxLines: _kMaxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        (typeText ?? '').addTrailingSpace() +
                            getTranslated(
                                context, AppLocalizationsStrings.orSimilar),
                        style: AppTheme.kSmallRegular
                            .copyWith(color: AppColors.kGrey50),
                        maxLines: _kMaxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: kSize8),
                _getLogoImage(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getLogoImage() {
    String logoUrl = logo ?? '';
    return logoUrl.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.kBorderGrey,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  logoUrl,
                ),
                fit: BoxFit.contain,
              ),
            ),
            height: kSize40,
            width: kSize40,
          );
  }
}
