import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_segment.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_search_result_click_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_search_result_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_search_suggestions_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/landing/bloc/tour_attractions_bloc.dart';
import 'package:ota/modules/tours/landing/view_model/tour_attractions_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:ota/modules/tours/tour_search/search/bloc/tour_save_search_history_bloc.dart';
import 'package:ota/modules/tours/tour_search/search/bloc/tour_search_history_bloc.dart';
import 'package:ota/modules/tours/tour_search/search/bloc/tour_search_screen_bloc.dart';
import 'package:ota/modules/tours/tour_search/search/bloc/tour_search_suggestions_bloc.dart';
import 'package:ota/modules/tours/tour_search/search/helper/tour_search_suggestions_helpers.dart';
import 'package:ota/modules/tours/tour_search/search/view/widget/tour_live_list_view_widget.dart';
import 'package:ota/modules/tours/tour_search/search/view/widget/tour_search_suggestions_tile_widget.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_save_search_history_argument_model.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_history_view_model.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_suggestions_view_model.dart';

const int _kDefaultInt = 1;
const int _kDefaultFlex = 0;
const int _kMaxLengthForAll = 5;
const int _kMaxSearchCharacters = 3;
const Duration _kInActiveDuration = Duration(milliseconds: 1000);

const String _kSuggestionTileKey = 'tour_search_suggestion_tile_widget_key';
const _kListAllKey = "all";
const _kListTourKey = "tour";
const _kListTicketKey = "ticket";
const _kListLocationKey = "location";
const _kTourKey = "TOUR";

class TourSearchSuggestionsScreen extends StatefulWidget {
  const TourSearchSuggestionsScreen({Key? key}) : super(key: key);

  @override
  TourSearchSuggestionsScreenState createState() =>
      TourSearchSuggestionsScreenState();
}

class TourSearchSuggestionsScreenState
    extends State<TourSearchSuggestionsScreen> {
  final TourSearchSuggestionBloc _suggestionBloc = TourSearchSuggestionBloc();
  final TourSearchHistoryBloc _searchHistoryBloc = TourSearchHistoryBloc();
  final TourSearchScreenBloc _searchScreenBloc = TourSearchScreenBloc();
  final TourSaveSearchHistoryBloc _saveSearchHistoryBloc =
      TourSaveSearchHistoryBloc();
  final TextEditingController _textFieldController = TextEditingController();
  final LoginModel _loginModel = getLoginProvider();
  final FocusNode _focusNode = FocusNode();
  final TourAttractionsBloc _attractionsBloc = TourAttractionsBloc();
  Timer? _timer;
  String _prevSearchText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchHistoryBloc.fetchTourSearchHistoryData();
      _attractionsBloc.getTourAttractionsData(_kTourKey);
      _searchScreenBloc.setStateRecommendations();
      _textFieldController.addListener(() {
        setState(() {});
      });
    });

    _searchHistoryBloc.stream.listen((event) {
      if (event.recommendationState ==
          TourSearchHistoryViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _suggestionBloc.stream.listen((event) {
      if (event.suggestionsState ==
          TourSearchSuggestionsViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textFieldController.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder(
        bloc: _searchScreenBloc,
        builder: () {
          return Column(
            children: [
              BlocBuilder(
                  bloc: _suggestionBloc,
                  builder: () {
                    return _buildSearchBar();
                  }),
              if (_searchScreenBloc.isStateRecommendations)
                _buildHistoryAndAttractionListWidget(),
              if (_searchScreenBloc.isStateSuggestions)
                _buildSuggestionsSegment(),
            ],
          );
        },
      ),
    );
  }

  OtaAppBar _buildAppBar() {
    return OtaAppBar(
      title: getTranslated(context, AppLocalizationsStrings.toursTicketsSearch),
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.customTrailingWidget
      ],
    );
  }

  Widget _buildSearchBar() {
    return OtaSearchInputWidget(
      searchHintText: getTranslated(
          context, AppLocalizationsStrings.toursTicketsSearchPlaceholder),
      searchTextController: _textFieldController,
      isLoading: _suggestionBloc.state.suggestionsState ==
          TourSearchSuggestionsViewModelState.loading,
      onChanged: (text) => _onSearchTextChange(),
      onCrossButtonTap: _onCrossButtonTap,
      onTextFieldTap: _onSearchFieldTap,
      focusNode: _focusNode,
    );
  }

  Expanded _buildHistoryAndAttractionListWidget() {
    return Expanded(
      child: ListView(
        children: [
          if (_loginModel.isLoggedIn()) const SizedBox(height: kSize8),
          if (_loginModel.isLoggedIn()) _buildSearchHistoryListView(),
          const SizedBox(height: kSize8),
          _buildSearchAttractionListView(),
        ],
      ),
    );
  }

  Widget _buildSuggestionsSegment() {
    return BlocBuilder(
      bloc: _suggestionBloc,
      builder: () {
        bool reloading = _suggestionBloc.state.suggestionsState ==
                TourSearchSuggestionsViewModelState.loading &&
            _suggestionBloc.anySuggestions;
        bool isSuccess = _suggestionBloc.state.suggestionsState ==
                TourSearchSuggestionsViewModelState.success &&
            _suggestionBloc.anySuggestions;
        final destinationSuggestionList = _suggestionBloc.state.location;
        final ticketSuggestionList = _suggestionBloc.state.ticket;
        final tourSuggestionList = _suggestionBloc.state.tour;

        if (isSuccess || reloading) {
          return Expanded(
            child: OtaChipSegment(
              verticalPadding: kSize12,
              mainAxisAlignment: MainAxisAlignment.start,
              onChipSelected: (index) => _suggestionBloc.setIndex(index),
              chipData: [
                ChipData(
                    flex: _kDefaultFlex,
                    title: AppLocalizationsStrings.all,
                    widget: _buildAllSuggestionsListWidget()),
                if (destinationSuggestionList!.isNotEmpty)
                  ChipData(
                      flex: _kDefaultFlex,
                      title: AppLocalizationsStrings.destinations,
                      widget: _buildSuggestionListView(
                          suggestionList: destinationSuggestionList,
                          type: ServiceType.location,
                          key:
                              const PageStorageKey<String>(_kListLocationKey))),
                if (tourSuggestionList!.isNotEmpty)
                  ChipData(
                    flex: _kDefaultFlex,
                    title: AppLocalizationsStrings.tours,
                    widget: _buildSuggestionListView(
                        suggestionList: tourSuggestionList,
                        type: ServiceType.tour,
                        key: const PageStorageKey<String>(_kListTourKey)),
                  ),
                if (ticketSuggestionList!.isNotEmpty)
                  ChipData(
                      flex: _kDefaultFlex,
                      title: AppLocalizationsStrings.tickets,
                      widget: _buildSuggestionListView(
                          suggestionList: ticketSuggestionList,
                          type: ServiceType.ticket,
                          key: const PageStorageKey<String>(_kListTicketKey))),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Expanded _buildAllSuggestionsListWidget() {
    final destinationSuggestionList = _suggestionBloc.state.location;
    final ticketSuggestionList = _suggestionBloc.state.ticket;
    final tourSuggestionList = _suggestionBloc.state.tour;
    return Expanded(
      child: ListView(
        key: const PageStorageKey<String>(_kListAllKey),
        children: [
          const SizedBox(
            height: kSize8,
          ),
          if (destinationSuggestionList!.isNotEmpty)
            _getSuggestionListView(
                suggestionList: destinationSuggestionList,
                type: ServiceType.location),
          if (tourSuggestionList!.isNotEmpty)
            _getSuggestionListView(
                suggestionList: tourSuggestionList, type: ServiceType.tour),
          if (ticketSuggestionList!.isNotEmpty)
            _getSuggestionListView(
                suggestionList: ticketSuggestionList, type: ServiceType.ticket),
        ],
      ),
    );
  }

  Widget _getSuggestionListView(
      {required List suggestionList, required ServiceType type}) {
    return TourLiveListViewWidget(
        suggestionList: suggestionList,
        type: type,
        getTileWidget: (index) {
          return _buildTourSuggestionTileWidget(
              suggestionList[index - _kDefaultInt], type);
        });
  }

  Widget _buildSuggestionListView(
      {required List suggestionList,
      required ServiceType type,
      required Key key}) {
    return Expanded(
      child: ListView.separated(
        key: key,
        padding: const EdgeInsets.only(top: kSize16, bottom: kSize32),
        itemCount: suggestionList.length + _kDefaultInt,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSize24),
              child: Text(
                type == ServiceType.location
                    ? getTranslated(
                        context, AppLocalizationsStrings.destinations)
                    : type == ServiceType.ticket
                        ? getTranslated(
                            context, AppLocalizationsStrings.tickets)
                        : getTranslated(context, AppLocalizationsStrings.tours),
                style: AppTheme.kBodyMedium,
              ),
            );
          }
          return _buildTourSuggestionTileWidget(
              suggestionList[index - _kDefaultInt], type);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: kSize8);
        },
      ),
    );
  }

  Widget _buildTourSuggestionTileWidget(Item suggestion, ServiceType type) {
    return TourSearchSuggestionTileWidget(
      key: const Key(_kSuggestionTileKey),
      title: suggestion.keyword!,
      serviceType: type,
      onSearchSuggestionTap: () {
        _textFieldController.text = suggestion.keyword!;
        _saveSearchHistoryBloc.saveTourSearchHistoryData(
            TourSaveSearchHistoryArgumentModel.from(
                item: suggestion,
                serviceType: TourSearchSuggestionsHelper.getServiceType(type)));
        if (type == ServiceType.location) {
          _openTourLoadingScreen(suggestion.keyword ?? '', suggestion.cityId,
              suggestion.countryId);
        } else if (type == ServiceType.tour) {
          _openTourDetailScreen(
            tourId: suggestion.id ?? '',
            cityId: suggestion.cityId ?? '',
            countryId: suggestion.countryId ?? '',
          );
        } else if (type == ServiceType.ticket) {
          _openTicketDetailScreen(
            ticketId: suggestion.id ?? '',
            cityId: suggestion.cityId ?? '',
            countryId: suggestion.countryId ?? '',
          );
        }
      },
    );
  }

  Widget _buildSearchHistoryListView() {
    return BlocBuilder(
      bloc: _searchHistoryBloc,
      builder: () {
        bool isSuccess = _searchHistoryBloc.state.recommendationState ==
            TourSearchHistoryViewModelState.success;
        if (isSuccess && !_searchHistoryBloc.isSearchHistoryEmpty) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _searchHistoryBloc.state.searchHistoryList.length <=
                    _kMaxLengthForAll
                ? _searchHistoryBloc.state.searchHistoryList.length +
                    _kDefaultInt
                : _kMaxLengthForAll + _kDefaultInt,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSize24, vertical: kSize8),
                  child: Text(
                    getTranslated(
                        context, AppLocalizationsStrings.recentSearchTerms),
                    style: AppTheme.kBodyMedium,
                  ),
                );
              }
              final historyItem = _searchHistoryBloc
                  .state.searchHistoryList[index - _kDefaultInt];
              return OtaSearchHistoryTileWidget(
                title: historyItem.keyword ?? '',
                onTap: () {
                  _textFieldController.text = historyItem.keyword ?? '';
                  String serviceType =
                      historyItem.serviceType?.toLowerCase() ?? '';
                  if (serviceType == PlaylistType.location.value) {
                    _openTourLoadingScreen(historyItem.keyword ?? '',
                        historyItem.cityId, historyItem.countryId);
                  } else if (serviceType == PlaylistType.tour.value) {
                    _openTourDetailScreen(
                      tourId: historyItem.placeId ?? '',
                      cityId: historyItem.cityId ?? '',
                      countryId: historyItem.countryId ?? '',
                    );
                  } else if (serviceType == PlaylistType.ticket.value) {
                    _openTicketDetailScreen(
                      ticketId: historyItem.placeId ?? '',
                      cityId: historyItem.cityId ?? '',
                      countryId: historyItem.countryId ?? '',
                    );
                  }
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSearchAttractionListView() {
    return BlocBuilder(
        bloc: _attractionsBloc,
        builder: () {
          if (_attractionsBloc.state.pageState !=
              TourAttractionsPageState.success) {
            return const SizedBox();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _attractionsBloc.state.tourAtrractionsList!.length +
                _kDefaultInt,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSize24, vertical: kSize8),
                  child: Text(
                    getTranslated(
                        context, AppLocalizationsStrings.recommendedOtaTitle),
                    style: AppTheme.kBodyMedium,
                  ),
                );
              }
              final attractionItem = _attractionsBloc.state.tourAtrractionsList!
                  .elementAt(index - _kDefaultInt);

              return OtaRecommendationTileWidget(
                title: attractionItem.serviceTitle,
                imageUrl: attractionItem.imageUrl ?? '',
                onRecommendationTap: () {
                  _textFieldController.text = attractionItem.serviceTitle;
                  _openTourLoadingScreen(attractionItem.searchKey,
                      attractionItem.cityId, attractionItem.countryId);
                },
              );
            },
          );
        });
  }

  void _openTourDetailScreen(
      {required String tourId,
      required String cityId,
      required String countryId}) {
    TourDetailArgument tourDetailArgument = TourDetailArgument(
      userType: _loginModel.isLoggedIn()
          ? TourDetailUserType.loggedInUser
          : TourDetailUserType.guestUser,
      tourId: tourId,
      cityId: cityId,
      countryId: countryId,
    );
    Navigator.pushNamed(
      context,
      AppRoutes.tourDetailScreen,
      arguments: tourDetailArgument,
    );
  }

  void _openTicketDetailScreen(
      {required String ticketId,
      required String cityId,
      required String countryId}) {
    TicketDetailArgument ticketDetailArgument = TicketDetailArgument(
      userType: _loginModel.isLoggedIn()
          ? TicketDetailUserType.loggedInUser
          : TicketDetailUserType.guestUser,
      ticketId: ticketId,
      cityId: cityId,
      countryId: countryId,
    );
    Navigator.pushNamed(
      context,
      AppRoutes.ticketDetailScreen,
      arguments: ticketDetailArgument,
    );
  }

  void _openTourLoadingScreen(
      String searchText, String? cityId, String? countryId) {
    TourSearchResultArgumentModel argument =
        TourSearchResultArgumentModel(playlistName: PlaylistType.tour.value);
    argument.searchKey = searchText;
    argument.cityId = cityId;
    argument.countryId = countryId;

    Navigator.pushNamed(context, AppRoutes.tourLoadingScreen,
        arguments: argument);
  }

  void _cancelTimer() {
    if (_timer != null) _timer?.cancel();
  }

  _onCrossButtonTap() {
    _textFieldController.clear();
    _suggestionBloc.clearSuggestions();

    if (_searchScreenBloc.isStateSuggestions) {
      _searchScreenBloc.setStateRecommendations();
    }
  }

  _onSearchFieldTap() {
    if (_searchScreenBloc.isStateNone) {
      _searchScreenBloc.setStateRecommendations();
    }
  }

  _onSearchTextChange() {
    final String searchText = _textFieldController.text.trim();

    /// To avoid calls on soft keyboard dismiss rebuild widget
    if (searchText != _prevSearchText) {
      _prevSearchText = searchText;

      if (searchText.isEmpty) {
        _searchScreenBloc.setStateRecommendations();
        _suggestionBloc.clearSuggestions();
      } else {
        _searchScreenBloc.setStateSuggestions();
      }
      if (searchText.length >= _kMaxSearchCharacters) {
        /// Cancel timer if already running
        _cancelTimer();

        /// Start new timer
        _timer = Timer(_kInActiveDuration, () {
          _requestSuggestionData();
          triggerFirebaseEvent();
          _getSearchResultFirebaseData();
        });
      } else {
        _cancelTimer();
      }
    }
  }

  void _requestSuggestionData() {
    return _suggestionBloc
        .fetchSuggestionData(_textFieldController.text.trim());
  }

  void triggerFirebaseEvent() {
    FirebaseLogger logger = FirebaseLogger();

    logger.addKeyValue(
        key: ToursSearchSuggestionsFirebase.tourActivityKeywordSearch,
        value: _textFieldController.text.trim());

    logger.addUserLocation();

    logger.addIntValue(
        key: ToursSearchSuggestionsFirebase.tourActivitySearchSuccess,
        value: _suggestionBloc.anySuggestions ? _kDefaultInt : _kDefaultFlex);

    logger.publishToSuperApp(FirebaseEvent.toursActivitySearchInput);
  }

  void _getSearchResultFirebaseData() {
    TourSearchResultFirebase.searchKeyText = _textFieldController.text.trim();
    TourSearchResultClickFirebase.searchKeyText =
        _textFieldController.text.trim();
  }
}
