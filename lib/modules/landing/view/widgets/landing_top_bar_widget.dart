import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_back_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';

const double _kSize89 = 89;

class LandingTopBar extends StatelessWidget {
  final StatusBarBloc? statusBarBloc;
  final Function()? onBackTap;
  final Function()? onSearchTap;
  const LandingTopBar(
      {Key? key, this.statusBarBloc, this.onSearchTap, this.onBackTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: statusBarBloc ?? StatusBarBloc(),
        builder: () {
          return Container(
            height: _kSize89 - MediaQuery.of(context).padding.top,
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kSize24),
                  child: OtaBackButton(
                    onPress: onBackTap,
                    isWhite: statusBarBloc?.state.statusBarBlocState ==
                            StatusBarBlocState.opened
                        ? true
                        : false,
                  ),
                ),
                const Spacer(),
                if (statusBarBloc?.state.statusBarBlocState ==
                    StatusBarBlocState.closing)
                  Padding(
                    padding: const EdgeInsets.only(right: kSize16),
                    child: OtaIconButton(
                      icon: Center(
                        child: SvgPicture.asset(
                          "assets/images/icons/feather_search.svg",
                          height: kSize24,
                          width: kSize24,
                          color: AppColors.kGrey70,
                        ),
                      ),
                      onTap: onSearchTap,
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
