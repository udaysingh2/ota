import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_playlist_viewall_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/playlist/bloc/ota_vertical_playlist_bloc.dart';
import 'package:ota/modules/playlist/view/widgets/car_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/category_list/horizontal_category_list.dart';
import 'package:ota/modules/playlist/view/widgets/hotel_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/tour_ticket_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_model.dart';
import 'package:ota/modules/playlist/view_model/static_playlist_type.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/vertical_static_playlist_card_view_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

const String _kImageUrl = "assets/images/icons/no_matching_result_image.svg";
const _kPageSize = 20;
const String _kAll = "ALL";
const String _kPlaylistSection = "OTA_landing";
const String _kTravelId = 'mix';
const String _kTravelName = 'mix';

class OtaVerticalPlaylistScreen extends StatefulWidget {
  const OtaVerticalPlaylistScreen({Key? key}) : super(key: key);

  @override
  OtaVerticalPlaylistScreenState createState() =>
      OtaVerticalPlaylistScreenState();
}

class OtaVerticalPlaylistScreenState extends State<OtaVerticalPlaylistScreen> {
  final OtaVerticalPlaylistBloc _otaVerticalPlaylistBloc =
      OtaVerticalPlaylistBloc();
  ScrollController? _scrollController;
  OtaVerticalPlaylistViewArgument? viewArgument;
  int currentAllPageNumber = 1;
  int offset = 0;
  int lastSelectedIndex = 0;
  bool isLazyLoading = false;
  Future<void> requestPlaylistData({bool isPullToRefresh = false}) async {
    viewArgument = ModalRoute.of(context)?.settings.arguments
        as OtaVerticalPlaylistViewArgument;
    _otaVerticalPlaylistBloc
        .setSelectedCategory(getCategoryType().values.first);
    return _otaVerticalPlaylistBloc.fetchPlaylistData(
        argument: viewArgument, isForceFetch: true);
  }

  void _getPlaylistData({
    required String productType,
    required int offset,
    required bool isForceFetch,
  }) {
    viewArgument?.productType = productType;
    viewArgument?.offset = offset;
    _otaVerticalPlaylistBloc.fetchPlaylistData(
        argument: viewArgument, isForceFetch: isForceFetch);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestPlaylistData();
    });

    _otaVerticalPlaylistBloc.stream.listen((event) {
      if (event.playListViewModelState ==
          OtaVerticalPlayListDataViewModelState.internetFailure) {
        if (currentAllPageNumber >= 2) {
          currentAllPageNumber--;
        }
        if (!event.isInternetFailurePopupShown) {
          _otaVerticalPlaylistBloc.setInternetPopupShown();
          OtaNoInternetAlertDialog().showAlertDialog(context, onOkClick: () {
            _otaVerticalPlaylistBloc.state.isInternetFailurePopupShown = false;
            Navigator.of(context).pop();
          });
        }
      }
    });
  }

  bool isNewDataRequired(int index) {
    int maxSize = currentAllPageNumber * _kPageSize;
    if (maxSize == (index + 1)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    viewArgument = ModalRoute.of(context)?.settings.arguments
        as OtaVerticalPlaylistViewArgument;
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
          bloc: _otaVerticalPlaylistBloc,
          builder: () {
            return Column(
              children: [
                _getCategories(context),
                _buildWidget(),
              ],
            );
          }),
    );
  }

  OtaAppBar _buildAppBar() {
    return OtaAppBar(
      title: viewArgument?.playlistName ?? "",
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.customTrailingWidget
      ],
    );
  }

  Map<String, String> getCategoryType() {
    Map<String, String> mapOfCategory = {
      _kAll: getTranslated(context, AppLocalizationsStrings.all),
      OtaServiceType.hotel: getTranslated(
          context, AppLocalizationsStrings.allServicesAccommodation),
      if (OtaServiceEnabledHelper.isTourEnabled())
        OtaServiceType.tour:
            getTranslated(context, AppLocalizationsStrings.allServicesTour),
      if (OtaServiceEnabledHelper.isTourEnabled())
        OtaServiceType.ticket:
            getTranslated(context, AppLocalizationsStrings.allServicesTicket),
      if (OtaServiceEnabledHelper.isCarEnabled())
        OtaServiceType.carRental:
            getTranslated(context, AppLocalizationsStrings.allServicesCar)
    };
    return mapOfCategory;
  }

  Widget _getCategories(BuildContext context) {
    Map<String, String> categoryMap = getCategoryType();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSize4),
      child: HorizontalCategoryList(
          categories: categoryMap.values.toList(),
          selectedCatIndex: lastSelectedIndex,
          onCategorySelectedIndex: (index) {
            _otaVerticalPlaylistBloc.state.isInternetFailurePopupShown = false;
            if (lastSelectedIndex != index) {
              final categoryName = categoryMap.values.elementAt(index);
              _otaVerticalPlaylistBloc.setSelectedCategory(categoryName);
              lastSelectedIndex = index;
              currentAllPageNumber = 1;
              if (!_otaVerticalPlaylistBloc
                  .isPlaylistDataAvailable(categoryName)) {
                _getPlaylistData(
                    productType:
                        index == 0 ? "" : categoryMap.keys.elementAt(index),
                    offset: 0,
                    isForceFetch: true);
              } else {
                _otaVerticalPlaylistBloc.emitSuccess();
              }
            }
          }),
    );
  }

  Widget _buildWidget() {
    return BlocBuilder(
      bloc: _otaVerticalPlaylistBloc,
      builder: () {
        bool isSuccess =
            _otaVerticalPlaylistBloc.state.playListViewModelState ==
                    OtaVerticalPlayListDataViewModelState.success &&
                _otaVerticalPlaylistBloc.anySuggestions;
        bool isLoading =
            _otaVerticalPlaylistBloc.state.playListViewModelState ==
                OtaVerticalPlayListDataViewModelState.loading;
        bool isFailure =
            _otaVerticalPlaylistBloc.state.playListViewModelState ==
                OtaVerticalPlayListDataViewModelState.failure;
        bool isInternetFailure =
            _otaVerticalPlaylistBloc.state.playListViewModelState ==
                OtaVerticalPlayListDataViewModelState.internetFailure;

        if (isLoading) {
          return _buildLoadingWidget();
        }

        if (isSuccess) {
          return _buildListView(context);
        }
        if (isFailure || isInternetFailure) {
          if (_checkIfDataAvailable()) {
            return _buildListView(context);
          } else {
            return Expanded(
                child: _buildErrorWidget(context, isInternetFailure));
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _checkIfDataAvailable() {
    final playList = _otaVerticalPlaylistBloc.state
            .playlistMap[_otaVerticalPlaylistBloc.getCategory]?.playList ??
        [];
    return playList.isNotEmpty && playList.first.verticalCardList.isNotEmpty;
  }

  Widget _buildLoadingWidget() {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  List<VerticalStaticPlayListCardViewModel> _verifyPlayList(
      List<VerticalStaticPlayListCardViewModel> playlist) {
    List<VerticalStaticPlayListCardViewModel> updatedPlaylist = [];
    if (playlist.isEmpty) {
      return updatedPlaylist;
    }
    for (VerticalStaticPlayListCardViewModel model in playlist) {
      if (model.productType == OtaServiceType.hotel && model.hotel != null) {
        updatedPlaylist.add(model);
      } else if (model.productType == OtaServiceType.tour &&
          model.tour != null &&
          OtaServiceEnabledHelper.isTourEnabled()) {
        updatedPlaylist.add(model);
      } else if (model.productType == OtaServiceType.ticket &&
          model.ticket != null &&
          OtaServiceEnabledHelper.isTourEnabled()) {
        updatedPlaylist.add(model);
      } else if (model.productType == OtaServiceType.carRental &&
          model.car != null &&
          OtaServiceEnabledHelper.isCarEnabled()) {
        updatedPlaylist.add(model);
      }
    }
    return updatedPlaylist;
  }

  Widget _buildListView(BuildContext context) {
    final suggestionList = _otaVerticalPlaylistBloc
            .state
            .playlistMap[_otaVerticalPlaylistBloc.getCategory]
            ?.playList
            .first
            .verticalCardList ??
        [];

    List<VerticalStaticPlayListCardViewModel> playList =
        _verifyPlayList(suggestionList);
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        itemCount: playList.length,
        padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize24),
        itemBuilder: (context, index) {
          if (isNewDataRequired(index) &&
              !_otaVerticalPlaylistBloc.isLoading &&
              !_otaVerticalPlaylistBloc.isInternetFailurePopupShown) {
            Map<String, String> categoryMap = getCategoryType();
            offset = playList.length;
            currentAllPageNumber++;
            isLazyLoading = true;
            _getPlaylistData(
                productType: lastSelectedIndex == 0
                    ? ""
                    : categoryMap.keys.elementAt(lastSelectedIndex),
                offset: offset,
                isForceFetch: false);
          }
          return _buildOtaSuggestionCard(playList[index], playList);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: kSize24);
        },
      ),
    );
  }

  Widget _buildOtaSuggestionCard(VerticalStaticPlayListCardViewModel list,
      List<VerticalStaticPlayListCardViewModel> playlist) {
    switch (list.productType) {
      case OtaServiceType.hotel:
        HotelVerticalCardViewModel hotelModel = list.hotel!;
        return HotelStaticPlaylistCard(
          model: hotelModel,
          isInHorizontalScroll: false,
          onPress: () {
            _getPlaylistVieWall(list, playlist, list.productType);
            _navigateHotelDetail(hotelModel, context);
          },
        );
      case OtaServiceType.tour:
        TourVerticalCardViewModel tourModel = list.tour!;
        return TourTicketStaticPlaylistCard(
          model: tourModel,
          playlistType: StaticPlaylistType.tour,
          isInHorizontalScroll: false,
          onPress: () {
            _getPlaylistVieWall(list, playlist, list.productType);
            _openTourDetailScreen(tourModel, context);
          },
        );
      case OtaServiceType.ticket:
        TourVerticalCardViewModel ticketModel = list.ticket!;
        return TourTicketStaticPlaylistCard(
          model: ticketModel,
          playlistType: StaticPlaylistType.ticket,
          isInHorizontalScroll: false,
          onPress: () {
            _getPlaylistVieWall(list, playlist, list.productType);
            _openTicketDetailScreen(ticketModel, context);
          },
        );
      case OtaServiceType.carRental:
        CarVerticalCardViewModel cardViewModel = list.car!;
        return CarStaticPlaylistCard(
          model: cardViewModel,
          isInHorizontalScroll: false,
          onPress: () {
            _getPlaylistVieWall(list, playlist, list.productType);
            _navigateToCarSupplierScreen(cardViewModel, context);
          },
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildErrorWidget(BuildContext context, bool isInternetFailure) {
    if (!isInternetFailure) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(kSize16, kSize0, kSize16, kSize24),
        child: OtaSearchNoResultWidget(
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
          errorTextFooter: getTranslated(
              context, AppLocalizationsStrings.informationNotAvialable),
          dividerHeight: kSize16,
          paddingHeight: kSize16,
          imageUrl: _kImageUrl,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: OtaNetworkErrorWidgetWithRefresh(
        height: MediaQuery.of(context).size.height - kSize200,
        onRefresh: () async => {
          _getPlaylistData(
              productType: lastSelectedIndex == 0
                  ? ""
                  : getCategoryType().keys.elementAt(lastSelectedIndex),
              offset: 0,
              isForceFetch: true)
        },
      ),
    );
  }

  void _navigateHotelDetail(
      HotelVerticalCardViewModel playlistCardViewModel, BuildContext context) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      playlistCardViewModel.id,
      playlistCardViewModel.cityId,
      playlistCardViewModel.countryId,
      getLoginProvider().userType.getHotelDetailType(),
    );
    Navigator.pushNamed(
      context,
      AppRoutes.hotelDetail,
      arguments: hotelArgument,
    );
  }

  void _navigateToCarSupplierScreen(
      CarVerticalCardViewModel carModel, BuildContext context) {
    CarSupplierArgumentViewModel argumentModel = CarSupplierArgumentViewModel();

    argumentModel = CarSupplierArgumentViewModel(
        pickupLocationId: carModel.pickupLocationId ?? '',
        returnLocationId: carModel.returnLocationId ?? '',
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
        carId: carModel.id,
        includeDriver: AppConfig().configModel.includeDriver,
        currency: AppConfig().currency,
        rentalType: AppConfig().rentalType,
        age: AppConfig().configModel.carDriverDefaultAge,
        craftType: carModel.craftType ?? '',
        residenceCountry: carModel.countryName ?? '',
        carName: carModel.name,
        pickupLocation: carModel.locationName ?? '',
        pickupCounter: AppConfig().configModel.pickupCounter,
        returnCounter: AppConfig().configModel.returnCounter,
        thumbImage: carModel.imageUrl);

    Navigator.pushNamed(
      context,
      AppRoutes.carSupplierScreen,
      arguments: argumentModel,
    );
  }

  void _openTourDetailScreen(
      TourVerticalCardViewModel model, BuildContext context) {
    TourDetailArgument tourDetailArgument = TourDetailArgument(
      userType: getLoginProvider().isLoggedIn()
          ? TourDetailUserType.loggedInUser
          : TourDetailUserType.guestUser,
      tourId: model.id!,
      cityId: model.cityId!,
      countryId: model.countryId!,
    );
    Navigator.pushNamed(
      context,
      AppRoutes.tourDetailScreen,
      arguments: tourDetailArgument,
    );
  }

  void _openTicketDetailScreen(
      TourVerticalCardViewModel model, BuildContext context) {
    TicketDetailArgument ticketDetailArgument = TicketDetailArgument(
      userType: getLoginProvider().isLoggedIn()
          ? TicketDetailUserType.loggedInUser
          : TicketDetailUserType.guestUser,
      ticketId: model.id!,
      cityId: model.cityId!,
      countryId: model.countryId!,
    );
    Navigator.pushNamed(
      context,
      AppRoutes.ticketDetailScreen,
      arguments: ticketDetailArgument,
    );
  }

  List<String?>? _getAddAllSequence(
      List<VerticalStaticPlayListCardViewModel>? cardPlayList,
      String kPlaylistType) {
    List<String?>? result;
    if (cardPlayList != null) {
      switch (kPlaylistType) {
        case OtaServiceType.hotel:
          result = cardPlayList.map((e) => e.hotel?.id).toList();
          break;
        case OtaServiceType.tour:
          result = cardPlayList.map((e) => e.tour?.id).toList();
          break;
        case OtaServiceType.ticket:
          result = cardPlayList.map((e) => e.ticket?.id).toList();
          break;
        case OtaServiceType.carRental:
          result = cardPlayList.map((e) => e.car?.id).toList();
          break;
      }
    }
    return result;
  }

  void _getPlaylistVieWall(
      VerticalStaticPlayListCardViewModel list,
      List<VerticalStaticPlayListCardViewModel> playlist,
      String kPlaylistType) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistSection,
        value: _kPlaylistSection);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistId,
        value: viewArgument?.playlistId);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistName,
        value: viewArgument?.playlistName);
    switch (kPlaylistType) {
      case OtaServiceType.hotel:
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaHotelName,
            value: list.hotel?.name);
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaHotelId, value: list.hotel?.id);
        break;
      case OtaServiceType.tour:
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaActivityId,
            value: list.tour?.id);
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaActivityName,
            value: list.tour?.name);
        break;
      case OtaServiceType.ticket:
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaActivityId,
            value: list.ticket?.id);
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaActivityName,
            value: list.ticket?.name);
        break;
      case OtaServiceType.carRental:
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaCarId, value: list.car?.id);
        logger.addKeyValue(
            key: OtaPlayListVieWallFirebase.otaCarName, value: list.car?.name);
        break;
    }
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaTravelId, value: _kTravelId);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaTravelName, value: _kTravelName);

    logger.addCommaSeparatedList(
        key: OtaPlayListVieWallFirebase.otaAllIdSequence,
        value: _getAddAllSequence(playlist, kPlaylistType));
    logger.addUserLocation();
    logger.publishToSuperApp(FirebaseEvent.otaPlaylistVieWall);
  }
}
