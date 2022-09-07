import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/favourites/bloc/favourite_car_bloc.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/favourites/view/widgets/favourite_car_tile.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_network_error_widget.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';
import 'package:ota/modules/favourites/view_model/favourite_car_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:provider/provider.dart';
import 'widgets/favourites_empty_data_widget.dart';

const String _kFavouriteCarTileKey = 'favourite_car_tile_key';
const String _kCarListKey = "car_list_key";

class FavoritesCarRentalList extends StatefulWidget {
  final FavouritesOptionsController favouritesOptionsController;
  final FavouritesCarBloc carBloc;

  const FavoritesCarRentalList({
    Key? key,
    required this.favouritesOptionsController,
    required this.carBloc,
  }) : super(key: key);

  @override
  State<FavoritesCarRentalList> createState() => _FavoritesCarRentalListState();
}

class _FavoritesCarRentalListState extends State<FavoritesCarRentalList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavouriteUpdate>(context, listen: false)
          .updateFavourite(false);
    });
  }

  _requestFavouritesData() async {
    widget.favouritesOptionsController.setCollapsed();
    widget.carBloc.state.isInternetPopupShown = false;
    await widget.carBloc.getFavouriteData(
      type: widget.favouritesOptionsController.state.chosenOption,
    );
  }

  bool isNewDataRequired(int index) {
    bool isLastIndex =
        index == (widget.carBloc.state.favouritesList.length - 1);
    if (widget.carBloc.isNewDataRequired) {
      return isLastIndex;
    }
    return false;
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallerRegular.copyWith(
        color: AppColors.kGrey50,
      ),
    );
  }

  Widget _buildFavouritesTile(int index) {
    FavouritesCarViewModel favouritesModel =
        widget.carBloc.state.favouritesList[index];

    return GestureDetector(
      child: Container(
        key: const Key(_kFavouriteCarTileKey),
        color: Colors.transparent,
        child: FavouriteCarTile(
          favourites: favouritesModel,
          onTap: () => _unFavourite(index),
        ),
      ),
      onTap: () => _navigateToDetailScreen(favouritesModel),
    );
  }

  _unFavourite(int index) {
    widget.carBloc.removeFavourite(index);
  }

  Widget _getCircularProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildNetworkErrorWidget() {
    return FavoritesNetworkErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
    );
  }

  Widget _buildNoFavouritesWidget() {
    return const FavoritesEmptyDataWidget();
  }

  Widget _buildListingScreen() {
    return ListView.builder(
      key: const Key(_kCarListKey),
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        if (isNewDataRequired(index)) {
          widget.carBloc.setNewDataRequired();
          widget.carBloc.getFavouriteData(
            type: widget.favouritesOptionsController.state.chosenOption,
            refreshData: false,
          );
        }
        return _buildFavouritesTile(index);
      },
      itemCount: widget.carBloc.state.favouritesList.length,
    );
  }

  Widget _getScreenWidget() {
    switch (widget.carBloc.state.favouritesScreenState) {
      case OtaFavouritesPageState.loading:
        return _getCircularProgressIndicator();
      case OtaFavouritesPageState.emptyData:
      case OtaFavouritesPageState.emptyInternetFailureRefresh:
      case OtaFavouritesPageState.emptyDataPullDownLoading:
        return _buildNoFavouritesWidget();
      case OtaFavouritesPageState.failure:
      case OtaFavouritesPageState.internetFailure:
        return _buildNetworkErrorWidget();
      case OtaFavouritesPageState.errorCasePullDownLoading:
        return _buildNetworkErrorWidget();
      default:
        return _buildListingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.carBloc,
      builder: () {
        return OtaRefreshIndicator(
          onRefresh: () => _requestFavouritesData(),
          text: _buildLoadingText(context),
          child: _getScreenWidget(),
        );
      },
    );
  }

  Future<void> _navigateToDetailScreen(
      FavouritesCarViewModel favouritesViewModel) async {
    await Navigator.of(context).pushNamed(
      AppRoutes.carDetailScreen,
      arguments: CarDetailArgumentModel(
        carId: favouritesViewModel.id,
        pickupLocationId: favouritesViewModel.pickupLocationId ?? "",
        returnLocationId: favouritesViewModel.dropLocationId ?? "",
        pickupDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.pickUpDeltaCar,
            hours: 10,
          ),
        ),
        returnDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
          Duration(
            days: AppConfig().configModel.dropOffDeltaCar,
            hours: 10,
          ),
        ),
        supplierId: favouritesViewModel.supplierId ?? "",
        includeDriver: AppConfig().configModel.includeDriver,
        residenceCountry: favouritesViewModel.location,
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: AppConfig().configModel.carDriverDefaultAge,
        pickupCounter: AppConfig().configModel.pickupCounter,
        returnCounter: AppConfig().configModel.returnCounter,
        userType: getLoginProvider().userType == UserType.loggedInUser
            ? CarRentalDetailUserType.loggedInUser
            : CarRentalDetailUserType.guestUser,
        cityName: favouritesViewModel.location,
      ),
    );
    FavouriteUpdate favouriteUpdate =
        Provider.of<FavouriteUpdate>(context, listen: false);
    if (favouriteUpdate.isUpdated) {
      favouriteUpdate.updateFavourite(false);
      widget.carBloc.getFavouriteData(
        type: widget.favouritesOptionsController.state.chosenOption,
        isForceFetch: true,
      );
    }
  }
}
