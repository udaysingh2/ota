import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_landing_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_detail_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_playlist_amenities.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_banner_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_landing_location_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_landing_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_playlist_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_playlist_view_all_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_search_input_parameters.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_filters_controller.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_scroll_state_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/recommended_location_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_app_bar.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_filters.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_header_text.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_place_holder.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_recommended_locations_widget.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_slider_top.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_playlist_view_model.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';
import 'package:ota/modules/landing/bloc/banner_bloc.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:ota/modules/ota_date_range_picker/view_model/ota_date_range_picker_argument_model.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/hotel_room_selection/helpers/hotel_room_selection_helper.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_state_model.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/helper.dart';
import '../../hotel_detail/view_model/argument_model.dart';
import '../../hotel_landing_playlist/view_model/hotel_landing_dynamic_argument_model.dart';
import '../../hotel_landing_playlist/view_model/hotel_landing_static_argument_model.dart';
import '../bloc/hotel_dynamic_playlist_bloc.dart';
import '../view_model/hotel_dynamic_playlist_view_models.dart';
import '../view_model/hotel_recentviewplaylist_view_model.dart';

const String _kBannerType = "HOTEL_LANDING";
const int _kScrollDuration = 500;
const double _kExpandableMaxHeight = 220;
const double _kDetailsBorder = 24;
const int _kLastIndex = 1;
const String _kPlaylistName = 'Hotel_Landing';
const int _kTravelId = 1;
const String _kTravelName = 'hotel';

class HotelLandingScreen extends StatefulWidget {
  const HotelLandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  HotelLandingScreenState createState() => HotelLandingScreenState();
}

class HotelLandingScreenState extends State<HotelLandingScreen> {
  final ScrollController _scrollController = ScrollController();
  final HotelLandingScrollStateBloc _hotelLandingScrollStateBloc =
      HotelLandingScrollStateBloc();
  final BannerBloc _bannerBloc = BannerBloc();
  final RecommendedLocationBloc _recommendedLocationBloc =
      RecommendedLocationBloc();
  final HotelLandingFiltersController _checkInCheckOutDateController =
      HotelLandingFiltersController();
  final HotelLandingFiltersController _noOfGuestsRoomController =
      HotelLandingFiltersController();
  final HotelLandingFiltersController _searchLocationController =
      HotelLandingFiltersController();
  final HotelRoomSelectionArgumentModel _hotelRoomSelectionArgument =
      HotelRoomSelectionArgumentModel.getFromConfig();
  DateTime _checkInDate = DateTime.now()
      .add(Duration(days: AppConfig().configModel.checkInDeltaHotel));
  DateTime _checkOutDate = DateTime.now()
      .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel));
  FilterArgument? _filterArgument;
  final HotelPlaylistBloc _hotelPlaylistBloc = HotelPlaylistBloc();
  final HotelDynamicPlaylistBloc _hotelDynamicPlaylistBloc =
      HotelDynamicPlaylistBloc();

  void _openHotelSearchScreen() async {
    final filterArgument =
        await Navigator.pushNamed(context, AppRoutes.hotelSearchScreen)
            as FilterArgument?;
    if (filterArgument != null) {
      _filterArgument = filterArgument;
      _searchLocationController.setText(
        filterArgument.name ??
            getTranslated(
                context, AppLocalizationsStrings.hotelLandingSearchPlaceholder),
      );
    }
  }

  void _openOtaDateRangePickerScreen() async {
    final dateRangeArgument =
        await Navigator.pushNamed(context, AppRoutes.otaDateRangePickerScreen,
            arguments: OtaDateRangePickerArgumentModel(
              checkInDate: _checkInDate,
              checkOutDate: _checkOutDate,
            )) as OtaDateRangePickerArgumentModel?;
    if (dateRangeArgument != null) {
      _checkInDate = dateRangeArgument.checkInDate;
      _checkOutDate = dateRangeArgument.checkOutDate;
      _checkInCheckOutDateController.setText(_getCheckInCheckOutDateString());
    }
  }

  void _openHotelFilterScreen() async {
    final roomSelectionArgument = await Navigator.pushNamed(
            context, AppRoutes.hotelRoomSelectionScreen,
            arguments: _hotelRoomSelectionArgument)
        as HotelRoomSelectionArgumentModel?;
    if (roomSelectionArgument != null) {
      _hotelRoomSelectionArgument.roomList = roomSelectionArgument.roomList;
      _noOfGuestsRoomController.setText(_getNoOfGuestsAndRoomsString());
    }
  }

  void _openSearchResultScreen() async {
    HotelSearchInputParameters.isFromSearch = true;
    if (_filterArgument != null) {
      _filterArgument!.checkInDate =
          Helpers.getYYYYmmddFromDateTime(_checkInDate);
      _filterArgument!.checkOutDate =
          Helpers.getYYYYmmddFromDateTime(_checkOutDate);
      _filterArgument!.roomList = HotelRoomSelectionHelper.getRoomArgumentList(
          _hotelRoomSelectionArgument.roomList);

      final otaSearchStateModel = OtaSearchStateModel(
          pageType: PageType.hotel, filterArgument: _filterArgument);
      final updatedFilterArgument = await Navigator.pushNamed(
              context, AppRoutes.hotelListView, arguments: otaSearchStateModel)
          as FilterArgument;

      _checkInDate =
          Helpers().parseDateTime(updatedFilterArgument.checkInDate!);
      _checkOutDate =
          Helpers().parseDateTime(updatedFilterArgument.checkOutDate!);
      _checkInCheckOutDateController.setText(_getCheckInCheckOutDateString());

      _hotelRoomSelectionArgument.roomList =
          HotelRoomSelectionHelper.getHotelRoomArguments(
              updatedFilterArgument.roomList);
      _noOfGuestsRoomController.setText(_getNoOfGuestsAndRoomsString());
    }
  }

  void _openSearchResultScreenOnRecommendedLocationClick(
      RecommendedLocationModel recommendedModel) async {
    HotelSearchInputParameters.isFromSearch = false;
    final FilterArgument filterArgument = FilterArgument(
      checkInDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkInDeltaHotel))),
      checkOutDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel))),
      roomList: [
        RoomArgument(
          adults: AppConfig().configModel.defaultAdultCount,
          childAgeList: [],
          bedTypeKey: AppConfig().configModel.defaultAdultCount ==
                  AppConfig().configModel.bedTypeMaxAdults
              ? AppConfig().configModel.defaultBedType
              : null,
        )
      ],
      hotelId: recommendedModel.hotelId,
      cityId: recommendedModel.cityId,
      countryCode: recommendedModel.countryId,
      currencyCode: AppConfig().currency,
      name: recommendedModel.placeName,
    );

    final otaSearchStateModel = OtaSearchStateModel(
        pageType: PageType.hotel, filterArgument: filterArgument);
    Navigator.pushNamed(context, AppRoutes.hotelListView,
        arguments: otaSearchStateModel);
  }

  String _getCheckInCheckOutDateString() {
    return '${Helpers.getwwddMMMyy(_checkInDate)} - ${Helpers.getwwddMMMyy(_checkOutDate)}';
  }

  String _getNoOfGuestsAndRoomsString() {
    final roomCount = _hotelRoomSelectionArgument.roomList?.length ?? 0;
    final adultCount = _hotelRoomSelectionArgument.getTotalAdults();
    final childrenCount = _hotelRoomSelectionArgument.getTotalChildren();
    final roomsString =
        getTranslated(context, AppLocalizationsStrings.roomsLabel);
    final adultsString =
        getTranslated(context, AppLocalizationsStrings.adultsLabel)
            .replaceFirst('#', adultCount.toString());
    final chidrenString =
        getTranslated(context, AppLocalizationsStrings.childrenLabel)
            .replaceFirst('#', childrenCount.toString());
    if (childrenCount > 0) {
      return '$adultsString, $chidrenString, $roomCount $roomsString';
    } else {
      return '$adultsString, $roomCount $roomsString';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bannerBloc.dispose();
    _recommendedLocationBloc.dispose();
    _hotelLandingScrollStateBloc.dispose();
    _checkInCheckOutDateController.dispose();
    _hotelDynamicPlaylistBloc.dispose();
    _hotelPlaylistBloc.dispose();
    _noOfGuestsRoomController.dispose();
    _searchLocationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _makeApiCall();
      _bannerBloc.stream.listen((event) {
        if (event.bannerViewModelState ==
            BannerViewModelState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      });
      FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelSearchInput);
    });
    _scrollController.addListener(() {
      _hotelLandingScrollStateBloc
          .checkScrollListener(_scrollController.offset);
    });
    _recommendedLocationBloc.stream.listen((event) {
      if (_recommendedLocationBloc.state.recommendationsState ==
          RecommendedLocationModelState.success) {
        _getLandingFirebase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bannerBloc,
      builder: () {
        if (_bannerBloc.state.bannerViewModelState ==
            BannerViewModelState.internetFailure) {
          return failureWidget();
        }
        return successWidget();
      },
    );
  }

  Widget successWidget() {
    return Scaffold(
      body: Stack(
        children: [
          HotelLandingPlaceHolder(
            hotelLandingScrollStateBloc: _hotelLandingScrollStateBloc,
          ),
          HotelLandingAppBar(child: getChildren()),
          getHotelSliderTop(),
        ],
      ),
    );
  }

  Widget failureWidget() {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.accomodation),
      ),
      body: OtaDetailErrorWidget(
        height: MediaQuery.of(context).size.height -
            (_kExpandableMaxHeight + _kDetailsBorder),
        onRefresh: () async => _makeApiCall(),
      ),
    );
  }

  void _makeApiCall() {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    _hotelPlaylistBloc.getPlayListData(
        HotelStaticPlayListArgumentModelDomain.getDefaultInitialArguments(
            loginModel.userId));
    _hotelDynamicPlaylistBloc.getDynamicPlayListData(
        HotelDynamicPlayListDataArgumentModelDomain.getDefaultInitialArguments(
            loginModel.userId));
    requestBannerData();
    _recommendedLocationBloc.getLandingRecommendations();
  }

  List<Widget> addAllYourWidgetHere() {
    return [
      _getBanners(),
      _buildRecommendedLocationWidget(),
      const SizedBox(
        height: kSize26,
      ),
      BlocBuilder(
          bloc: _hotelDynamicPlaylistBloc,
          builder: () {
            if (_hotelDynamicPlaylistBloc
                    .state.hotelDynamicPlayListViewModelState ==
                HotelDynamicPlayListViewModelState.recentPlayListSuccess) {
              return _getRecentPlayList(
                  _hotelDynamicPlaylistBloc.state.recentPlayList!.playList,
                  _hotelDynamicPlaylistBloc.state.recentPlayList,
                  context);
            } else {
              return const SizedBox();
            }
          }),
      BlocBuilder(
          bloc: _hotelDynamicPlaylistBloc,
          builder: () {
            if (_hotelDynamicPlaylistBloc
                    .state.hotelDynamicPlayListViewModelState ==
                HotelDynamicPlayListViewModelState.dynamicPlayListSuccess) {
              return Column(
                  children: _getOtaHorizontalPlayListAmenities(
                      _hotelDynamicPlaylistBloc.state.dynamicPlaylist!.playlist,
                      context,
                      false,
                      title: getTranslated(context,
                          AppLocalizationsStrings.recommendedAccomodation)));
            } else {
              return const SizedBox();
            }
          }),
      BlocBuilder(
          bloc: _hotelPlaylistBloc,
          builder: () {
            if (_hotelPlaylistBloc.state.hotelStaticPlayListViewModelState ==
                HotelStaticPlayListViewModelState.success) {
              return Column(
                children: _getOtaHorizontalPlayListAmenities(
                    _hotelPlaylistBloc.state.playList, context, true),
              );
            } else {
              return const SizedBox();
            }
          }),
    ];
  }

  List<Widget> _getOtaHorizontalPlayListAmenities(
      List<HotelStaticPlayListModel> playList,
      BuildContext context,
      bool isStatic,
      {String? title}) {
    return List<Widget>.generate(playList.length, (index) {
      if (playList[index].hotelStaticCardPlaylist.isEmpty) {
        return const SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: kSize24),
            child: _getTitleBar(context, title ?? playList[index].playlistName,
                true, isStatic, playList[index].playlistId),
          ),
          const SizedBox(
            height: kSize16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: OtaPlayListAmenities(
              length: playList[index].hotelStaticCardPlaylist.length,
              builder: (ind) {
                return OtaSuggestionCardHorizontalAmenities(
                    headerText:
                        playList[index].hotelStaticCardPlaylist[ind].name,
                    adminPromotionLine1: playList[index]
                        .hotelStaticCardPlaylist[ind]
                        .promotionTextLine1,
                    adminPromotionLine2: playList[index]
                        .hotelStaticCardPlaylist[ind]
                        .promotionTextLine2,
                    amenitiesList: HotelLandingHelper.getAmenitiesList(
                      playList[index]
                          .hotelStaticCardPlaylist[ind]
                          .capsulePromotion,
                      playList[index]
                          .hotelStaticCardPlaylist[ind]
                          .infoPromotion,
                      isStatic,
                    ),
                    ratingText:
                        playList[index].hotelStaticCardPlaylist[ind].rating,
                    addressText: playList[index]
                        .hotelStaticCardPlaylist[ind]
                        .locationName,
                    imageUrl:
                        playList[index].hotelStaticCardPlaylist[ind].imageUrl,
                    onPress: () {
                      _getPlaylistFirebase(
                          playList[index],
                          playList[index].hotelStaticCardPlaylist,
                          playList[index].hotelStaticCardPlaylist[ind]);
                      openHotelDetailScreen(
                        cityId:
                            playList[index].hotelStaticCardPlaylist[ind].cityId,
                        countryId: playList[index]
                            .hotelStaticCardPlaylist[ind]
                            .countryId,
                        hotelId:
                            playList[index].hotelStaticCardPlaylist[ind].id,
                      );
                    });
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _getRecentPlayList(
      List<HotelRecentPlayListModel> recentPlayList,
      HotelRecentPlayListViewModel? hotelRecentPlayListViewModel,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: kSize24),
          child: _getTitleBar(
              context,
              getTranslated(context, AppLocalizationsStrings.recentlyViewed),
              false,
              false,
              ''),
        ),
        const SizedBox(
          height: kSize16,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kSize16),
          child: OtaPlayListAmenities(
            length: recentPlayList.length,
            builder: (ind) {
              return OtaSuggestionCardHorizontalAmenities(
                  headerText: recentPlayList[ind].hotelName,
                  adminPromotionLine1: recentPlayList[ind].adminPromotionLine1,
                  adminPromotionLine2: recentPlayList[ind].adminPromotionLine2,
                  amenitiesList: recentPlayList[ind].ammenitiesList,
                  ratingText: recentPlayList[ind].rating,
                  addressText: recentPlayList[ind].locationName,
                  imageUrl: recentPlayList[ind].image,
                  onPress: () {
                    openHotelDetailScreen(
                        hotelId: recentPlayList[ind].hotelId,
                        countryId: recentPlayList[ind].countryId,
                        cityId: recentPlayList[ind].cityId);
                  });
            },
          ),
        ),
      ],
    );
  }

  void openHotelDetailScreen(
      {String hotelId = "", String cityId = "", String countryId = ""}) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      hotelId,
      cityId,
      countryId,
      getLoginProvider().userType.getHotelDetailType(),
    );
    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  Widget _getTitleBar(
    BuildContext context,
    String title,
    bool isNextArrowShown,
    bool isStatic,
    String playlistId,
  ) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTheme.kHeading1Medium,
          maxLines: _kLastIndex,
          overflow: TextOverflow.ellipsis,
        )),
        if (isNextArrowShown)
          OtaNextButton(onPress: () {
            onTitleArrowClicked(isStatic, playlistId, title);
          }),
        if (isNextArrowShown) const SizedBox(width: kSize8),
      ],
    );
  }

  void onTitleArrowClicked(
      bool isStatic, String playlistId, String playlistName) {
    if (isStatic) {
      Navigator.pushNamed(context, AppRoutes.hotelLandingStaticPlaylistScreen,
          arguments: HotelLandingStaticArgumentModel(
            lat: 0,
            userId: getLoginProvider().userId,
            lng: 0,
            epoch: Helpers.getEpochTime().toString(),
            playlistId: playlistId,
            playlistName: playlistName,
          ));
    } else {
      Navigator.pushNamed(context, AppRoutes.hotelLandingDynamicPlaylistScreen,
          arguments: HotelLandingDynamicArgumentModel(
            lat: 0,
            userId: getLoginProvider().userId,
            lng: 0,
            epoch: Helpers.getEpochTime().toString(),
            playlistId: playlistId,
          ));
    }
    FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelPlaylistViewAll);
    _getViewAllPlaylistFirebase(playlistId, playlistName);
  }

  Widget getChildren() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: kSize24),
        children: [
          getFilterOptionWidgets(),
          ...addAllYourWidgetHere(),
        ],
      ),
    );
  }

  Widget getFilterOptionWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelLandingHeaderText(
            text: getTranslated(context, AppLocalizationsStrings.locationLabel),
          ),
          const SizedBox(height: kSize8),
          HotelLandingFilters(
            leadingText: getTranslated(
                context, AppLocalizationsStrings.hotelLandingSearchPlaceholder),
            hotelLandingFiltersTrailingWidget:
                HotelLandingFiltersTrailingWidget.searchIcon,
            onTab: () {
              _openHotelSearchScreen();
            },
            hotelLandingFiltersController: _searchLocationController,
          ),
          const SizedBox(height: kSize24),
          HotelLandingHeaderText(
            text: getTranslated(
                context, AppLocalizationsStrings.checkInCheckOutDate),
          ),
          const SizedBox(height: kSize8),
          HotelLandingFilters(
            leadingText: _getCheckInCheckOutDateString(),
            onTab: () => _openOtaDateRangePickerScreen(),
            hotelLandingFiltersController: _checkInCheckOutDateController,
          ),
          const SizedBox(height: kSize24),
          HotelLandingHeaderText(
            text: getTranslated(
                context, AppLocalizationsStrings.noOfGuestAndRooms),
          ),
          const SizedBox(height: kSize8),
          HotelLandingFilters(
            leadingText: _getNoOfGuestsAndRoomsString(),
            onTab: () => _openHotelFilterScreen(),
            hotelLandingFiltersController: _noOfGuestsRoomController,
          ),
          const SizedBox(height: kSize24),
          _buildBottomBar(),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(
            height: kSize1,
            dividerColor: AppColors.kGrey10,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedLocationWidget() {
    return BlocBuilder(
      bloc: _recommendedLocationBloc,
      builder: () {
        if (_recommendedLocationBloc.isSuccess &&
            !_recommendedLocationBloc.isRecommendationsEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: kSize32),
            child: HotelRecommendedLocationsWidget(
              recommendedLocationList:
                  _recommendedLocationBloc.state.recommendedLocationList,
              recommendedLocationTitle: getTranslated(
                  context, AppLocalizationsStrings.recommendationLocations),
              onTap: (index) {
                getHotelLocationRecommendationFirebaseEvents(
                    _recommendedLocationBloc
                        .state.recommendedLocationList[index]);
                _openSearchResultScreenOnRecommendedLocationClick(
                    _recommendedLocationBloc
                        .state.recommendedLocationList[index]);
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildBottomBar() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder(
        bloc: _searchLocationController,
        builder: () {
          return OtaTextButton(
              key: const Key('OtaTextButtonTemp'),
              title:
                  getTranslated(context, AppLocalizationsStrings.searchLabel),
              isSelected: true,
              isDisabled: _searchLocationController.state ==
                  getTranslated(context,
                      AppLocalizationsStrings.hotelLandingSearchPlaceholder),
              onPressed: () {
                _getAppFlyer();
                HotelSearchInputParameters.isFromSearch = true;
                if (HotelSearchInputParameters.isFromSearch) {
                  _getSearchFirebase();
                }
                _openSearchResultScreen();
              });
        },
      ),
    );
  }

  Widget getHotelSliderTop() {
    return HotelLandingSliderTop(
      statusBarTitle:
          getTranslated(context, AppLocalizationsStrings.accomodation),
      hotelLandingScrollStateBloc: _hotelLandingScrollStateBloc,
      onBackClicked: () => Navigator.of(context).pop(),
      onTopSearchClicked: () {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: _kScrollDuration),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }

  Widget _getBanners() {
    return BlocBuilder(
      bloc: _bannerBloc,
      builder: () {
        return _bannerBloc.state.bannerViewModelState ==
                BannerViewModelState.success
            ? Container(
                padding: const EdgeInsets.only(top: kSize32),
                child: BannerWidget(
                  bannerList: _bannerBloc.state.data,
                  launchBannerInApp: true,
                  onBannerTap: (index) {
                    _getBannerFireBase(_bannerBloc.state.data[index], index);
                  },
                ),
              )
            : const SizedBox();
      },
    );
  }

  Future<void> requestBannerData() {
    return _bannerBloc.getBannerData(_kBannerType);
  }

  void _getAppFlyer() {
    AppFlyerLogger logger = AppFlyerLogger();

    int result = Helpers.daysBetween(
        start: Helpers.getYYYYmmddFromDateTime(_checkInDate),
        end: Helpers.getYYYYmmddFromDateTime(_checkOutDate));

    logger.addKeyValue(
        key: HotelLandingAppFlyer.numberOfRoom,
        value: _hotelRoomSelectionArgument.roomList?.length.toString() ?? "0");
    logger.addKeyValue(
        key: HotelLandingAppFlyer.numberOfAdult,
        value: _hotelRoomSelectionArgument.getTotalAdults().toString());
    logger.addKeyValue(
        key: HotelLandingAppFlyer.numberOfChild,
        value: _hotelRoomSelectionArgument.getTotalChildren().toString());
    logger.addDateValue(
        key: HotelLandingAppFlyer.checkInDate, value: _checkInDate);
    logger.addDateValue(
        key: HotelLandingAppFlyer.checkOutDate, value: _checkOutDate);
    logger.addKeyValue(
        key: HotelLandingAppFlyer.hotelLocation,
        value: _filterArgument?.name ?? "");
    logger.addKeyValue(
        key: HotelLandingAppFlyer.searchContent,
        value: _filterArgument?.name ?? "");
    logger.addIntValue(key: HotelLandingAppFlyer.stayPeriod, value: result);
    logger.addUserLocation();

    logger.publishToSuperApp(AppFlyerEvent.hotelLandingEvent);
  }

  getHotelLocationRecommendationFirebaseEvents(RecommendedLocationModel model) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: model.cityId,
        key: HotelRecommendationLocationFirebase.recommendationLocationId);
    logger.addKeyValue(
        value: model.placeName,
        key: HotelRecommendationLocationFirebase.recommendationLocationName);
    logger.addCommaSeparatedList(
        value: _recommendedLocationBloc.state.recommendedLocationList
            .map((e) => e.cityId)
            .toList(),
        key:
            HotelRecommendationLocationFirebase.allRecommendlocationIdSequence);
    logger.publishToSuperApp(FirebaseEvent.hotelLocationRecommendation);
  }

  String _getCityIdList() {
    return List<String>.generate(
      _recommendedLocationBloc.state.recommendedLocationList.length,
      (int index) =>
          _recommendedLocationBloc.state.recommendedLocationList[index].cityId,
    ).toString();
  }

  void _getLandingFirebase() {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        key: HotelLandingParameters.hotelAllRecommendLocationId,
        value: _getCityIdList());
    logger.publishToSuperApp(FirebaseEvent.hotelLanding);
  }

  String _getAllIdSequence(List<HotelStaticPlaylistCardModel> hotelModel) {
    return List.generate(hotelModel.length, (index) => hotelModel[index].id)
        .toString();
  }

  void _getPlaylistFirebase(
      HotelStaticPlayListModel? playlistModel,
      List<HotelStaticPlaylistCardModel> hotelModel,
      HotelStaticPlaylistCardModel hotelModelList) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        key: HotelPlaylistParameters.hotelId, value: hotelModelList.id);
    logger.addKeyValue(
        key: HotelPlaylistParameters.hotelName, value: hotelModelList.name);
    logger.addKeyValue(
        key: HotelPlaylistParameters.playlistSection, value: _kPlaylistName);
    logger.addKeyValue(
        key: HotelPlaylistParameters.playlistName,
        value: playlistModel?.playlistName);
    logger.addIntValue(
        key: HotelPlaylistParameters.travelId, value: _kTravelId);
    logger.addKeyValue(
        key: HotelPlaylistParameters.travelName, value: _kTravelName);
    logger.addKeyValue(
        key: HotelPlaylistParameters.playlistId,
        value: playlistModel?.playlistId);
    logger.addKeyValue(
        key: HotelPlaylistParameters.allIdSequence,
        value: _getAllIdSequence(hotelModel));
    logger.publishToSuperApp(FirebaseEvent.hotelPlaylist);
  }

  _getBannerFireBase(BannerDataModel model, int index) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: model.bannerId, key: HotelBannerParameters.bannerId);
    logger.addKeyValue(
        value: model.function, key: HotelBannerParameters.bannerSection);
    logger.addIntValue(
        value: index + 1, key: HotelBannerParameters.bannerSequence);
    logger.addKeyValue(
        value: model.imageUrl, key: HotelBannerParameters.bannerName);
    logger.addKeyValue(
        value: model.deepLinkUrl, key: HotelBannerParameters.bannerUrl);
    logger.addCommaSeparatedList(
        value: _bannerBloc.state.data.map((e) => e.bannerId).toList(),
        key: HotelBannerParameters.allBannerIdSequence);
    logger.publishToSuperApp(FirebaseEvent.hotelBanner);
  }

  void _getViewAllPlaylistFirebase(
    String playlistId,
    String playlistName,
  ) {
    FirebaseHelper.addUserLocation(
        eventName: FirebaseEvent.hotelPlaylistViewAll);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.playlistSection,
        value: _kPlaylistName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.playlistName,
        value: playlistName);
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.travelId,
        value: _kTravelId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.travelName,
        value: _kTravelName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelPlaylistViewAll,
        key: HotelPlaylistViewAllParameters.playlistId,
        value: playlistId);
  }

  void _getSearchFirebase() {
    final otaSearchStateModel = OtaSearchStateModel(
        pageType: PageType.hotel, filterArgument: _filterArgument);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelNoRoom,
        value: _hotelRoomSelectionArgument.roomList?.length.toString() ?? "0");
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelNoAdult,
        value: _hotelRoomSelectionArgument.getTotalAdults().toString());
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelNoChild,
        value: _hotelRoomSelectionArgument.getTotalChildren().toString());
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelNoNight,
        value: Helpers.daysBetween(
            start: _checkInDate.toString(), end: _checkOutDate.toString()));
    FirebaseHelper.addDateValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelStartDate,
        value: _checkInDate);
    FirebaseHelper.addDateValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelEndDate,
        value: _checkOutDate);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelDestinatonId,
        value: _filterArgument?.cityId ?? "");
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelDestinatonName,
        value: HotelSearchInputParameters.hotelDestination);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelKeywordsSearch,
        value: otaSearchStateModel.filterArgument?.name);
  }
}
