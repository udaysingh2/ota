import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/tour_loading/bloc/tour_loading_bloc.dart';
import 'package:ota/modules/tours/tour_loading/view_model/tour_loading_view_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';

const String _defaultBackgroundImage =
    'assets/images/illustrations/default_bg_image.png';

class TourLoadingScreen extends StatefulWidget {
  const TourLoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  TourLoadingScreenState createState() => TourLoadingScreenState();
}

class TourLoadingScreenState extends State<TourLoadingScreen> {
  final TourLoadingBloc _loadingBloc = TourLoadingBloc();
  TourSearchResultArgumentModel? _argument;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadingBloc.getLoadingData();
    });
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(
            context, AppRoutes.tourSearchResultScreen,
            arguments: _argument));
  }

  @override
  Widget build(BuildContext context) {
    _argument = ModalRoute.of(context)?.settings.arguments
        as TourSearchResultArgumentModel;
    return Scaffold(
      body: BlocBuilder(
          bloc: _loadingBloc,
          builder: () {
            return Stack(children: [
              _loadingBloc.state.loadingViewModelState ==
                      TourLoadingViewModelState.loaded
                  ? _getBackgroundImage(context)
                  : _getDefaultPlaceholder(context),
              _getText(context),
            ]);
          }),
    );
  }

  Widget _getBackgroundImage(BuildContext context) {
    return CachedNetworkImage(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      imageUrl: _loadingBloc.state.imageUrl!,
      placeholder: (context, url) => _getDefaultPlaceholder(context),
      errorWidget: (context, url, error) => _getDefaultPlaceholder(context),
    );
  }

  Widget _getDefaultPlaceholder(BuildContext context) {
    return Image.asset(
      _defaultBackgroundImage,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  Widget _getText(BuildContext context) {
    return Container(
      padding: kPaddingHori24,
      child: Center(
        child: Text(
          getTranslated(context, AppLocalizationsStrings.tourLoadingScreenText),
          style: AppTheme.kHeading1Medium.copyWith(color: AppColors.kGrey4),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
