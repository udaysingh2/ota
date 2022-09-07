import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_search_input_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/search/filters/helpers/filter_helper.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/hotel/bloc/hotel_recommendation_bloc.dart';
import 'package:ota/modules/search/hotel/bloc/hotel_search_screen_bloc.dart';
import 'package:ota/modules/search/hotel/bloc/hotel_suggestion_bloc.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_suggestion_view_model.dart';

const double _kRemainingPixels = 50.0;
const int _kMaxSearchCharacters = 3;
const Duration _kInActiveDuration = Duration(milliseconds: 1000);

const String _kSuggestionTileKey = 'ota_suggestion_tile_widget_key';
const String _kRecommendationTileKey = 'ota_recommendation_tile_widget_key';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({Key? key}) : super(key: key);

  @override
  HotelSearchScreenState createState() => HotelSearchScreenState();
}

class HotelSearchScreenState extends State<HotelSearchScreen> {
  final HotelSuggestionBloc _suggestionBloc = HotelSuggestionBloc();
  final HotelRecommendationBloc _recommendationBloc = HotelRecommendationBloc();
  final HotelSearchScreenBloc _searchScreenBloc = HotelSearchScreenBloc();
  final TextEditingController _textFieldController = TextEditingController();
  final ScrollController _recommendationScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;
  String _prevSearchText = '';
  FilterArgument? _filterArgument;
  final LoginModel _loginModel = getLoginProvider();

  HotelSuggestionBloc get suggestionBloc => _suggestionBloc;

  HotelRecommendationBloc get recommendationBloc => _recommendationBloc;

  HotelSearchScreenBloc get searchScreenBloc => _searchScreenBloc;

  TextEditingController get textFieldController => _textFieldController;

  LoginModel get loginModel => _loginModel;

  recommendedScrollListener() {
    /// Reached at end of list
    if (_recommendationScrollController.hasClients &&
        _recommendationScrollController.position.extentAfter <=
            _kRemainingPixels) {
      /// If suggestion data is loading in progress then return
      if (_recommendationBloc.state.recommendationState ==
          HotelRecommendationViewModelState.loading) {
        return;
      }
      _recommendationBloc.fetchMoreRecommendationsData();
    }
  }

  void _requestSuggestionData() {
    return _suggestionBloc
        .fetchSuggestionData(_textFieldController.text.trim());
  }

  SuggestionTileType _getSuggestionTileType(
      SearchSuggestionType suggestionType) {
    return suggestionType == SearchSuggestionType.hotel
        ? SuggestionTileType.hotelSuggestion
        : SuggestionTileType.locationSuggestion;
  }

  void _openHotelDetailScreen(HotelRecommendationModel? recommendationModel) {
    final hotelArgument = HotelDetailArgument.getDefaultArgumentForChannel(
      recommendationModel?.hotelId,
      recommendationModel?.cityId,
      recommendationModel?.countryId,
      _loginModel.userType.getHotelDetailType(),
    );
    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  void _popScreen(
      {HotelSuggestionModel? suggestionModel,
      HotelSearchHistoryModel? searchHistoryModel,
      bool isSuggestion = true}) async {
    final hotelArgument = HotelDetailArgument.getHotelDetailArgument(
        isSuggestion
            ? suggestionModel?.hotelId ?? ''
            : searchHistoryModel?.hotelId ?? '',
        isSuggestion
            ? suggestionModel?.cityId ?? ''
            : searchHistoryModel?.cityId ?? '',
        isSuggestion
            ? suggestionModel?.countryId ?? ''
            : searchHistoryModel?.countryId ?? '',
        _filterArgument?.checkInDate,
        _filterArgument?.checkOutDate,
        FilterHelper.getHotelArgumentRoomList(_filterArgument?.roomList),
        _loginModel.userType.getHotelDetailType());

    _filterArgument = FilterArgument.fromHotelDetailArguments(
      hotelArgument,
      name: isSuggestion ? suggestionModel?.name : searchHistoryModel?.keyword,
      locationId: isSuggestion
          ? suggestionModel?.locationId
          : searchHistoryModel?.locationId,
    );
    if (isSuggestion) {
      HotelSearchInputParameters.hotelDestination =
          suggestionModel?.hotelId != null ? "" : suggestionModel?.name ?? "";
    } else {
      HotelSearchInputParameters.hotelDestination =
          searchHistoryModel?.hotelId != null &&
                  searchHistoryModel?.hotelId != ""
              ? ""
              : searchHistoryModel?.keyword ?? "";
    }

    Navigator.of(context).pop(_filterArgument);
  }

  void _cancelTimer() {
    if (_timer != null) _timer?.cancel();
  }

  onCrossButtonTap() {
    _textFieldController.clear();
    _suggestionBloc.clearSuggestions();

    if (_searchScreenBloc.isStateSuggestions) {
      _searchScreenBloc.setStateRecommendations();
    }
  }

  onSearchFieldTap() {
    if (_searchScreenBloc.isStateNone) {
      _searchScreenBloc.setStateRecommendations();
    }
  }

  onSearchTextChange() {
    final String searchText = _textFieldController.text.trim();
    printDebug('-->$searchText - ${searchText.length}');

    /// To avoid calls on softkeyboard dismiss rebuild widget
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
          printDebug('-->1sec inactivity - request search suggestions');
          _requestSuggestionData();
        });
      } else {
        _cancelTimer();
      }
    }
  }

  @override
  void dispose() {
    _recommendationScrollController.dispose();
    _focusNode.dispose();
    _textFieldController.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _recommendationBloc.getUserLocationFromChannel(_loginModel);
    _recommendationScrollController.addListener(recommendedScrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSearchFieldTap();
    });

    _recommendationBloc.stream.listen((event) {
      if (event.recommendationState ==
          HotelRecommendationViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _suggestionBloc.stream.listen((event) {
      if (event.suggestionState ==
          HotelSuggestionViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.selectLocation),
      ),
      body: BlocBuilder(
          bloc: _searchScreenBloc,
          builder: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder(
                  bloc: _suggestionBloc,
                  builder: () {
                    return OtaSearchInputWidget(
                      searchHintText: getTranslated(
                          context,
                          AppLocalizationsStrings
                              .hotelLandingSearchPlaceholder),
                      searchTextController: _textFieldController,
                      isLoading: _suggestionBloc.state.suggestionState ==
                          HotelSuggestionViewModelState.loading,
                      onChanged: (text) => onSearchTextChange(),
                      onCrossButtonTap: onCrossButtonTap,
                      onTextFieldTap: onSearchFieldTap,
                      focusNode: _focusNode,
                    );
                  },
                ),
                if (_searchScreenBloc.isStateRecommendations)
                  _buildHistoryAndRecommendationsListWidget(),
                if (_searchScreenBloc.isStateSuggestions)
                  _buildSuggestionListView(context),
              ],
            );
          }),
    );
  }

  Expanded _buildHistoryAndRecommendationsListWidget() {
    return Expanded(
      child: BlocBuilder(
        bloc: _recommendationBloc,
        builder: () {
          return ListView(
            controller: _recommendationScrollController,
            children: [
              if (_loginModel.isLoggedIn() &&
                  _searchScreenBloc.isStateRecommendations &&
                  !_recommendationBloc.isSearchHistoryEmpty)
                _buildSearchRecommendationHistoryTitle(
                    AppLocalizationsStrings.recentSearchItems),
              if (_loginModel.isLoggedIn() &&
                  _searchScreenBloc.isStateRecommendations)
                _buildSearchHistoryListView(),
              if (_searchScreenBloc.isStateRecommendations &&
                  !_recommendationBloc.isRecommendationsEmpty)
                _buildSearchRecommendationHistoryTitle(
                    AppLocalizationsStrings.recommendedHotelTitle),
              if (_searchScreenBloc.isStateRecommendations)
                _buildRecommendationListView(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSuggestionListView(BuildContext context) {
    return BlocBuilder(
      bloc: _suggestionBloc,
      builder: () {
        if (_suggestionBloc.isLazyLoading || _suggestionBloc.isSuccess) {
          final suggestionList = _suggestionBloc.state.suggestionList;
          return Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: kSize8),
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                printDebug("========$index=========");
                if (index < suggestionList.length) {
                  return _buildOtaSuggestionTileWidget(suggestionList[index]);
                }
                return _buildFooterLoader();
              },
              separatorBuilder: (_, __) => const SizedBox(height: kSize8),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildRecommendationListView() {
    return BlocBuilder(
      bloc: _recommendationBloc,
      builder: () {
        if (_recommendationBloc.isLazyLoading ||
            _recommendationBloc.isSuccess) {
          final recommendationList =
              _recommendationBloc.state.recommendationList;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendationList.length,
            itemBuilder: (context, index) {
              return OtaRecommendationTileWidget(
                key: const Key(_kRecommendationTileKey),
                title: recommendationList[index].serviceTitle,
                imageUrl: recommendationList[index].imageUrl,
                onRecommendationTap: () =>
                    _openHotelDetailScreen(recommendationList[index]),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildOtaSuggestionTileWidget(HotelSuggestionModel suggestion) {
    return OtaSuggestionTileWidget(
      key: const Key(_kSuggestionTileKey),
      title: suggestion.name,
      searchTileType: _getSuggestionTileType(suggestion.searchSuggestionType),
      onSearchSuggestionTap: () {
        _textFieldController.text = suggestion.name;
        _popScreen(suggestionModel: suggestion);
      },
    );
  }

  Widget _buildSearchRecommendationHistoryTitle(String titleKey) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize8),
      child:
          Text(getTranslated(context, titleKey), style: AppTheme.kBodyMedium),
    );
  }

  Widget _buildSearchHistoryListView() {
    return BlocBuilder(
      bloc: _recommendationBloc,
      builder: () {
        if (_recommendationBloc.isLazyLoading ||
            _recommendationBloc.isSuccess) {
          final searchHistoryList = _recommendationBloc.state.searchHistoryList;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchHistoryList.length,
            itemBuilder: (context, index) {
              return OtaSearchHistoryTileWidget(
                key: const Key(_kRecommendationTileKey),
                title: searchHistoryList[index].keyword,
                onTap: () {
                  _textFieldController.text = searchHistoryList[index].keyword;
                  _popScreen(
                    searchHistoryModel: searchHistoryList[index],
                    isSuggestion: false,
                  );
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFooterLoader() {
    return _suggestionBloc.state.suggestionState ==
                HotelSuggestionViewModelState.loading &&
            _suggestionBloc.state.suggestionList.isNotEmpty
        ? const Center(child: CircularProgressIndicator())
        : const SizedBox();
  }
}
