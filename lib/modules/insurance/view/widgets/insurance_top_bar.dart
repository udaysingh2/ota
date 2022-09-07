import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/insurance/bloc/insurance_status_bar_bloc.dart';

const double _kSize89 = 89;
const double _kOpacityMax = 1;
const double _kOpacityMin = 0;

class InsuranceTopBar extends StatelessWidget {
  final InsuranceStatusBarBloc statusBarBloc;
  final Function() onBackTap;

  const InsuranceTopBar(
      {Key? key, required this.statusBarBloc, required this.onBackTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: statusBarBloc,
        builder: () {
          return Container(
            height: _kSize89 - MediaQuery.of(context).padding.top,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: kSize24,
                  ),
                  child: OtaBackButton(
                    onPress: onBackTap,
                    isWhite: statusBarBloc.state.statusBarBlocState ==
                            InsuranceStatusBarBlocState.opened
                        ? true
                        : false,
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: statusBarBloc.state.statusBarBlocState ==
                          InsuranceStatusBarBlocState.opened
                      ? _kOpacityMin
                      : _kOpacityMax,
                  child: Padding(
                    padding: const EdgeInsets.only(left: kSize8),
                    child: Text(
                      getTranslated(
                          context, AppLocalizationsStrings.travelInsurance),
                      style: AppTheme.kHeading1Medium,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
        });
  }
}
