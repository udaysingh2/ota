import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_landing_page_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/car_card_view_model.dart';
import 'package:ota/modules/landing/view_model/hotel_card_view_model.dart';
import 'package:ota/modules/landing/view_model/landing_static_playlist_card_view_model.dart';
import 'package:ota/modules/landing/view_model/static_playlist_data_view_model.dart';
import 'package:ota/modules/landing/view_model/tour_card_view_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/playlist/view/widgets/car_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/hotel_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view/widgets/tour_ticket_static_playlist_card_widget.dart';
import 'package:ota/modules/playlist/view_model/car_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/hotel_vertical_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/tour_vertical_card_view_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

const _kSuggestionWidgetPadding = EdgeInsets.only(bottom: 0);
const _kTitleMaxLines = 1;
const _kDefaultLength = 7;
const String _kPlaylistSection = "OTA_landing";
const String _kTravelId = 'mix';
const String _kTravelName = 'mix';

class StaticPlayListWidget extends StatelessWidget {
  final List<OtaLandingStaticPlayListModel> playList;
  final Function(String playListId, String name)? onTitleArrowClick;

  const StaticPlayListWidget({
    Key? key,
    required this.playList,
    this.onTitleArrowClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
            List<Widget>.generate(_getStaticListLength(playList.length), (i) {
      List<LandingStaticPlayListCardViewModel> modelPlayList =
          _verifyPlayList(playList[i].cardList);
      //Handle empty case
      if (!modelPlayList.isNotEmpty) return const SizedBox.shrink();
      return Padding(
        padding: _kSuggestionWidgetPadding,
        child: modelPlayList.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kSize24),
                    child: _getTitleBar(
                      title: playList[i].playlistName!,
                      id: playList[i].playlistId!,
                    ),
                  ),
                  const SizedBox(
                    height: kSize16,
                  ),
                  OtaPlayListAmenities(
                    builder: (index) {
                      return _buildCardWidget(
                          modelPlayList.elementAt(index), context, playList[i]);
                    },
                    length: modelPlayList.length,
                  ),
                ],
              )
            : const SizedBox.shrink(),
      );
    }));
  }

  int _getStaticListLength(int length) {
    return length <= _kDefaultLength ? length : _kDefaultLength;
  }

  Widget _buildCardWidget(LandingStaticPlayListCardViewModel model,
      BuildContext context, OtaLandingStaticPlayListModel playlistModel) {
    String type = model.productType;
    switch (type) {
      case OtaServiceType.hotel:
        HotelVerticalCardViewModel viewModel =
            HotelVerticalCardViewModel.fromHotelCardViewModel(model.hotel!);
        return HotelStaticPlaylistCard(
            onPress: () {
              _getPlaylistEvent(model, playlistModel, type);
              _navigateHotelDetail(model.hotel!, context);
            },
            model: viewModel);
      case OtaServiceType.tour:
        TourVerticalCardViewModel viewModel =
            TourVerticalCardViewModel.fromTourCardViewModel(model.tour!);
        return TourTicketStaticPlaylistCard(
            onPress: () {
              _getPlaylistEvent(model, playlistModel, type);
              _navigateTourTicketDetail(model, context);
            },
            model: viewModel,
            playlistType: LandingPageHelper.getPlayListType(type));
      case OtaServiceType.ticket:
        TourVerticalCardViewModel viewModel =
            TourVerticalCardViewModel.fromTourCardViewModel(model.ticket!);
        return TourTicketStaticPlaylistCard(
            onPress: () {
              _getPlaylistEvent(model, playlistModel, type);
              _navigateTourTicketDetail(model, context);
            },
            model: viewModel,
            playlistType: LandingPageHelper.getPlayListType(type));
      case OtaServiceType.carRental:
        CarVerticalCardViewModel viewModel =
            CarVerticalCardViewModel.fromCarCardViewModel(model.carRental!);
        return CarStaticPlaylistCard(
          onPress: () {
            _getPlaylistEvent(model, playlistModel, type);
            _navigateToCarDetail(model, context);
          },
          model: viewModel,
        );
      default:
        return const SizedBox();
    }
  }

  void _navigateHotelDetail(
      HotelCardViewModel playlistCardViewModel, BuildContext context) {
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

  void _navigateTourTicketDetail(
      LandingStaticPlayListCardViewModel playlistCardViewModel,
      BuildContext context) {
    if (playlistCardViewModel.modelEnum == StaticPlayListModelEnum.tour) {
      _openTourDetailScreen(playlistCardViewModel.tour!, context);
    } else if (playlistCardViewModel.modelEnum ==
        StaticPlayListModelEnum.ticket) {
      _openTicketDetailScreen(playlistCardViewModel.ticket!, context);
    }
  }

  void _navigateToCarDetail(
      LandingStaticPlayListCardViewModel playlistCardViewModel,
      BuildContext context) {
    if (playlistCardViewModel.modelEnum == StaticPlayListModelEnum.carRental) {
      _navigateToCarSupplierScreen(playlistCardViewModel.carRental!, context);
    }
  }

  void _openTourDetailScreen(TourCardViewModel model, BuildContext context) {
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

  void _openTicketDetailScreen(TourCardViewModel model, BuildContext context) {
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

  void _navigateToCarSupplierScreen(
      CarRentalViewModel carModel, BuildContext context) {
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

  Widget _getTitleBar({
    required String title,
    required String id,
  }) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTheme.kHeading1Medium,
          maxLines: _kTitleMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        OtaNextButton(
          onPress: () {
            if (onTitleArrowClick != null) {
              onTitleArrowClick!(id, title);
            }
          },
        ),
        const SizedBox(width: kSize8),
      ],
    );
  }

  List<LandingStaticPlayListCardViewModel> _verifyPlayList(
      List<LandingStaticPlayListCardViewModel>? playlist) {
    List<LandingStaticPlayListCardViewModel> updatedPlaylist = [];
    if (playlist == null || playlist.isEmpty) {
      return updatedPlaylist;
    }
    for (LandingStaticPlayListCardViewModel model in playlist) {
      if (model.modelEnum == StaticPlayListModelEnum.hotel &&
          model.hotel != null) {
        updatedPlaylist.add(model);
      } else if (model.modelEnum == StaticPlayListModelEnum.tour &&
          model.tour != null &&
          OtaServiceEnabledHelper.isTourEnabled()) {
        updatedPlaylist.add(model);
      } else if (model.modelEnum == StaticPlayListModelEnum.ticket &&
          model.ticket != null &&
          OtaServiceEnabledHelper.isTourEnabled()) {
        updatedPlaylist.add(model);
      } else if (model.modelEnum == StaticPlayListModelEnum.carRental &&
          model.carRental != null &&
          OtaServiceEnabledHelper.isCarEnabled()) {
        updatedPlaylist.add(model);
      }
    }
    return updatedPlaylist;
  }

  List<String?>? _getAddOnItemName(
      List<LandingStaticPlayListCardViewModel>? cardPlayList,
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
          result = cardPlayList.map((e) => e.carRental?.id).toList();
          break;
      }
    }
    return result;
  }

  void _getPlaylistEvent(LandingStaticPlayListCardViewModel model,
      OtaLandingStaticPlayListModel playlistModel, String kPlaylistType) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistSection,
        value: _kPlaylistSection);
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistId,
        value: playlistModel.playlistId ?? '');
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.playlistName,
        value: playlistModel.playlistName ?? '');
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.travelId, value: _kTravelId);
    logger.addKeyValue(
        key: OtaPlayListLandingFirebase.travelName, value: _kTravelName);
    switch (kPlaylistType) {
      case OtaServiceType.hotel:
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.hotelId, value: model.hotel?.id);
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.hotelName,
            value: model.hotel?.name);
        break;
      case OtaServiceType.tour:
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.activityId, value: model.tour?.id);
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.activityName,
            value: model.tour?.name);
        break;
      case OtaServiceType.ticket:
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.activityId,
            value: model.ticket?.id);
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.activityName,
            value: model.ticket?.name);
        break;
      case OtaServiceType.carRental:
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.carId, value: model.carRental?.id);
        logger.addKeyValue(
            key: OtaPlayListLandingFirebase.carName,
            value: model.carRental?.name);
        break;
    }
    logger.addCommaSeparatedList(
        value: _getAddOnItemName(playlistModel.cardList, kPlaylistType),
        key: OtaPlayListLandingFirebase.allIdSequence);
    logger.addUserLocation();
    logger.publishToSuperApp(FirebaseEvent.otaPlaylist);
  }
}
