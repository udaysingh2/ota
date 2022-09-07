import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/bloc/favourite_hotel_bloc.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/favourites/view/widgets/favourite_hotel_tile.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_list.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_page_error_widget.dart';
import 'package:ota/modules/favourites/view_model/favourite_hotel_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:provider/provider.dart';

const double _kOpacityConstant = 0.2;
const Duration _kAnimationDuration = Duration(milliseconds: 200);
const String _kFilterOptionsListKey = 'filter_options_list_key';
const String _kFavouriteHotelTileKey = 'favourite_hotel_tile_key';
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class FavouritesHotelList extends StatefulWidget {
  const FavouritesHotelList({Key? key}) : super(key: key);

  @override
  FavouritesHotelListState createState() => FavouritesHotelListState();
}

class FavouritesHotelListState extends State<FavouritesHotelList> {
  final FavouritesHotelBloc _favouriteHotelBloc = FavouritesHotelBloc();
  final FavouritesOptionsController _favouritesOptionsController =
      FavouritesOptionsController();

  @override
  void dispose() {
    _favouriteHotelBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavouriteUpdate>(context, listen: false)
          .updateFavourite(false);
      _requestFavouritesData();
    });
  }

  _requestFavouritesData() async {
    _favouritesOptionsController.setCollapsed();
    await _favouriteHotelBloc.getFavouriteHotelsData(
      type: _favouritesOptionsController.state.chosenOption,
    );
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.kTrueWhite,
        body: Column(
          children: [
            OtaAppBar(
              title: getTranslated(
                context,
                AppLocalizationsStrings.favouritesTitle,
              ),
              isCenterTitle: false,
              trailingWidget: FavouritesOptions(
                favouritesOptionsController: _favouritesOptionsController,
              ),
              actions: const [
                OtaAppBarAction.customTrailingWidget,
                OtaAppBarAction.backButton,
              ],
            ),
            Expanded(
              child: _buildScreen(),
            ),
          ],
        ),
      ),
    );
  }

  _buildScreen() {
    return BlocBuilder(
      bloc: _favouriteHotelBloc,
      builder: () {
        bool isLoading = _favouriteHotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.loading &&
            _favouriteHotelBloc.state.favouritesList.isEmpty;
        if (isLoading) return const Center(child: CircularProgressIndicator());

        bool isFailure = _favouriteHotelBloc.state.favouritesScreenState ==
            OtaFavouritesPageState.failure;
        bool isListEmpty = _favouriteHotelBloc.state.favouritesList.isEmpty;
        _handelProgressBar();
        return Stack(
          children: [
            isListEmpty
                ? isFailure
                    ? _buildErrorWidget()
                    : _buildNoFavouritesHotelWidget()
                : _buildFavouritesHotelWidget(),
            _blurEffect(),
            _buildfavouritesOptions(),
          ],
        );
      },
    );
  }

  _handelProgressBar() {
    if (_favouriteHotelBloc.state.unFavouritesState ==
        OtaFavouritesPageState.loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaDialogLoader().showLoader(context);
      });
    } else if (_favouriteHotelBloc.state.unFavouritesState ==
        OtaFavouritesPageState.failure) {
      _favouriteHotelBloc.updateUnfavouritesHotelState();
      OtaDialogLoader().hideLoader(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(context, AppLocalizationsStrings.unFavouriteError),
          AppColors.kBannerColor,
          _kExclamationIcon,
        );
      });
    } else if (_favouriteHotelBloc.state.unFavouritesState ==
        OtaFavouritesPageState.success) {
      _favouriteHotelBloc.updateUnfavouritesHotelState();
      OtaDialogLoader().hideLoader(context);
    }
  }

  Widget _blurEffect() {
    return ClipRRect(
      child: BlocBuilder(
          bloc: _favouritesOptionsController,
          builder: () {
            return AnimatedSwitcher(
              duration: _kAnimationDuration,
              child: _favouritesOptionsController.isExpanded()
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: kSize10,
                        sigmaY: kSize10,
                      ),
                      child: Container(
                        color:
                            AppColors.kTrueWhite.withOpacity(_kOpacityConstant),
                      ),
                    )
                  : const SizedBox(),
            );
          }),
    );
  }

  Widget _buildfavouritesOptions() {
    return BlocBuilder(
      bloc: _favouritesOptionsController,
      builder: () {
        return AnimatedSwitcher(
          duration: _kAnimationDuration,
          child: _favouritesOptionsController.isExpanded()
              ? GestureDetector(
                  onTap: () {
                    _favouritesOptionsController.setCollapsed();
                  },
                  child: FavouritesOptionList(
                    key: const Key(_kFilterOptionsListKey),
                    favouritesOptionsController: _favouritesOptionsController,
                    onTap: () {
                      _favouriteHotelBloc.state.favouritesList.clear();
                      _favouriteHotelBloc.getFavouriteHotelsData(
                        type: _favouritesOptionsController.state.chosenOption,
                        refreshData: true,
                      );
                    },
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  Widget _buildNoFavouritesHotelWidget() {
    return OtaRefreshIndicator(
      onRefresh: () => _requestFavouritesData(),
      text: _buildLoadingText(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: kSize140),
          child: Text(
            getTranslated(
              context,
              AppLocalizationsStrings.noFavouritesAvialable,
            ),
            style: AppTheme.kBody.copyWith(
              fontSize: kSize14,
              color: AppColors.kGrey77,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return FavouritesPageErrorWidgetWithRefresh(
      height: MediaQuery.of(context).size.height - kSize200,
      onRefresh: () => _requestFavouritesData(),
    );
  }

  Widget _buildFavouritesHotelWidget() {
    return OtaRefreshIndicator(
      onRefresh: () => _requestFavouritesData(),
      text: _buildLoadingText(context),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          if (isNewDataRequired(index)) {
            _favouriteHotelBloc.setNewDataRequired();
            _favouriteHotelBloc.getFavouriteHotelsData(
              type: _favouritesOptionsController.state.chosenOption,
              refreshData: false,
            );
          }
          FavouritesHotelViewModel favouritesHotel =
              _favouriteHotelBloc.state.favouritesList[index];
          return _buildFavouritesHotelTile(
              favouritesHotel, _favouritesOptionsController.state.chosenOption);
        },
        itemCount: _favouriteHotelBloc.state.favouritesList.length,
      ),
    );
  }

  void navigateToHotelDetailScreen(
      FavouritesHotelViewModel favouritesViewModel) async {
    final hotelArgument = HotelDetailArgument.getDefaulArgument(
      favouritesViewModel.hotelId,
      favouritesViewModel.cityId,
      favouritesViewModel.countryId,
    );
    await Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
    FavouriteUpdate favouriteHotelUpdate =
        Provider.of<FavouriteUpdate>(context, listen: false);
    if (favouriteHotelUpdate.isUpdated) {
      favouriteHotelUpdate.updateFavourite(false);
      _requestFavouritesData();
    }
  }

  bool isNewDataRequired(int index) {
    bool isLastIndex =
        index == (_favouriteHotelBloc.state.favouritesList.length - 1);
    if (_favouriteHotelBloc.isNewDataRequired) {
      return isLastIndex;
    }
    return false;
  }

  Widget _buildFavouritesHotelTile(
      FavouritesHotelViewModel favouritesHotel, String serviceTypeName) {
    return GestureDetector(
      child: Container(
        key: const Key(_kFavouriteHotelTileKey),
        color: Colors.transparent,
        child: FavouriteHotelTile(
          serviceNameType: serviceTypeName,
          favouritesHotel: favouritesHotel,
          onTap: () => _favouriteHotelBloc.removeFavouriteHotel(
            favouritesHotel,
            _favouritesOptionsController.state.chosenOption,
          ),
        ),
      ),
      onTap: () => navigateToHotelDetailScreen(favouritesHotel),
    );
  }
}
