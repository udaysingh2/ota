import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_recommendation_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_history_tile_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_input_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_suggestion_tile_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/domain/static_playlist/models/static_playlist_argument_domain.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view_model/car_rental_vertical_argument_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/playlist/view_model/ota_vertical_playlist_view_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/helpers/ota_search_util.dart';
import 'package:ota/modules/search/hotel/helpers/search_suggestion_type.dart';
import 'package:ota/modules/search/ota/bloc/ota_recommendation_bloc.dart';
import 'package:ota/modules/search/ota/bloc/ota_search_bloc.dart';
import 'package:ota/modules/search/ota/bloc/ota_search_screen_bloc.dart';
import 'package:ota/modules/search/ota/bloc/ota_suggestion_bloc.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_tna_playlist_widget.dart';
import 'package:ota/modules/search/ota/view/widgets/otasearch_car_list_widget.dart';
import 'package:ota/modules/search/ota/view/widgets/otasearch_hotel_list_widget.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_state_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_argument.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_suggestion_view_model.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_config.dart';
import '../../../../domain/search/models/ota_search_model.dart';
import '../../../car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import '../view_model/ota_search_state_model.dart';
import '../view_model/ota_search_view_model.dart';

const double _kRemainingPixels = 50.0;
const int _kMaxSearchCharacters = 3;
const Duration _kInActiveDuration = Duration(milliseconds: 1000);
const kErrorWidgetHeight = 250;
const int _kPageSize = 20;
const int _kPageNumber = 1;
const _kTopHeight = 200;
const _kDefaultHours = 10;
const String _kStatic = 'static';
String defaultTime = "10:00:00";
const String _kTourKey = "tour_key";
const String _kCarKey = "car_key";
const Duration _kDurationT1 = Duration(days: 1);
const Duration _kDurationT4 = Duration(days: 4);

class OtaSearchScreen extends StatefulWidget {
  const OtaSearchScreen({Key? key}) : super(key: key);

  @override
  OtaSearchScreenState createState() => OtaSearchScreenState();
}

class OtaSearchScreenState extends State<OtaSearchScreen> {
  final OtaSuggestionBloc _suggestionBloc = OtaSuggestionBloc();
  final OtaSearchBloc _otaSearchBloc = OtaSearchBloc();
  final OtaRecommendationBloc _recommendationBloc = OtaRecommendationBloc();
  final OtaSearchScreenBloc _searchScreenBloc = OtaSearchScreenBloc();
  final TextEditingController _textFieldController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final LoginModel _loginModel = getLoginProvider();
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;
  OtaSuggestionModel? _suggestionModel;
  OtaSearchHistoryModel? _searchHistoryModel;
  dynamic _filterArgument;
  String _prevSearchText = '';
  OtaSearchUtil? _otaSearchUtil;
  bool isFromSearchLocation = false;

  OtaSuggestionBloc get suggestionBloc => _suggestionBloc;

  OtaRecommendationBloc get recommendationBloc => _recommendationBloc;

  OtaSearchBloc get otaSearchBloc => _otaSearchBloc;

  OtaSearchScreenBloc get searchScreenBloc => _searchScreenBloc;

  TextEditingController get textFieldController => _textFieldController;

  scrollListener() {
    /// Reached at end of list
    if (_scrollController.hasClients &&
        _scrollController.position.extentAfter <= _kRemainingPixels) {
      /// If suggestion data is loading in progress then return
      if (_suggestionBloc.state.suggestionState ==
          OtaSuggestionViewModelState.loading) {
        return;
      }
      _requestSuggestionData(isLazyLoad: true);
    }
  }

  void _requestSuggestionData({bool isLazyLoad = false}) {
    return _suggestionBloc.fetchSuggestionData(_textFieldController.text.trim(),
        isLazyLoad: false);
  }

  SuggestionTileType _getSuggestionTileType(
      SearchSuggestionType suggestionType) {
    return suggestionType == SearchSuggestionType.hotel
        ? SuggestionTileType.hotelSuggestion
        : SuggestionTileType.locationSuggestion;
  }

  void _openFullPlaylistScreen(OtaRecommendationModel? recommendationModel) {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    final argument = OtaVerticalPlaylistViewArgument.fromPlaylistDataArguments(
        StaticPlaylistArgumentDomain.getDefaultArguments(
            userId: loginModel.userId,
            source: _kStatic,
            id: recommendationModel!.playListId!,
            enabledServices: AppConfig().configModel.otaSearchServicesEnabled),
        recommendationModel.serviceTitle);
    Navigator.pushNamed(context, AppRoutes.otaVerticalPlaylistScreen,
        arguments: argument);
  }

  void _cancelTimer() {
    if (_timer != null) _timer?.cancel();
  }

  onBackButtonTap() {
    isFromSearchLocation = false;
    _textFieldController.clear();
    _suggestionBloc.clearSuggestions();
    _recommendationBloc.clearRecommendations();
    _searchScreenBloc.setStateNone();
    _recommendationBloc.fetchRecommendationData();
    _suggestionModel = null;
    _searchHistoryModel = null;
    onSearchFieldTap();
  }

  onCrossButtonTap() {
    if (_searchScreenBloc.isStateResults) {
      onBackButtonTap();
      return;
    }
    isFromSearchLocation = false;
    _textFieldController.clear();
    _suggestionBloc.clearSuggestions();

    if (_searchScreenBloc.isStateSuggestions ||
        _searchScreenBloc.isStateResults) {
      _searchScreenBloc.setStateRecommendations();
    }
    _suggestionModel = null;
    _searchHistoryModel = null;
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
      } else if (searchText.isNotEmpty && !_searchScreenBloc.isStateResults) {
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
    _scrollController.dispose();
    _textFieldController.dispose();
    _focusNode.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _recommendationBloc.fetchRecommendationData();
    _scrollController.addListener(scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      onSearchFieldTap();
      var previousSearchText = ModalRoute.of(context)?.settings.arguments;
      if (previousSearchText is String) {
        _textFieldController.text = previousSearchText;
        onSearchTextChange();
      }
    });
    _otaSearchBloc.stream.listen(
      (event) {
        if (_otaSearchBloc.state.pageState ==
            OtaSearchViewPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      },
    );
    _recommendationBloc.stream.listen((event) {
      if (event.recommendationState ==
          OtaRecommendationViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _suggestionBloc.stream.listen((event) {
      if (event.suggestionState ==
          OtaSuggestionViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: _focusNode.unfocus,
        child: Scaffold(
          appBar: OtaAppBar(
            title: getTranslated(
                context, AppLocalizationsStrings.accommodationSearch),
            onLeftButtonPressed: () => _onWillPop(),
          ),
          body: BlocBuilder(
              bloc: _searchScreenBloc,
              builder: () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBarWithBack(),
                    if (_searchScreenBloc.isStateRecommendations)
                      Expanded(
                          child: _buildHistoryAndRecommendationsListWidget()),
                    if (_searchScreenBloc.isStateSuggestions)
                      Expanded(child: _buildSuggestionListView()),
                    if (_searchScreenBloc.isStateResults)
                      _getSearchResultByLocation(),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (!isFromSearchLocation) {
      Navigator.of(context)
          .pop(_suggestionModel?.name ?? _searchHistoryModel?.keyword);
    } else {
      onBackButtonTap();
    }
    return true;
  }

  _buildSearchBarWithBack() {
    return BlocBuilder(
      bloc: _suggestionBloc,
      builder: () {
        return OtaSearchInputWidget(
          searchHintText:
              getTranslated(context, AppLocalizationsStrings.searchOtaHint),
          searchTextController: _textFieldController,
          isEditingEnabled: true,
          isLoading: _suggestionBloc.state.suggestionState ==
                  OtaSuggestionViewModelState.loading &&
              _searchScreenBloc.isStateSuggestions,
          onChanged: (text) => onSearchTextChange(),
          onCrossButtonTap: onCrossButtonTap,
          onTextFieldTap: onSearchFieldTap,
          focusNode: _focusNode,
        );
      },
    );
  }

  Widget _buildHistoryAndRecommendationsListWidget() {
    return BlocBuilder(
      bloc: _recommendationBloc,
      builder: () {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            if (_loginModel.userType == UserType.loggedInUser &&
                _searchScreenBloc.isStateRecommendations &&
                !_recommendationBloc.isSearchHistoryEmpty)
              _buildSearchHistoryTitle(),
            if (_loginModel.userType == UserType.loggedInUser &&
                _searchScreenBloc.isStateRecommendations)
              _buildSearchHistoryListView(),
            if (_searchScreenBloc.isStateRecommendations &&
                !_recommendationBloc.isRecommendationsEmpty)
              _buildRecommendationTitle(),
            if (_searchScreenBloc.isStateRecommendations)
              _buildRecommendationListView(),
          ],
        );
      },
    );
  }

  Widget _buildSearchHistoryListView() {
    bool isSuccess = _recommendationBloc.state.recommendationState ==
        OtaRecommendationViewModelState.success;
    if (isSuccess) {
      final searchHistoryList = _recommendationBloc.state.searchHistoryList;
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchHistoryList.length,
        itemBuilder: (context, index) {
          return OtaSearchHistoryTileWidget(
            title: searchHistoryList[index].keyword.trim(),
            onTap: () {
              _focusNode.unfocus();
              _searchHistoryModel = searchHistoryList[index];
              _textFieldController.text = searchHistoryList[index].keyword;
              _searchScreenBloc.setStateResults();
              _requestOTASearchByCity(
                  searchHistoryModel: searchHistoryList[index],
                  isSuggestion: false);
            },
          );
        },
      );
    }
    return const SizedBox();
  }

  Widget _buildSearchHistoryTitle() {
    return Padding(
      padding: const EdgeInsets.only(
          top: kSize16, bottom: kSize8, left: kSize24, right: kSize24),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.recentSearchItems),
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildSuggestionListView() {
    return BlocBuilder(
      bloc: _suggestionBloc,
      builder: () {
        bool isLazyLoad = _suggestionBloc.state.suggestionState ==
                OtaSuggestionViewModelState.loading &&
            _suggestionBloc.state.suggestionList.isNotEmpty;
        bool isSuccess = _suggestionBloc.state.suggestionState ==
            OtaSuggestionViewModelState.success;
        if (isLazyLoad || isSuccess) {
          final suggestionList = _suggestionBloc.state.suggestionList;
          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: kSize8),
            controller: _scrollController,
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              if (index < suggestionList.length) {
                return _buildOtaSuggestionTileWidget(suggestionList[index]);
              }
              return _buildFooterLoader();
            },
            separatorBuilder: (_, __) {
              return const SizedBox(height: kSize8);
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  void _requestOTASearchByCity(
      {OtaSuggestionModel? model,
      OtaSearchHistoryModel? searchHistoryModel,
      bool isSuggestion = true}) {
    String otaSearchServicesEnabled =
        AppConfig().configModel.otaSearchServicesEnabled;

    _otaSearchUtil = OtaSearchUtil(
        searchKey: isSuggestion
            ? model?.name ?? ''
            : searchHistoryModel?.keyword ?? '',
        hotelId: isSuggestion
            ? model?.hotelId ?? ''
            : searchHistoryModel?.hotelId ?? '',
        locationId: isSuggestion ? model?.locationId ?? '' : "",
        cityId: isSuggestion
            ? model?.cityId ?? ''
            : searchHistoryModel?.cityId ?? '',
        countryId: isSuggestion
            ? model?.countryId ?? ''
            : searchHistoryModel?.countryId ?? '',
        searchAvailableApi: false,
        carViewData: otaSearchServicesEnabled.contains(_kCarKey)
            ? CarViewData(
                age: AppConfig().configModel.carDriverDefaultAge,
                includeDriver: AppConfig().configModel.includeDriver == "Y",
                pickupDate:
                    Helpers.getYYYYmmddFromDateTime(_getDefaultPickupDate()),
                returnDate:
                    Helpers.getYYYYmmddFromDateTime(_getDefaultReturnDate()),
                pickupTime: defaultTime,
                returnTime: defaultTime,
                cityId: getCityId(isSuggestion, model),
                pickupLocationId:
                    isSuggestion ? model?.id : searchHistoryModel?.locationId,
                returnLocationId:
                    isSuggestion ? model?.id : searchHistoryModel?.locationId)
            : null,
        tourAndTicketViewData: otaSearchServicesEnabled.contains(_kTourKey)
            ? TourAndTicketViewData(
                cityId: isSuggestion
                    ? model?.cityId ?? ''
                    : searchHistoryModel?.cityId ?? '',
                countryId: isSuggestion
                    ? model?.countryId ?? ''
                    : searchHistoryModel?.countryId ?? '',
                locationId: isSuggestion ? model?.locationId ?? '' : "")
            : null);
    _otaSearchBloc.getOtaSearchResult(_otaSearchUtil!.getArguments());
  }

  String? getCityId(bool isSuggestion, OtaSuggestionModel? model) {
    String? cityId;
    if (isSuggestion && (model != null && model.id.isEmpty)) {
      return model.cityId;
    } else if (!isSuggestion &&
        (_searchHistoryModel?.locationId == null ||
            _searchHistoryModel!.locationId!.isEmpty)) {
      return _searchHistoryModel?.cityId;
    }
    return cityId;
  }

  Widget _buildRecommendationTitle() {
    return Padding(
      padding: const EdgeInsets.only(
          top: kSize16, bottom: kSize8, left: kSize24, right: kSize24),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.recommendedOtaTitle),
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildRecommendationListView() {
    bool isSuccess = _recommendationBloc.state.recommendationState ==
        OtaRecommendationViewModelState.success;
    if (isSuccess) {
      final recommendationList = _recommendationBloc.state.recommendationList;
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: recommendationList.length,
        itemBuilder: (context, index) {
          return OtaRecommendationTileWidget(
            title: recommendationList[index].serviceTitle,
            imageUrl: recommendationList[index].imageUrl,
            onRecommendationTap: () =>
                _openFullPlaylistScreen(recommendationList[index]),
          );
        },
      );
    }
    return const SizedBox();
  }

  Future<void> _onRefresh() async {
    await _otaSearchBloc.getOtaSearchResult(_otaSearchUtil!.getArguments());
  }

  Widget _getSearchResultByLocation() {
    isFromSearchLocation = true;
    return BlocBuilder(
        bloc: _otaSearchBloc,
        builder: () {
          switch (_otaSearchBloc.state.pageState) {
            case OtaSearchViewPageState.loading:
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            case OtaSearchViewPageState.failure:
            case OtaSearchViewPageState.internetFailure:
              return _failureWidget();
            case OtaSearchViewPageState.success:
              return _getSearchListByLocation();
            case OtaSearchViewPageState.empty:
              return const Padding(
                padding:
                    EdgeInsets.fromLTRB(kSize16, kSize85, kSize16, kSize100),
                child: OtaSearchNoResultWidget(
                  paddingHeight: kSize8,
                ),
              );
            default:
              return const SizedBox();
          }
        });
  }

  Widget _getSearchListByLocation() {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: _getSearchListChildren(),
        ),
      ),
    );
  }

  List<Widget> _getSearchListChildren() {
    List<Widget> widgetList = [];
    if (_otaSearchBloc.state.data?.hotelView != null &&
        _otaSearchBloc.state.data!.hotelView!.hotelList != null &&
        _otaSearchBloc.state.data!.hotelView!.hotelList!.isNotEmpty) {
      widgetList.add(_buildHotelListWidget());
    }

    if (_otaSearchBloc.state.data?.tourView != null &&
        _otaSearchBloc.state.data!.tourView!.activityList != null &&
        _otaSearchBloc.state.data!.tourView!.activityList!.isNotEmpty) {
      widgetList.add(_buildTourListWidget());
    }
    if (_otaSearchBloc.state.data?.ticketView != null &&
        _otaSearchBloc.state.data!.ticketView!.activityList != null &&
        _otaSearchBloc.state.data!.ticketView!.activityList!.isNotEmpty) {
      widgetList.add(_buildTicketListWidget());
    }

    if (_otaSearchBloc.state.data?.carView != null &&
        _otaSearchBloc.state.data!.carView!.carRental != null &&
        _otaSearchBloc.state.data!.carView!.carRental?.carModelList != null &&
        _otaSearchBloc
            .state.data!.carView!.carRental!.carModelList!.isNotEmpty) {
      widgetList.add(_buildCarList());
    }
    return widgetList;
  }

  Widget _buildHotelListWidget() {
    return OTASearchResultHorizontalWidget(
      title: getTranslated(
          context, AppLocalizationsStrings.allServicesAccommodation),
      onTitleArrowClick: _openHotelSearchResult,
      cardList: _otaSearchBloc.state.data?.hotelView?.hotelList,
      onCardClick: (data) => openHotelDetailScreen(data),
    );
  }

  Widget _buildCarList() {
    return OtaSearchHorizontalList(
      dataList: _otaSearchBloc.state.data?.carView?.carRental?.carModelList!,
      onCardClick: (data) {
        _openCarSearchResultScreen(
            data,
            _otaSearchBloc.state.data?.carView?.carRental?.pickupLocationId ??
                '',
            _otaSearchBloc.state.data?.carView?.carRental?.returnLocationId ??
                '');
      },
      onTitleArrowClick: () {
        _openCarListScreen();
      },
      title: getTranslated(context, AppLocalizationsStrings.allServicesCar),
    );
  }

  Widget _failureWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Material(
        child: OtaNetworkErrorWidgetWithRefresh(
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () => _onRefresh(),
        ),
      ),
    );
  }

  Widget _buildTourListWidget() {
    return OtaTnaPlaylistWidget(
      title: getTranslated(context, AppLocalizationsStrings.allServicesTour),
      onTitleArrowClick: () {
        _openTnaSearchResult(PlaylistType.tour);
      },
      playlistType: PlaylistType.tour,
      cardList: _otaSearchBloc.state.data!.tourView!.activityList!,
    );
  }

  Widget _buildTicketListWidget() {
    return OtaTnaPlaylistWidget(
      title: getTranslated(context, AppLocalizationsStrings.allServicesTicket),
      onTitleArrowClick: () {
        _openTnaSearchResult(PlaylistType.ticket);
      },
      cardList: _otaSearchBloc.state.data!.ticketView!.activityList!,
      playlistType: PlaylistType.ticket,
    );
  }

  void _openHotelSearchResult() async {
    _filterArgument = await Navigator.pushNamed(
      context,
      AppRoutes.hotelListView,
      arguments: OtaSearchStateModel(
        pageType: PageType.search,
        suggestion: _suggestionModel,
        searchHistoryModel: _searchHistoryModel,
        hotelView: _otaSearchBloc.state.data?.hotelView,
        lastPageFlag: _otaSearchBloc.state.data?.lastPageFlag,
        filterArgument: _filterArgument != null
            ? _filterArgument as FilterArgument
            : _filterArgument,
      ),
    ) as FilterArgument?;
  }

  void _openTnaSearchResult(PlaylistType playlistType) {
    TourSearchResultArgumentModel argument = TourSearchResultArgumentModel(
      userId: _otaSearchUtil!.getArguments().userId,
      playlistName: playlistType.value,
      cityId: _otaSearchUtil?.cityId,
      countryId: _otaSearchUtil!.countryId,
      latitude: _otaSearchUtil!.getArguments().latitude,
      longitude: _otaSearchUtil!.getArguments().longitude,
      searchKey: _otaSearchUtil!.getArguments().searchKey,
      pageNumber: _kPageNumber,
      pageSize: _kPageSize,
      tourSearchList: _otaSearchBloc.tourActivityList,
      ticketSearchList: _otaSearchBloc.ticketActivityList,
      tourfilterOption: _otaSearchBloc.tourFilterModel,
      ticketfilterOption: _otaSearchBloc.ticketFilterModel,
    );
    Navigator.pushNamed(context, AppRoutes.tourSearchResultScreen,
        arguments: argument);
  }

  DateTime _getDefaultPickupDate() {
    DateTime currentDate = DateTime.now();
    return DateTime(currentDate.year, currentDate.month, currentDate.day,
            _kDefaultHours)
        .add(_kDurationT1);
  }

  DateTime _getDefaultReturnDate() {
    DateTime currentDate = DateTime.now();
    return DateTime(currentDate.year, currentDate.month, currentDate.day,
            _kDefaultHours)
        .add(_kDurationT4);
  }

  void _openCarSearchResultScreen(
      CarModelList car, String pickupLocationId, String returnLocationId) {
    Navigator.of(context).pushNamed(AppRoutes.carSupplierScreen,
        arguments: CarSupplierArgumentViewModel(
          pickupLocationId: pickupLocationId,
          returnLocationId: returnLocationId,
          pickupLocation: _otaSearchUtil?.searchKey ?? '',
          returnLocation: car.suppliers?.first.returnCounter?.name,
          pickupDate: _getDefaultPickupDate(),
          returnDate: _getDefaultReturnDate(),
          carId: car.carId.toString(),
          includeDriver: AppConfig().configModel.includeDriver,
          currency: AppConfig().currency,
          rentalType: AppConfig().rentalType,
          age: AppConfig().configModel.carDriverDefaultAge,
          brandName: car.brandName,
          craftType: car.carInfo?.carTypeName,
          thumbImage: car.images?.thumb,
          carName: car.modelName,
        ));
  }

  _openCarListScreen() {
    final argument = CarVerticalArgumentViewModel(
        carModel: _otaSearchBloc.state.data?.carView?.carRental,
        locationName: _suggestionModel != null
            ? (_suggestionModel?.name)
            : _searchHistoryModel?.keyword ?? '');
    Navigator.pushNamed(context, AppRoutes.carRentalVerticalPlaylistScreen,
        arguments: [_otaSearchUtil, argument]);
  }

  Widget _buildOtaSuggestionTileWidget(OtaSuggestionModel suggestion) {
    return OtaSuggestionTileWidget(
      title: suggestion.name.trim(),
      searchTileType: _getSuggestionTileType(suggestion.searchSuggestionType),
      onSearchSuggestionTap: () {
        _suggestionModel = suggestion;
        _textFieldController.text = suggestion.name;
        _searchScreenBloc.setStateResults();
        _focusNode.unfocus();
        _requestOTASearchByCity(model: suggestion);
      },
    );
  }

  void openHotelDetailScreen(String hotelId) {
    final hotelArgument = HotelDetailArgument.getBookingArgument(
      hotelId: hotelId,
      cityId: (_suggestionModel?.cityId ?? _searchHistoryModel?.cityId)!,
      countryId:
          (_suggestionModel?.countryId ?? _searchHistoryModel?.countryId)!,
      bookingViewData: _otaSearchUtil!.getBookingData()!,
      userType: _loginModel.userType.getHotelDetailType(),
    );

    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  Widget _buildFooterLoader() {
    return _suggestionBloc.state.suggestionState ==
                OtaSuggestionViewModelState.loading &&
            _suggestionBloc.state.suggestionList.isNotEmpty
        ? const Center(child: CircularProgressIndicator())
        : const SizedBox();
  }
}
