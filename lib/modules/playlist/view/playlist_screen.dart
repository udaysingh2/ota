import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/ota/ota_playlist_viewall_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/room_detail_error_widget.dart';
import 'package:ota/modules/playlist/bloc/full_playlist_bloc.dart';
import 'package:ota/modules/playlist/helpers/playlist_helper.dart';
import 'package:ota/modules/playlist/view/widgets/category_list/horizontal_category_list.dart';
import 'package:ota/modules/playlist/view_model/full_playlist_card_view_model.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
import 'package:ota/modules/playlist/view_model/playlist_view_model.dart';

import '../../../core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';

const double _kRemainingPixels = 50.0;
const double _kAppBarHeight = 89;
const String _kSourceStatic = 'static';
const String _kPlaylistSection = "OTA_landing";
const String _kTravelId = '1';
const String _kTravelName = 'hotel';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  PlaylistScreenState createState() => PlaylistScreenState();
}

class PlaylistScreenState extends State<PlaylistScreen> {
  final FullPlaylistBloc _fullPlaylistBloc = FullPlaylistBloc();
  ScrollController? _scrollController;
  final LoginModel _loginModel = getLoginProvider();

  scrollListener() {
    /// Reached at end of list
    if (_scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.position.extentAfter <= _kRemainingPixels) {
      /// If playlist data is loading in progress then return
      if (_fullPlaylistBloc.state.playlistState ==
              PlaylistViewModelState.loading &&
          !_fullPlaylistBloc.isInternetFailurePopupShown) {
        return;
      }
      requestPlaylistData();
    }
  }

  Future<void> requestPlaylistData({bool isPullToRefresh = false}) async {
    PlaylistViewArgument viewArgument =
        ModalRoute.of(context)?.settings.arguments as PlaylistViewArgument;
    return _fullPlaylistBloc.fetchPlaylistData(argument: viewArgument);
  }

  void openHotelDetailScreen(FullPlaylistCardViewModel cardViewModel) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      cardViewModel.hotelId,
      cardViewModel.cityId,
      cardViewModel.countryId,
      _loginModel.userType.getHotelDetailType(),
    );
    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();

    _fullPlaylistBloc.stream.listen(
      (event) {
        if (_fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.internetFailure &&
            !_fullPlaylistBloc.isInternetFailurePopupShown) {
          _fullPlaylistBloc.setInternetFailurePopupShown();
          OtaNoInternetAlertDialog().showAlertDialog(context, onOkClick: () {
            _fullPlaylistBloc.setInternetFailurePopupNotShown();
            Navigator.of(context).pop();
          });
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PlaylistViewArgument viewArgument =
          ModalRoute.of(context)?.settings.arguments as PlaylistViewArgument;
      if (viewArgument.source != _kSourceStatic) {
        _scrollController!.addListener(scrollListener);
      }
      requestPlaylistData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _fullPlaylistBloc,
      builder: () {
        bool isLoading = _fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.loading &&
            _fullPlaylistBloc.state.playlistMap.isEmpty;
        bool isFailure = _fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.failure &&
            _fullPlaylistBloc.state.playlistMap.isEmpty;
        bool isInternetFailure = _fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.internetFailure &&
            _fullPlaylistBloc.state.playlistMap.isEmpty;
        bool isSuccessEmpty = _fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.success &&
            _fullPlaylistBloc.state.playlistMap.isEmpty;
        PlaylistViewArgument viewArgument =
            ModalRoute.of(context)?.settings.arguments as PlaylistViewArgument;
        return Scaffold(
          appBar: OtaAppBar(
            title: (isFailure || isSuccessEmpty)
                ? ''
                : viewArgument.isStatic
                    ? viewArgument.playlistName
                    : getTranslated(
                        context, AppLocalizationsStrings.accommodations),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : (isFailure || isInternetFailure || isSuccessEmpty)
                  ? _buildPullDownErrorWidget(context)
                  : Column(
                      children: [
                        _getCategories(context, viewArgument.isStatic),
                        _buildListView(context),
                      ],
                    ),
        );
      },
    );
  }

  Widget _getCategories(BuildContext context, bool isStatic) {
    if (!isStatic) {
      return const SizedBox();
    }
    List<String> categoryList = _fullPlaylistBloc.getAllCategories();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSize4),
      child: HorizontalCategoryList(
        categories: categoryList,
        selectedCatIndex: _fullPlaylistBloc.getSelectedCatIndex(),
        onCategorySelected: (value) =>
            _fullPlaylistBloc.setSelectedCategory(value),
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    final suggestioList = _fullPlaylistBloc.getPlaylistOfSelectedCategory();
    PlaylistViewArgument viewArgument =
        ModalRoute.of(context)?.settings.arguments as PlaylistViewArgument;

    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        itemCount: suggestioList.length +
            ((viewArgument.source == _kSourceStatic) ? 0 : 1),
        padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize24),
        itemBuilder: (context, index) {
          if (index < suggestioList.length) {
            return _buildOtaSuggestionCard(suggestioList[index]);
          }
          return _buildFooterLoader();
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: kSize24);
        },
      ),
    );
  }

  Widget _buildOtaSuggestionCard(FullPlaylistCardViewModel cardViewModel) {
    return (cardViewModel.headerText.isEmpty || cardViewModel.hotelId.isEmpty)
        ? const SizedBox.shrink()
        : OtaSuggestionCardHorizontalAmenities(
            isInHorizontalScroll: false,
            headerText: cardViewModel.headerText,
            ratingText: cardViewModel.ratingText,
            addressText: cardViewModel.locationName,
            ratingTitle: cardViewModel.ratingTitle,
            reviewText:
                '${cardViewModel.reviewText} ${getTranslated(context, AppLocalizationsStrings.review)}',
            offerPercent: cardViewModel.offerPercent,
            score: cardViewModel.score,
            discount: cardViewModel.discount,
            imageUrl: cardViewModel.imageUrl,
            adminPromotionLine1: cardViewModel.adminPromotionLine1,
            adminPromotionLine2: cardViewModel.adminPromotionLine2,
            amenitiesList: PlaylistHelper.getAmenitiesList(
                cardViewModel.capsulePromotion, cardViewModel.infoPromotion),
            onPress: () {
              _getPlaylistVieWall(cardViewModel);
              openHotelDetailScreen(cardViewModel);
            },
          );
  }

  Widget _buildPullDownErrorWidget(BuildContext context) {
    return RoomDetailErrorWidget(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async => await requestPlaylistData(isPullToRefresh: true),
    );
  }

  Widget _buildFooterLoader() {
    return _fullPlaylistBloc.state.playlistState ==
                PlaylistViewModelState.loading &&
            _fullPlaylistBloc.state.playlistMap.isNotEmpty
        ? const Center(child: CircularProgressIndicator())
        : const SizedBox();
  }

  List<String?>? _getAddAllSequence(
      List<FullPlaylistCardViewModel>? cardPlayList) {
    List<String?>? result;
    if (cardPlayList != null) {
      result = cardPlayList.map((e) => e.hotelId).toList();
    }
    return result;
  }

  void _getPlaylistVieWall(FullPlaylistCardViewModel cardViewModel) {
    PlaylistViewArgument viewArgument =
        ModalRoute.of(context)?.settings.arguments as PlaylistViewArgument;
    FirebaseLogger logger = FirebaseLogger();
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaTravelId, value: _kTravelId);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaTravelName, value: _kTravelName);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistSection,
        value: _kPlaylistSection);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistId,
        value: viewArgument.playlisId);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaPlaylistName,
        value: viewArgument.playlistName);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaHotelId,
        value: cardViewModel.hotelId);
    logger.addKeyValue(
        key: OtaPlayListVieWallFirebase.otaHotelName,
        value: cardViewModel.headerText);
    logger.addCommaSeparatedList(
        key: OtaPlayListVieWallFirebase.otaAllIdSequence,
        value: _getAddAllSequence(
            _fullPlaylistBloc.getPlaylistOfSelectedCategory()));
    logger.addUserLocation();
    logger.publishToSuperApp(FirebaseEvent.otaPlaylistVieWall);
  }
}
