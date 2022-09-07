import 'package:flutter/material.dart';
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
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/favourites/bloc/favourites_all_bloc.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_all_tile.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_empty_data_widget.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_network_error_widget.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_tour_list_view_model.dart';
import 'package:ota/modules/favourites/view_model/favourite_all_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:provider/provider.dart';

const String _kFavouriteAllTileKey = 'favourite_all_tile_key';
const String _kAllListKey = "all_list_key";

class FavoritesAllList extends StatefulWidget {
  final FavouritesOptionsController favouritesOptionsController;
  final FavouritesAllBloc allBloc;

  const FavoritesAllList(
      {Key? key,
      required this.favouritesOptionsController,
      required this.allBloc})
      : super(key: key);

  @override
  State<FavoritesAllList> createState() => _FavoritesAllListState();
}

class _FavoritesAllListState extends State<FavoritesAllList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavouriteUpdate>(context, listen: false)
          .updateFavourite(false);
    });
  }

  _requestAllFavoritesData() async {
    widget.favouritesOptionsController.setCollapsed();
    await widget.allBloc.getFavouritesAllData(
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
      key: const Key(_kAllListKey),
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        if (isNewDataRequired(index, widget.allBloc.state.favouritesList.length,
            widget.allBloc.isNewDataRequired)) {
          widget.allBloc.setNewDataRequired();
          widget.allBloc.getFavouritesAllData(
            type: widget.favouritesOptionsController.state.chosenOption,
            refreshData: false,
          );
        }
        FavouritesAllViewModel favouritesAll =
            widget.allBloc.state.favouritesList[index];
        return _buildFavouritesAllTile(favouritesAll);
      },
      itemCount: widget.allBloc.state.favouritesList.length,
    );
  }

  Widget _buildFavouritesAllTile(FavouritesAllViewModel favouritesAll) {
    return GestureDetector(
      child: Container(
        key: const Key(_kFavouriteAllTileKey),
        color: Colors.transparent,
        child: FavouriteAllTile(
          favouritesAll: favouritesAll,
          onTap: () => widget.allBloc.removeAllFavourite(
            favourites: favouritesAll,
            serviceName: widget.favouritesOptionsController.state.chosenOption,
          ),
        ),
      ),
      onTap: () {
        if (favouritesAll.serviceName.isNotEmpty) {
          switch (
              FavouriteHelper.getServiceTypeKey(favouritesAll.serviceName)) {
            case FavouriteService.tickets:
              navigateToTicketDetailScreen(favouritesAll);
              break;
            case FavouriteService.tour:
              navigateToTourDetailScreen(favouritesAll);
              break;
            case FavouriteService.hotel:
              navigateToHotelDetailScreen(favouritesAll);
              break;
            case FavouriteService.carRental:
              _navigateToDetailScreen(favouritesAll);
              break;
            default:
              navigateToServiceScreen();
          }
        }
      },
    );
  }

  void navigateToServiceScreen() {}

  Future<void> navigateToTourDetailScreen(
      FavouritesAllViewModel favouritesTour) async {
    TourDetailArgument tourDetailArgument = TourDetailArgument(
      tourId: favouritesTour.id,
      countryId: favouritesTour.countryId ?? '',
      cityId: favouritesTour.cityId ?? '',
      userType: TourDetailUserType.loggedInUser,
    );

    var result = await Navigator.pushNamed(
      context,
      AppRoutes.tourDetailScreen,
      arguments: tourDetailArgument,
    );
    if (result is bool && result) {
      widget.allBloc.getFavouritesAllData(
        type: widget.favouritesOptionsController.state.chosenOption,
        isForceFetch: false,
      );
    }
  }

  Future<void> navigateToTicketDetailScreen(
      FavouritesAllViewModel favouritesTicket) async {
    TicketDetailArgument ticketDetailArgument = TicketDetailArgument(
      ticketId: favouritesTicket.id,
      countryId: favouritesTicket.countryId ?? '',
      cityId: favouritesTicket.cityId ?? '',
      userType: TicketDetailUserType.loggedInUser,
    );
    var result = await Navigator.pushNamed(
      context,
      AppRoutes.ticketDetailScreen,
      arguments: ticketDetailArgument,
    );
    if (result is bool && result) {
      widget.allBloc.getFavouritesAllData(
        type: widget.favouritesOptionsController.state.chosenOption,
        isForceFetch: false,
      );
    }
  }

  Future<void> navigateToHotelDetailScreen(
      FavouritesAllViewModel favouritesHotel) async {
    final hotelArgument = HotelDetailArgument.getDefaulArgument(
      favouritesHotel.id,
      favouritesHotel.cityId,
      favouritesHotel.countryId,
    );
    await Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
    FavouriteUpdate favouriteHotelUpdate =
        Provider.of<FavouriteUpdate>(context, listen: false);
    if (favouriteHotelUpdate.isUpdated) {
      favouriteHotelUpdate.updateFavourite(false);
      widget.allBloc.getFavouritesAllData(
        type: widget.favouritesOptionsController.state.chosenOption,
        isForceFetch: false,
      );
    }
  }

  Future<void> _navigateToDetailScreen(
      FavouritesAllViewModel favouritesViewModel) async {
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
      widget.allBloc.getFavouritesAllData(
        type: widget.favouritesOptionsController.state.chosenOption,
        isForceFetch: true,
      );
    }
  }

  Widget _getCircularProgressIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _getScreenWidget() {
    switch (widget.allBloc.state.favouritesScreenState) {
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
      bloc: widget.allBloc,
      builder: () {
        return OtaRefreshIndicator(
          onRefresh: () => _requestAllFavoritesData(),
          text: _buildLoadingText(context),
          child: _getScreenWidget(),
        );
      },
    );
  }
}
