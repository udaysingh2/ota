import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_result_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_landing/bloc/car_landing_bloc.dart';
import 'package:ota/modules/car_rental/car_landing/view_model/car_landing_view_model.dart';
import 'package:ota/modules/car_rental/car_search_history/bloc/car_save_search_history_bloc.dart';
import 'package:ota/modules/car_rental/car_search_history/bloc/car_search_history_bloc.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_search_history_view_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_recommendation_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_suggestion_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/bloc/car_search_suggestion_screen_bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_live_list_view_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_network_error_widget_with_refresh.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_input_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view/widget/car_search_suggestion_tile_widget.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_suggestion_model.dart';

import '../../../../common/utils/consts.dart';

const _kListAllKey = "all";
const int _kDefaultInt = 1;
const _kTopHeight = 180;
const int _kMaxLengthForAll = 5;

const String _kSuggestionTileKey = 'car_search_suggestion_tile_widget_key';
const String _kServiceTypeCar = 'CARRENTAL';

const int _kMaxSearchCharacters = 3;
const Duration _kInActiveDuration = Duration(milliseconds: 1000);

class CarSearchSuggestionScreen extends StatefulWidget {
  const CarSearchSuggestionScreen({Key? key}) : super(key: key);

  @override
  State<CarSearchSuggestionScreen> createState() =>
      _CarSearchSuggestionScreenState();
}

class _CarSearchSuggestionScreenState extends State<CarSearchSuggestionScreen> {
  final CarSearchSuggestionBloc _suggestionBloc = CarSearchSuggestionBloc();
  final CarSearchSuggestionScreenBloc _searchScreenBloc =
      CarSearchSuggestionScreenBloc();
  final CarSearchHistoryBloc _searchHistoryBloc = CarSearchHistoryBloc();
  final LoginModel _loginModel = getLoginProvider();
  final CarRecommendedLocationBloc _carRecommendedLocationBloc =
      CarRecommendedLocationBloc();
  final CarSaveSearchHistoryBloc _saveSearchHistoryBloc =
      CarSaveSearchHistoryBloc();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textFieldController = TextEditingController();
  String _prevSearchText = '';
  Timer? _timer;

  late CarLandingBloc _carLandingBloc;
  bool _isPickUpLocationUpdate = true;
  bool _isLanding = true;

  @override
  void initState() {
    _suggestionBloc.stream.listen((event) {
      if (_suggestionBloc.state.suggestionsState ==
          CarSearchSuggestionsViewModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _carRecommendedLocationBloc.stream.listen((event) {
      if (_carRecommendedLocationBloc.state.recommendationsState ==
          CarRecommendedLocationModelState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    super.initState();
    _searchHistoryBloc.fetchCarSearchHistoryData();
    _carRecommendedLocationBloc.getCarRecommendations(_kServiceTypeCar);
    _focusNode.requestFocus();
    _onSearchFieldTap();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textFieldController.dispose();
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() {
    if (_timer != null) _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _carLandingBloc = (ModalRoute.of(context)?.settings.arguments as List)[0];
    _isPickUpLocationUpdate =
        (ModalRoute.of(context)?.settings.arguments as List)[1];
    _isLanding = (ModalRoute.of(context)?.settings.arguments as List)[2];

    return GestureDetector(
      onTap: _focusNode.unfocus,
      child: Scaffold(
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
                  _buildHistoryAndRecommendationListWidget(),
                if (_searchScreenBloc.isStateSuggestions)
                  _buildSuggestionsSegment(),
              ],
            );
          },
        ),
      ),
    );
  }

  OtaAppBar _buildAppBar() {
    return OtaAppBar(
      title:
          getTranslated(context, AppLocalizationsStrings.pickUpAndDropOffPoint),
      actions: const [
        OtaAppBarAction.backButton,
        OtaAppBarAction.customTrailingWidget
      ],
    );
  }

  Widget _buildSearchBar() {
    return CarSearchInputWidget(
      searchHintText: getTranslated(
          context, AppLocalizationsStrings.searchPickUpAndDropOffPoint),
      searchTextController: _textFieldController,
      isLoading: _suggestionBloc.state.suggestionsState ==
          CarSearchSuggestionsViewModelState.loading,
      onChanged: (text) => _onSearchTextChange(text),
      onCrossButtonTap: _onCrossButtonTap,
      onTextFieldTap: _onSearchFieldTap,
      focusNode: _focusNode,
    );
  }

  Expanded _buildHistoryAndRecommendationListWidget() {
    return Expanded(
      child: ListView(
        children: [
          if (_loginModel.isLoggedIn()) const SizedBox(height: kSize8),
          if (_loginModel.isLoggedIn()) _buildSearchHistoryListView(),
          const SizedBox(height: kSize8),
          _buildRecommendationListView(),
        ],
      ),
    );
  }

  _onSearchTextChange(String text) {
    final String searchText = text.trim();

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
        });
      } else {
        _cancelTimer();
      }
    }
  }

  Future<void> _requestSuggestionData() {
    return _suggestionBloc
        .fetchSuggestionData(_textFieldController.text.trim());
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

  Widget _buildSuggestionsSegment() {
    return BlocBuilder(
      bloc: _suggestionBloc,
      builder: () {
        bool reloading = _suggestionBloc.state.suggestionsState ==
                CarSearchSuggestionsViewModelState.loading &&
            _suggestionBloc.anySuggestions;
        bool isSuccess = _suggestionBloc.state.suggestionsState ==
                CarSearchSuggestionsViewModelState.success &&
            _suggestionBloc.anySuggestions;
        bool isFailure = _suggestionBloc.state.suggestionsState ==
                CarSearchSuggestionsViewModelState.failure ||
            _suggestionBloc.state.suggestionsState ==
                CarSearchSuggestionsViewModelState.failureNetwork;
        if (isSuccess || reloading) {
          return _buildAllSuggestionsListWidget();
        } else if (_textFieldController.text.isEmpty) {
          return const SizedBox();
        } else if (isFailure) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: kSize24),
              child: Material(
                child: CarNetworkErrorWidgetWithRefresh(
                  errorTextFooter: getTranslated(
                      context, AppLocalizationsStrings.carSearchErrorText),
                  height: MediaQuery.of(context).size.height - _kTopHeight,
                  onRefresh: () => _onRefresh(),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Future<void> _onRefresh() async {
    await _suggestionBloc.fetchSuggestionData(_textFieldController.text.trim());
  }

  Expanded _buildAllSuggestionsListWidget() {
    final cityLocationSuggestionList = _suggestionBloc.state.city;
    final locationSuggestionList = _suggestionBloc.state.location;

    return Expanded(
      child: ListView(
        key: const PageStorageKey<String>(_kListAllKey),
        children: [
          const SizedBox(
            height: kSize8,
          ),
          if (locationSuggestionList!.isNotEmpty)
            _getSuggestionListView(
                suggestionList: locationSuggestionList,
                type: ServiceType.location),
          if (cityLocationSuggestionList!.isNotEmpty)
            _getCarSuggestionListView(
                suggestionList: cityLocationSuggestionList,
                type: ServiceType.city),
        ],
      ),
    );
  }

  Widget _getSuggestionListView(
      {required List suggestionList, required ServiceType type}) {
    return CarLiveListViewWidget(
        suggestionList: suggestionList,
        type: type,
        getTileWidget: (index) {
          return _buildCarSuggestionTileWidget(
              suggestionList[index - _kDefaultInt], type);
        });
  }

  Widget _getCarSuggestionListView(
      {required List suggestionList, required ServiceType type}) {
    return CarLiveListViewWidget(
        suggestionList: suggestionList,
        type: type,
        getTileWidget: (index) {
          return _buildCarCitySuggestionTileWidget(
              suggestionList[index - _kDefaultInt], type);
        });
  }

  Widget _buildCarSuggestionTileWidget(Item suggestion, ServiceType type) {
    return CarSearchSuggestionTileWidget(
      key: const Key(_kSuggestionTileKey),
      title: suggestion.locationName?.trim() ?? '',
      serviceType: type,
      onSearchSuggestionTap: () {
        CarSearchResultFirebase.searchKey = _textFieldController.text.trim();
        _textFieldController.text = suggestion.locationName ?? '';
        _saveSearchHistoryBloc.saveCarSearchHistoryData(
          CarSaveSearchHistoryViewArgumentModel.from(
            item: suggestion,
            serviceType: CarSearchSuggestionsHelper.getServiceType(type),
          ),
        );
        Navigator.pop(
          context,
          LocationModel(
            location: suggestion.locationName,
            locationId: suggestion.id,
          ),
        );
      },
    );
  }

  Widget _buildCarCitySuggestionTileWidget(
      CityItem suggestion, ServiceType type) {
    String searchText = "";
    return CarSearchSuggestionTileWidget(
      key: const Key(_kSuggestionTileKey),
      title: suggestion.cityName?.trim() ?? '',
      serviceType: type,
      onSearchSuggestionTap: () {
        CarSearchResultFirebase.searchKey = _textFieldController.text.trim();
        searchText = _textFieldController.text.trim();
        _textFieldController.text = suggestion.cityName ?? '';
        Navigator.pushNamed(context, AppRoutes.carSearchPickUpPointsScreen,
            arguments: CarSearchArgumentModel(
                carLandingBloc: _carLandingBloc,
                cityId: suggestion.cityId ?? "",
                locationList: _suggestionBloc.state.location,
                isPickUpUpdate: _isPickUpLocationUpdate,
                locationName: suggestion.cityName ?? '',
                isLanding: _isLanding,
                searchText: searchText));
      },
    );
  }

  Widget _buildSearchHistoryListView() {
    return BlocBuilder(
        bloc: _searchHistoryBloc,
        builder: () {
          bool isSuccess = _searchHistoryBloc.state.recommendationState ==
              CarSearchHistoryViewModelState.success;
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
                            context, AppLocalizationsStrings.recentSearchItems),
                        style: AppTheme.kBodyMedium),
                  );
                }
                final historyItem = _searchHistoryBloc
                    .state.searchHistoryList[index - _kDefaultInt];
                return OtaSearchHistoryTileWidget(
                  isCarRental: false,
                  title: historyItem.keyword?.trim() ?? '',
                  onTap: () {
                    CarSearchResultFirebase.searchKey =
                        _textFieldController.text.trim();
                    _textFieldController.text = historyItem.keyword ?? '';
                    Navigator.pop(
                      context,
                      LocationModel(
                        location: historyItem.keyword,
                        locationId: historyItem.placeId,
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        });
  }

  Widget _buildPopularListTitle() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize8),
      child: Text(
        getTranslated(
            context, AppLocalizationsStrings.recommendedCarRentalAreas),
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildRecommendationListView() {
    return BlocBuilder(
      bloc: _carRecommendedLocationBloc,
      builder: () {
        bool isSuccess =
            _carRecommendedLocationBloc.state.recommendationsState ==
                CarRecommendedLocationModelState.success;
        if (isSuccess) {
          final recommendationList =
              _carRecommendedLocationBloc.state.recommendedLocationList;

          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_carRecommendedLocationBloc
                    .state.recommendedLocationList.isNotEmpty)
                  _buildPopularListTitle(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendationList.length,
                  itemBuilder: (context, index) {
                    return OtaRecommendationTileWidget(
                        isCarRental: false,
                        key: const Key("_kRecommendationTileKey"),
                        title: recommendationList[index].searchKey.trim(),
                        imageUrl: recommendationList[index].imageUrl!,
                        onRecommendationTap: () {
                          CarSearchResultFirebase.searchKey =
                              _textFieldController.text.trim();
                          Navigator.pushNamed(
                              context, AppRoutes.carSearchPickUpPointsScreen,
                              arguments: CarSearchArgumentModel(
                                  carLandingBloc: _carLandingBloc,
                                  cityId: recommendationList[index].cityId,
                                  locationList: _suggestionBloc.state.location,
                                  isPickUpUpdate: _isPickUpLocationUpdate,
                                  locationName:
                                      recommendationList[index].searchKey,
                                  isLanding: _isLanding));
                        });
                  },
                ),
              ]);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
