import 'package:flutter/material.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/bloc/favourite_tour_bloc.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourite_tour_tile.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_empty_data_widget.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_network_error_widget.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_view_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

const String _kFavouriteTourTileKey = 'favourite_tour_tile_key';
const String _kTourListKey = "tour_list_key";

class FavoritesTourList extends StatefulWidget {
  final FavouritesOptionsController favouritesOptionsController;
  final FavouritesTourBloc tourBloc;

  const FavoritesTourList(
      {Key? key,
      required this.favouritesOptionsController,
      required this.tourBloc})
      : super(key: key);

  @override
  State<FavoritesTourList> createState() => _FavoritesTourListState();
}

class _FavoritesTourListState extends State<FavoritesTourList> {
  _requestToursFavoritesData() async {
    widget.favouritesOptionsController.setCollapsed();
    await widget.tourBloc.getFavouritesTourData(
        type: widget.favouritesOptionsController.state.chosenOption);
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  bool isNewDataRequired(int index, int listLength, bool isNewDataRequired) {
    bool isLastIndex = index == (listLength - 1);
    if (isNewDataRequired) {
      return isLastIndex;
    }
    return false;
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
      key: const Key(_kTourListKey),
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        if (isNewDataRequired(
            index,
            widget.tourBloc.state.favouritesList.length,
            widget.tourBloc.isNewDataRequired)) {
          widget.tourBloc.setNewDataRequired();
          widget.tourBloc.getFavouritesTourData(
            type: widget.favouritesOptionsController.state.chosenOption,
            refreshData: false,
          );
        }
        FavouritesTourViewModel favouritesTour =
            widget.tourBloc.state.favouritesList[index];
        return _buildFavouritesToursTile(favouritesTour);
      },
      itemCount: widget.tourBloc.state.favouritesList.length,
    );
  }

  Widget _buildFavouritesToursTile(FavouritesTourViewModel favouritesTour) {
    printDebug('***************');
    printDebug(favouritesTour);
    printDebug('***************');

    return GestureDetector(
      child: Container(
        key: const Key(_kFavouriteTourTileKey),
        color: Colors.transparent,
        child: FavouriteTourTile(
          favouritesTour: favouritesTour,
          onTap: () => widget.tourBloc.removeTourFavourite(
            favourites: favouritesTour,
            serviceName: widget.favouritesOptionsController.state.chosenOption,
          ),
        ),
      ),
      onTap: () {
        if (favouritesTour.serviceName != null) {
          if (FavouriteHelper.getServiceTypeKey(favouritesTour.serviceName!) ==
              FavouriteService.tickets) {
            navigateToTicketDetailScreen(favouritesTour);
          } else {
            navigateToTourDetailScreen(favouritesTour);
          }
        }
      },
    );
  }

  void navigateToTourDetailScreen(
      FavouritesTourViewModel favouritesTour) async {
    TourDetailArgument tourDetailArgument = TourDetailArgument(
      tourId: favouritesTour.tourId,
      countryId: favouritesTour.countryId,
      cityId: favouritesTour.cityId,
      userType: TourDetailUserType.loggedInUser,
    );
    var result = await Navigator.pushNamed(
      context,
      AppRoutes.tourDetailScreen,
      arguments: tourDetailArgument,
    );
    if (result is bool && result) {
      widget.tourBloc.getFavouritesTourData(
          type: widget.favouritesOptionsController.state.chosenOption,
          isForceFetch: true);
    }
  }

  void navigateToTicketDetailScreen(
      FavouritesTourViewModel favouritesTour) async {
    TicketDetailArgument ticketDetailArgument = TicketDetailArgument(
      ticketId: favouritesTour.tourId,
      countryId: favouritesTour.countryId,
      cityId: favouritesTour.cityId,
      userType: TicketDetailUserType.loggedInUser,
    );
    var result = await Navigator.pushNamed(
      context,
      AppRoutes.ticketDetailScreen,
      arguments: ticketDetailArgument,
    );
    if (result is bool && result) {
      widget.tourBloc.getFavouritesTourData(
          type: widget.favouritesOptionsController.state.chosenOption,
          isForceFetch: true);
    }
  }

  Widget _getCircularProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _getScreenWidget() {
    switch (widget.tourBloc.state.favouritesScreenState) {
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
      bloc: widget.tourBloc,
      builder: () {
        return OtaRefreshIndicator(
          onRefresh: () => _requestToursFavoritesData(),
          text: _buildLoadingText(context),
          child: _getScreenWidget(),
        );
      },
    );
  }
}
