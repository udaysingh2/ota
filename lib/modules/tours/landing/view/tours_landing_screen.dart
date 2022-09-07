import 'package:cached_network_image/cached_network_image.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/usecases/get_user_location_use_cases.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_detail_error_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_playlist_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_recommended_location_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_activity_banner_click_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_landing_page_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_tickets_playlist_view_all_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/landing/bloc/banner_bloc.dart';
import 'package:ota/modules/landing/view/widgets/banner/banner.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:ota/modules/tours/landing/bloc/service_card_bloc.dart';
import 'package:ota/modules/tours/landing/bloc/tour_attractions_bloc.dart';
import 'package:ota/modules/tours/landing/bloc/tour_landing_app_bar_bloc.dart';
import 'package:ota/modules/tours/landing/bloc/tour_landing_scroll_state_bloc.dart';
import 'package:ota/modules/tours/landing/bloc/tour_recent_playlist_bloc.dart';
import 'package:ota/modules/tours/landing/bloc/tour_ticket_row_playlist_bloc.dart';
import 'package:ota/modules/tours/landing/helpers/tour_landing_helper.dart';
import 'package:ota/modules/tours/landing/view/widgets/service_cards_widget.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_landing_app_bar.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_landing_place_holder.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_slider_top.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_widget.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_recent_playlist_widget.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';
import 'package:ota/modules/tours/landing/view_model/tour_attractions_view_model.dart';
import 'package:ota/modules/tours/landing/view_model/tour_ticket_row_playlist_view_model.dart';
import 'package:ota/modules/tours/playlist/helpers/tour_ticket_playlist_helper.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/playlist/view_model/tour_ticket_playlist_argument.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_argument_model.dart';

const String _kSearchIconPath = "assets/images/icons/feather_search.svg";
const String _kPlaceHolderBanner =
    "assets/images/icons/tours_attraction_placeholder.svg";
const double _kExpandableMaxHeight = 220;
const double _kDetailsBorder = 24;
const String _kBannerType = "TOUR_LANDING";
const int _kScrollDuration = 500;

class ToursLandingScreen extends StatefulWidget {
  const ToursLandingScreen({Key? key}) : super(key: key);

  @override
  ToursLandingScreenState createState() => ToursLandingScreenState();
}

class ToursLandingScreenState extends State<ToursLandingScreen> {
  final ScrollController _scrollController = ScrollController();
  final TourLandingAppBarBloc _tourLandingAppBarBloc = TourLandingAppBarBloc();
  final TourTicketRowPlaylistBloc _tourPlaylistBloc =
      TourTicketRowPlaylistBloc();
  final TourTicketRowPlaylistBloc _ticketPlaylistBloc =
      TourTicketRowPlaylistBloc();
  final ServiceCardBloc _serviceCardBloc = ServiceCardBloc();
  final TourRecentPlaylistBloc _recentPlaylistBloc = TourRecentPlaylistBloc();
  final TourAttractionsBloc _attractionsBloc = TourAttractionsBloc();
  final BannerBloc _bannerBloc = BannerBloc();
  final TourLandingScrollStateBloc _tourLandingScrollStateBloc =
      TourLandingScrollStateBloc();
  final _userId = getLoginProvider().userId;
  String? latitude;
  String? longitude;

  void _openTourTicketPlaylistScreen(String playlistName) {
    FirebaseHelper.startCapturingEvent(FirebaseEvent.tourTicketPlaylistViewAll);
    if (playlistName == PlaylistType.tour.value) {
      _getFirebasePlaylistViewAllDataForTours();
      _openTourPlaylistScreen(playlistName);
    } else {
      _getFirebasePlaylistForTickets();
      _getFirebasePlaylistViewAllDataForTickets();
      _openTicketPlaylistScreen(playlistName);
    }
  }

  Future<void> getUserLocationFromChannel() async {
    GetUserLocationUseCases getUserLocationUseCases =
        GetUserLocationUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    Either<Failure, GetUserLocationResponseModelChannel> either =
        await getUserLocationUseCases.invokeExampleMethod(
            methodName: "otaUserLocation",
            arguments: loginModel.getUserLocationArgumentModelChannel());
    if (either.isRight) {
      GetUserLocationResponseModelChannel model = either.right;
      longitude = model.longitude;
      latitude = model.latitude;
    }
  }

  void _openTourPlaylistScreen(String playlistName) {
    final playlistArgument = TourTicketPlaylistArgument.from(
      _userId,
      playlistName,
      TourTicketPlaylistHelper.getTourTicketPlaylistFromRowPlaylist(
          _tourPlaylistBloc.state.tourTicketPlaylist),
    );
    Navigator.pushNamed(context, AppRoutes.tourTicketPlaylistScreen,
        arguments: playlistArgument);
  }

  void _openTicketPlaylistScreen(String playlistName) {
    final playlistArgument = TourTicketPlaylistArgument.from(
      _userId,
      playlistName,
      TourTicketPlaylistHelper.getTourTicketPlaylistFromRowPlaylist(
          _ticketPlaylistBloc.state.tourTicketPlaylist),
    );
    Navigator.pushNamed(context, AppRoutes.tourTicketPlaylistScreen,
        arguments: playlistArgument);
  }

  void _openSearchTourTicketSearchResultsScreen(String playlistName) async {
    TourSearchResultArgumentModel argument =
        TourSearchResultArgumentModel(playlistName: playlistName);
    if (latitude != null &&
        longitude != null &&
        latitude!.isNotEmpty &&
        longitude!.isNotEmpty) {
      argument.latitude = double.tryParse(latitude!);
      argument.longitude = double.tryParse(longitude!);
    }
    Navigator.pushNamed(context, AppRoutes.tourLoadingScreen,
        arguments: argument);
  }

  Future<void> _getLandingScreenData() async {
    _serviceCardBloc.getServiceCardData();
    _attractionsBloc.getTourAttractionsData(_kBannerType);
    _tourPlaylistBloc.getTourTicketPlaylistData(
        _userId, PlaylistType.tour.value);
    _ticketPlaylistBloc.getTourTicketPlaylistData(
        _userId, PlaylistType.ticket.value);
    _recentPlaylistBloc.getTourRecentPlaylist();
  }

  @override
  void dispose() {
    _tourLandingAppBarBloc.dispose();
    _serviceCardBloc.dispose();
    _bannerBloc.dispose();
    _recentPlaylistBloc.dispose();
    _tourPlaylistBloc.dispose();
    _ticketPlaylistBloc.dispose();
    _attractionsBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _tourLandingAppBarBloc.setStatusOnScroll(_scrollController);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseHelper.startCapturingEvent(FirebaseEvent.activityPlaylist);
      _getLandingScreenData();
      requestBannerData();
      getUserLocationFromChannel();
    });
    _serviceCardBloc.stream.listen((event) {
      if (_serviceCardBloc.state.pageState ==
          ServiceCardPageState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _attractionsBloc.stream.listen((event) {
      if (_attractionsBloc.isSuccess) {
        _getTourLandingFirebaseEvents(FirebaseEvent.activityLanding);
      }
    });

    _tourPlaylistBloc.stream.listen((event) {
      if (_tourPlaylistBloc.state.playlistState ==
          TourTicketRowPlaylistViewModelState.success) {
        _getFirebasePlaylistForTours();
        _getFirebasePlaylistForTickets();
      }
    });

    _scrollController.addListener(() {
      _tourLandingScrollStateBloc.checkScrollListener(_scrollController.offset);
    });
  }

  Future<void> requestBannerData() {
    return _bannerBloc.getBannerData(_kBannerType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _serviceCardBloc,
      builder: () {
        if (_serviceCardBloc.isLoading) {
          return loadingWidget();
        } else if (_serviceCardBloc.isFailure) {
          return failureWidget();
        } else if (_serviceCardBloc.isSuccess) {
          return getBodyWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget getBodyWidget() {
    return Scaffold(
      body: Stack(
        children: [
          TourLandingPlaceHolder(
            tourLandingScrollStateBloc: _tourLandingScrollStateBloc,
          ),
          TourLandingAppBar(child: getChildren()),
          getTourSliderTop(),
        ],
      ),
    );
  }

  Widget getTourSliderTop() {
    return TourLandingSliderTop(
      statusBarTitle:
          getTranslated(context, AppLocalizationsStrings.bookTourAndActivities),
      tourLandingScrollStateBloc: _tourLandingScrollStateBloc,
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

  Widget getChildren() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: kSize24),
        children: [
          _buildSearchBar(),
          _buildMainWidget(),
        ],
      ),
    );
  }

  Widget _buildMainWidget() {
    return BlocBuilder(
      bloc: _serviceCardBloc,
      builder: () {
        if (_serviceCardBloc.isLoading) {
          return loadingWidget();
        } else if (_serviceCardBloc.isFailure) {
          return failureWidget();
        } else {
          return successWidget();
        }
      },
    );
  }

  Widget loadingWidget() {
    return Scaffold(
        appBar: OtaAppBar(
          title: getTranslated(
              context, AppLocalizationsStrings.bookTourAndActivities),
        ),
        body: const OTALoadingIndicator());
  }

  Widget failureWidget() {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
            context, AppLocalizationsStrings.bookTourAndActivities),
      ),
      body: OtaDetailErrorWidget(
        height: MediaQuery.of(context).size.height -
            (_kExpandableMaxHeight + _kDetailsBorder),
        onRefresh: () async => await _getLandingScreenData(),
      ),
    );
  }

  Widget successWidget() {
    return Column(
      children: [
        _buildServiceCardWidget(),
        _getBanners(),
        _buildAttractionWidget(),
        _buildRecentPlayList(),
        _buildTourPlaylist(),
        _buildTicketPlayList(),
        const SafeArea(
          child: SizedBox(
            height: kSize8,
          ),
        )
      ],
    );
  }

  Widget _buildSearchBar() {
    return BlocBuilder(
      bloc: _serviceCardBloc,
      builder: () {
        return _serviceCardBloc.isServiceCardAvailable
            ? GestureDetector(
                onTap: () => _goToTourSearchScreen(),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: kSize24,
                    vertical: kSize8,
                  ),
                  height: kSize40,
                  decoration: BoxDecoration(
                    color: AppColors.kGrey4,
                    borderRadius: BorderRadius.circular(kSize8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: kSize14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated(
                              context,
                              AppLocalizationsStrings
                                  .toursTicketsSearchPlaceholder),
                          style: AppTheme.kBodyRegular
                              .copyWith(color: AppColors.kGrey20),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: kSize4),
                      SvgPicture.asset(
                        _kSearchIconPath,
                        height: kSize20,
                        width: kSize20,
                        color: AppColors.kGrey20,
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }

  _goToTourSearchScreen() {
    TourSearchArgumentModel tourSearchArgumentModel = TourSearchArgumentModel(
        attractionList: TourLandingHelper.getAttractionModelList(
            _attractionsBloc.state.tourAtrractionsList));
    Navigator.pushNamed(context, AppRoutes.tourSearchScreen,
        arguments: tourSearchArgumentModel);
  }

  void _openSearchResultScreen(TourAttractionsModel tourAttractionsModel) {
    TourSearchResultArgumentModel argument =
        TourSearchResultArgumentModel(playlistName: PlaylistType.tour.value);
    argument.searchKey = tourAttractionsModel.searchKey;
    argument.cityId = tourAttractionsModel.cityId;
    argument.countryId = tourAttractionsModel.countryId;

    Navigator.pushNamed(context, AppRoutes.tourLoadingScreen,
        arguments: argument);
  }

  Widget _buildServiceCardWidget() {
    return _serviceCardBloc.isServiceCardAvailable
        ? ServiceCardsWidget(
            tourService: _serviceCardBloc.state.tourServiceModel,
            ticketService: _serviceCardBloc.state.ticketServiceModel,
            onTourServicePress: () => _openSearchTourTicketSearchResultsScreen(
                PlaylistType.tour.value),
            onTicketServicePress: () =>
                _openSearchTourTicketSearchResultsScreen(
                    PlaylistType.ticket.value),
          )
        : const SizedBox();
  }

  Widget _titleAttraction() {
    return Padding(
      padding: kPaddingHori24Vert16,
      child: Text(
        getTranslated(context, AppLocalizationsStrings.toursAttractions),
        style: AppTheme.kHeading1Medium,
      ),
    );
  }

  Widget _buildAttractionWidget() {
    return BlocBuilder(
        bloc: _attractionsBloc,
        builder: () {
          if (!_attractionsBloc.isSuccess) {
            return const SizedBox();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleAttraction(),
                SizedBox(
                  height: kSize100,
                  child: ListView.separated(
                    padding: kPaddingHori24,
                    itemCount:
                        _attractionsBloc.state.tourAtrractionsList?.length ?? 0,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      TourAttractionsModel tourAttractionsModel =
                          _attractionsBloc.state.tourAtrractionsList!
                              .elementAt(index);
                      return InkWell(
                        onTap: () {
                          getActivityLocationRecommendationFirebaseEvents(
                              FirebaseEvent.activityLocationRecommendation,
                              tourAttractionsModel);
                          _openSearchResultScreen(tourAttractionsModel);
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(kSize8)),
                              child: CachedNetworkImage(
                                width: kSize100,
                                height: kSize100,
                                imageUrl: tourAttractionsModel.imageUrl ?? "",
                                placeholder: (context, url) =>
                                    _getDefaultImages(),
                                errorWidget: (context, url, error) =>
                                    _getDefaultImages(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: kSize36,
                              width: kSize100,
                              child: Padding(
                                padding: kPaddingAll8,
                                child: Text(
                                  tourAttractionsModel.serviceTitle,
                                  style: AppTheme.kSmallMedium
                                      .copyWith(color: AppColors.kLight100),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: kSize12);
                    },
                  ),
                )
              ],
            );
          }
        });
  }

  Widget _getDefaultImages() {
    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      SvgPicture.asset(
        _kPlaceHolderBanner,
        fit: BoxFit.cover,
      ),
      Container(
        height: kSize36,
        width: kSize100,
        decoration: const BoxDecoration(
          gradient: AppColors.kTransparentGradient,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kSize8),
            bottomRight: Radius.circular(kSize8),
          ),
        ),
      )
    ]);
  }

  Widget _buildTicketPlayList() {
    return BlocBuilder(
      bloc: _ticketPlaylistBloc,
      builder: () {
        return _ticketPlaylistBloc.isPlaylistAvailable
            ? TourTicketPlaylistWidget(
                title: getTranslated(
                    context, AppLocalizationsStrings.recommendedTicket),
                cardList: _ticketPlaylistBloc.state.tourTicketPlaylist!,
                playlistType: PlaylistType.ticket,
                onTitleArrowClick: () =>
                    _openTourTicketPlaylistScreen(PlaylistType.ticket.value),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildTourPlaylist() {
    return BlocBuilder(
      bloc: _tourPlaylistBloc,
      builder: () {
        return _tourPlaylistBloc.isPlaylistAvailable
            ? TourTicketPlaylistWidget(
                title: getTranslated(
                    context, AppLocalizationsStrings.recommendedTours),
                cardList: _tourPlaylistBloc.state.tourTicketPlaylist!,
                playlistType: PlaylistType.tour,
                onTitleArrowClick: () =>
                    _openTourTicketPlaylistScreen(PlaylistType.tour.value),
              )
            : const SizedBox();
      },
    );
  }

  Widget _buildRecentPlayList() {
    return BlocBuilder(
      bloc: _recentPlaylistBloc,
      builder: () {
        return _recentPlaylistBloc.isSuccess &&
                _recentPlaylistBloc.state.listItem.isNotEmpty
            ? TourTicketRecentPlaylistWidget(
                title: getTranslated(
                    context, AppLocalizationsStrings.tourRecentlyViewed),
                cardList: _recentPlaylistBloc.state.listItem,
              )
            : const SizedBox();
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
                  onBannerTap: (index) =>
                      _triggerFirebaseClickParameters(index),
                ),
              )
            : const SizedBox();
      },
    );
  }

  void _triggerFirebaseClickParameters(int index) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: ToursActivityBannerClickFirebase.tourBannerSection,
        value: _kBannerType);
    logger.addIntValue(
        key: ToursActivityBannerClickFirebase.tourBannerSequence,
        value: index + 1);
    logger.addIntValue(
        key: ToursActivityBannerClickFirebase.tourBannerId,
        value: int.tryParse(_bannerBloc.state.data[index].bannerId) ?? 0);
    logger.addKeyValue(
        key: ToursActivityBannerClickFirebase.tourBannerName,
        value: _bannerBloc.state.data[index].imageUrl);
    logger.addKeyValue(
        key: ToursActivityBannerClickFirebase.tourBannerUrl,
        value: _bannerBloc.state.data[index].deepLinkUrl);

    List.generate(_bannerBloc.state.data.length, (i) {
      logger.addKeyValue(
          key: ToursActivityBannerClickFirebase.tourAllBannerIdSequence,
          value: _bannerBloc.state.data.elementAt(i).bannerId);
    });
    logger.addUserLocation();

    logger.publishToSuperApp(FirebaseEvent.toursActivityBanner);
  }

  getActivityLocationRecommendationFirebaseEvents(
      String eventName, TourAttractionsModel tourAttractionsModel) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addUserLocation();
    logger.addKeyValue(
        value: tourAttractionsModel.cityId,
        key: ActivityRecommendedLocationFirebase.recommendlocationId);
    logger.addKeyValue(
        value: tourAttractionsModel.serviceTitle,
        key: ActivityRecommendedLocationFirebase.recommendlocationName);
    logger.addCommaSeparatedList(
        value: _attractionsBloc.state.tourAtrractionsList != null
            ? _attractionsBloc.state.tourAtrractionsList!
                .map((e) => e.cityId)
                .toList()
            : [],
        key:
            ActivityRecommendedLocationFirebase.allRecommendlocationIdSequence);
    logger.publishToSuperApp(eventName);
  }

  void _getTourLandingFirebaseEvents(String eventName) {
    FirebaseLogger logger = FirebaseLogger();
    logger.addCommaSeparatedList(
        value: _attractionsBloc.state.tourAtrractionsList
            ?.map((e) => e.cityId)
            .toList(),
        key: TourLandingPageFirebase.allRecommendLocationIdSequence);
    logger.addUserLocation();
    logger.publishToSuperApp(eventName);
  }

  void _getFirebasePlaylistViewAllDataForTours() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.playlistId,
        value: _tourPlaylistBloc.state.playlistId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.playlistName,
        value: _tourPlaylistBloc.state.playlistName);
  }

  void _getFirebasePlaylistViewAllDataForTickets() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.playlistId,
        value: _ticketPlaylistBloc.state.playlistId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.tourTicketPlaylistViewAll,
        key: TourTicketPlaylistViewAllFirebase.playlistName,
        value: _ticketPlaylistBloc.state.playlistName);
  }

  void _getFirebasePlaylistForTours() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activityPlaylist,
        key: ActivityPlaylistParameters.playlistId,
        value: _tourPlaylistBloc.state.playlistId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activityPlaylist,
        key: ActivityPlaylistParameters.playlistName,
        value: _tourPlaylistBloc.state.playlistName);
  }

  void _getFirebasePlaylistForTickets() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activityPlaylist,
        key: ActivityPlaylistParameters.playlistId,
        value: _ticketPlaylistBloc.state.playlistId);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activityPlaylist,
        key: ActivityPlaylistParameters.playlistName,
        value: _ticketPlaylistBloc.state.playlistName);
  }
}
