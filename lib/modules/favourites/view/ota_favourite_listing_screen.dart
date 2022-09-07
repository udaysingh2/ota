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
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/bloc/favourite_car_bloc.dart';
import 'package:ota/modules/favourites/bloc/favourite_hotel_bloc.dart';
import 'package:ota/modules/favourites/bloc/favourite_tour_bloc.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/favourites/bloc/favourites_all_bloc.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/favourites_all_list.dart';
import 'package:ota/modules/favourites/view/favourites_car_rental_list.dart';
import 'package:ota/modules/favourites/view/favourites_tour_list.dart';
import 'package:ota/modules/favourites/view/widgets/favourite_hotel_tile.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_list.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_page_error_widget.dart';
import 'package:ota/modules/favourites/view_model/favourite_hotel_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:provider/provider.dart';

const double _kOpacityConstant = 0.2;
const Duration _kAnimationDuration = Duration(milliseconds: 200);
const String _kFilterOptionsListKey = 'filter_options_list_key';
const String _kFavouriteHotelTileKey = 'favourite_hotel_tile_key';
const String _kOtaListKey = "ota_list_key";
const String _kExclamationIcon = "assets/images/icons/exclamation_circle1.svg";

class OtaFavouritesListingScreen extends StatefulWidget {
  const OtaFavouritesListingScreen({Key? key}) : super(key: key);

  @override
  OtaFavouritesListingScreenState createState() =>
      OtaFavouritesListingScreenState();
}

class OtaFavouritesListingScreenState
    extends State<OtaFavouritesListingScreen> {
  final FavouritesTourBloc _tourBloc = FavouritesTourBloc();
  final FavouritesHotelBloc _hotelBloc = FavouritesHotelBloc();
  final FavouritesAllBloc _allBloc = FavouritesAllBloc();
  final FavouritesCarBloc _carBloc = FavouritesCarBloc();
  final FavouritesOptionsController _favouritesOptionsController =
      FavouritesOptionsController();

  @override
  void dispose() {
    _hotelBloc.dispose();
    _tourBloc.dispose();
    _allBloc.dispose();
    _carBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!FavouriteHelper.isAllFavoritesEnabled()) {
        _requestFavouritesData();
      } else {
        _allBloc.getFavouritesAllData(
          type: _favouritesOptionsController.state.chosenOption,
          isForceFetch: true,
        );
      }
      _handleHotelProgressBar();
    });
    _carBloc.stream.listen((event) {
      if ((event.favouritesScreenState ==
                  OtaFavouritesPageState.internetFailure ||
              event.favouritesScreenState ==
                  OtaFavouritesPageState.internetFailureRefresh ||
              event.favouritesScreenState ==
                  OtaFavouritesPageState.emptyInternetFailureRefresh) &&
          !event.isInternetPopupShown) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _carBloc.setInternetPopupShown();
      }
      if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteInternetFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteLoading) {
        OtaDialogLoader().showLoader(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteSuccess) {
        OtaDialogLoader().hideLoader(context);
        if (_carBloc.state.favouritesList.isEmpty) {
          _carBloc.updateEmptyState();
        }
      }
    });
    _tourBloc.stream.listen((event) {
      if (event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailure ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailureRefresh ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.emptyInternetFailureRefresh) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteInternetFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteLoading) {
        OtaDialogLoader().showLoader(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteSuccess) {
        OtaDialogLoader().hideLoader(context);
        if (event.favouritesList.isEmpty) {
          _tourBloc.updateEmptyState();
        }
      }
    });
    _allBloc.stream.listen((event) {
      if (event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailure ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailureRefresh ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.emptyInternetFailureRefresh) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteInternetFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteLoading) {
        OtaDialogLoader().showLoader(context);
      } else if (event.favouritesScreenState ==
          OtaFavouritesPageState.unFavoriteSuccess) {
        OtaDialogLoader().hideLoader(context);
        if (event.favouritesList.isEmpty) {
          _allBloc.updateEmptyState();
        }
      }
    });
    _hotelBlocEventListener();
  }

  void _hotelBlocEventListener() {
    _hotelBloc.stream.listen((event) {
      if (event.unFavouritesState == OtaFavouritesPageState.internetFailure ||
          event.unFavouritesState ==
              OtaFavouritesPageState.internetFailureRefresh ||
          event.unFavouritesState ==
              OtaFavouritesPageState.emptyInternetFailureRefresh ||
          event.unFavouritesState ==
              OtaFavouritesPageState.unFavoriteInternetFailure ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailure ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.internetFailureRefresh ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.emptyInternetFailureRefresh ||
          event.favouritesScreenState ==
              OtaFavouritesPageState.unFavoriteInternetFailure) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (event.unFavouritesState == OtaFavouritesPageState.loading) {
        OtaDialogLoader().showLoader(context);
      } else if (event.unFavouritesState == OtaFavouritesPageState.success ||
          event.unFavouritesState == OtaFavouritesPageState.failure) {
        OtaDialogLoader().hideLoader(context);
      }
    });
  }

  _requestFavouritesData() async {
    _favouritesOptionsController.setCollapsed();
    await _hotelBloc.getFavouriteHotelsData(
        type: _favouritesOptionsController.state.chosenOption);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BlocBuilder(
            bloc: _favouritesOptionsController,
            builder: () {
              return Expanded(
                child: _buildScreen(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScreen() {
    if (FavouriteHelper.getServiceKey(
            _favouritesOptionsController.state.chosenOption) ==
        FavouriteService.hotel) {
      return _buildHotelScreen();
    } else {
      return _buildFavoritesScreen();
    }
  }

  Widget _buildFavoritesScreen() {
    return Stack(
      children: [
        _getServiceScreen(),
        _blurEffect(),
        _buildfavouritesOptions(),
      ],
    );
  }

  Widget _getServiceScreen() {
    switch (FavouriteHelper.getServiceKey(
        _favouritesOptionsController.state.chosenOption)) {
      case FavouriteService.carRental:
        return FavoritesCarRentalList(
          favouritesOptionsController: _favouritesOptionsController,
          carBloc: _carBloc,
        );
      case FavouriteService.toursAndTickets:
        return FavoritesTourList(
          favouritesOptionsController: _favouritesOptionsController,
          tourBloc: _tourBloc,
        );
      case FavouriteService.all:
        return FavoritesAllList(
            favouritesOptionsController: _favouritesOptionsController,
            allBloc: _allBloc);
      default:
        return _buildErrorWidget();
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
        },
      ),
    );
  }

  void _getChosenOptionData() {
    switch (FavouriteHelper.getServiceKey(
        _favouritesOptionsController.state.chosenOption)) {
      case (FavouriteService.hotel):
        _hotelBloc.state.favouritesList.clear();
        _hotelBloc.getFavouriteHotelsData(
          type: _favouritesOptionsController.state.chosenOption,
          refreshData: true,
        );
        break;
      case (FavouriteService.toursAndTickets):
        _tourBloc.state.favouritesList.clear();
        _tourBloc.getFavouritesTourData(
          type: _favouritesOptionsController.state.chosenOption,
          refreshData: true,
          isForceFetch: true,
        );
        break;
      case (FavouriteService.carRental):
        _carBloc.state.favouritesList.clear();
        _carBloc.getFavouriteData(
          type: _favouritesOptionsController.state.chosenOption,
          refreshData: true,
          isForceFetch: true,
        );
        break;
      case (FavouriteService.all):
        _allBloc.state.favouritesList.clear();
        _allBloc.getFavouritesAllData(
          type: _favouritesOptionsController.state.chosenOption,
          refreshData: true,
          isForceFetch: true,
        );
        break;
      default:
        debugPrint(_favouritesOptionsController.state.chosenOption);
    }
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
                    _carBloc.state.isInternetPopupShown = false;
                  },
                  child: FavouritesOptionList(
                    key: const Key(_kFilterOptionsListKey),
                    favouritesOptionsController: _favouritesOptionsController,
                    onTap: () {
                      _getChosenOptionData();
                      _carBloc.state.isInternetPopupShown = false;
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

  Widget _buildNoFavouritesWidget() {
    return OtaRefreshIndicator(
      onRefresh: () async {
        _requestFavouritesData();
      },
      text: _buildLoadingText(context),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: kSize140),
          child: Text(
            getTranslated(
              context,
              AppLocalizationsStrings.otaNoFavouritesAvialable,
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

  bool isNewDataRequired(int index, int listLength, bool isNewDataRequired) {
    bool isLastIndex = index == (listLength - 1);
    if (isNewDataRequired) {
      return isLastIndex;
    }
    return false;
  }

  _buildHotelScreen() {
    return BlocBuilder(
      bloc: _hotelBloc,
      builder: () {
        bool isLoading = _hotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.loading &&
            _hotelBloc.state.favouritesList.isEmpty;
        if (isLoading) return const Center(child: CircularProgressIndicator());

        bool isFailure = _hotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.failure ||
            _hotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.internetFailure ||
            _hotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.internetFailureRefresh ||
            _hotelBloc.state.favouritesScreenState ==
                OtaFavouritesPageState.emptyInternetFailureRefresh;
        bool isListEmpty = _hotelBloc.state.favouritesList.isEmpty;
        return Stack(
          children: [
            isListEmpty
                ? isFailure
                    ? _buildErrorWidget()
                    : _buildNoFavouritesWidget()
                : _buildFavouritesHotelWidget(),
            _blurEffect(),
            _buildfavouritesOptions(),
          ],
        );
      },
    );
  }

  _handleHotelProgressBar() {
    if (_hotelBloc.state.unFavouritesState == OtaFavouritesPageState.loading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaDialogLoader().showLoader(context);
      });
    } else if (_hotelBloc.state.unFavouritesState ==
        OtaFavouritesPageState.failure) {
      _hotelBloc.updateUnfavouritesHotelState();
      OtaDialogLoader().hideLoader(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OtaBanner().showMaterialBanner(
            context,
            getTranslated(context, AppLocalizationsStrings.unFavouriteError),
            AppColors.kBannerColor,
            _kExclamationIcon);
      });
    } else if (_hotelBloc.state.unFavouritesState ==
        OtaFavouritesPageState.success) {
      _hotelBloc.updateUnfavouritesHotelState();
      OtaDialogLoader().hideLoader(context);
    }
  }

  Widget _buildFavouritesHotelWidget() {
    return OtaRefreshIndicator(
      onRefresh: () => _requestFavouritesData(),
      text: _buildLoadingText(context),
      child: ListView.builder(
        key: const Key(_kOtaListKey),
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          if (isNewDataRequired(index, _hotelBloc.state.favouritesList.length,
              _hotelBloc.isNewDataRequired)) {
            _hotelBloc.setNewDataRequired();
            _hotelBloc.getFavouriteHotelsData(
              type: _favouritesOptionsController.state.chosenOption,
              refreshData: false,
            );
          }
          FavouritesHotelViewModel favouritesHotel =
              _hotelBloc.state.favouritesList[index];
          return _buildFavouritesHotelTile(
              favouritesHotel, _favouritesOptionsController.state.chosenOption);
        },
        itemCount: _hotelBloc.state.favouritesList.length,
      ),
    );
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
          onTap: () => _hotelBloc.removeFavouriteHotel(
            favouritesHotel,
            _favouritesOptionsController.state.chosenOption,
          ),
        ),
      ),
      onTap: () => navigateToHotelDetailScreen(favouritesHotel),
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
}
