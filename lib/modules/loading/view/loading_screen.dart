import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/loading/bloc/loading_bloc.dart';
import 'package:ota/modules/loading/view_model/loading_view_model.dart';

const String _defaultBackgroundImageHotel =
    'assets/images/illustrations/default_bg_image.png';
const String _defaultBackgroundImageCar =
    'assets/images/icons/car_landing_default.svg';
const _kCarRental = "CARRENTAL";

class LoadingScreen extends StatefulWidget {
  final String serviceName;
  const LoadingScreen(this.serviceName, {Key? key}) : super(key: key);

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  final LoadingBloc _loadingBloc = LoadingBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadingBloc.getLoadingData(widget.serviceName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
          bloc: _loadingBloc,
          builder: () {
            return Stack(children: [
              _loadingBloc.state.loadingViewModelState ==
                      LoadingViewModelState.loaded
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
    if (widget.serviceName == _kCarRental) {
      return SvgPicture.asset(_defaultBackgroundImageCar,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover);
    } else {
      return Image.asset(
        _defaultBackgroundImageHotel,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _getText(BuildContext context) {
    if (widget.serviceName == _kCarRental) {
      return _setText(AppLocalizationsStrings.searchForCar);
    } else {
      return _setText(AppLocalizationsStrings.searchingForRooms);
    }
  }

  _setText(String translationText) {
    return Container(
      padding: kPaddingHori24,
      child: Center(
        child: Text(
          getTranslated(context, translationText).replaceAll('\\n', '\n'),
          style: AppTheme.kHeading1Medium.copyWith(color: AppColors.kGrey4),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
