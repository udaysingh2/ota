import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_search_result_click_parameters.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/tours_search_result_parameters.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/playlist/view/widgets/category_list/horizontal_category_list.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/landing/view/widgets/tour_ticket_playlist_card.dart';
import 'package:ota/modules/tours/playlist/view_model/playlist_type.dart';
import 'package:ota/modules/tours/tour_search/results/bloc/tour_date_picker_controller.dart';
import 'package:ota/modules/tours/tour_search/results/bloc/tour_search_result_bloc.dart';
import 'package:ota/modules/tours/tour_search/results/helpers/tour_search_result_helper.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/ota_search_no_result_with_refresh.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/tour_search_date_picker.dart';
import 'package:ota/modules/tours/tour_search/results/view/widgets/tour_search_result_app_bar.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

const _kThailandCountryId = 'MA05110001';
const _kBangkokCityId = 'MA05110041';
const _kTourKey = "tour";
const _kTicketKey = "ticket";
const _kPageSize = 20;
const int refreshPageNumber = 1;
const int _kTitleMaxLines = 2;

class TourSearchResultScreen extends StatefulWidget {
  const TourSearchResultScreen({Key? key}) : super(key: key);

  @override
  State<TourSearchResultScreen> createState() => _TourSearchResultScreenState();
}

class _TourSearchResultScreenState extends State<TourSearchResultScreen> {
  final TourSearchResultBloc _tourSearchResultBloc = TourSearchResultBloc();
  final TourDatePickerController _tourDatePickerController =
      TourDatePickerController();
  final _userId = getLoginProvider().userId;
  TourSearchResultArgumentModel? _argument;
  TourSearchFilterArgument? _filterArgument;
  int currentTourPageNumber = 1;
  int currentTicketPageNumber = 1;
  int currentPageNumber = 1;
  int maxSizeTour = 0;
  int maxSizeTicket = 0;
  String tourOrTicketType = "";
  bool tourTicketRefresh = false;
  String? searchTextKey;

  void _initialize() {
    _argument = ModalRoute.of(context)?.settings.arguments
        as TourSearchResultArgumentModel;
    searchTextKey = _argument?.searchKey;
    if (_argument != null &&
        !_argument!.isLatLongAvailable &&
        _argument?.searchKey == null) {
      _argument?.searchKey =
          getTranslated(context, AppLocalizationsStrings.bangkok);
      _argument?.countryId = _kThailandCountryId;
      _argument?.cityId = _kBangkokCityId;
    }
    _argument?.userId = _userId;
    _argument?.pageNumber = 1;
    _argument?.pageSize = _kPageSize;
    tourOrTicketType = _argument!.playlistName;

    _tourSearchResultBloc.initData(_argument);
    _tourSearchResultBloc.getTourSearchResultData(
        argument: _argument,
        refreshData: false,
        isForceFetch: true,
        isFiltered: false,
        refreshLoading: true);
  }

  void _getTourTicketSearchListData(
      {required String playlistName,
      required int pageNumber,
      required bool refreshData,
      required bool isFiltered,
      required bool isForceFetch,
      bool refreshLoading = false}) {
    tourTicketRefresh = refreshData;
    _argument?.playlistName = playlistName;
    _argument?.pageNumber = pageNumber;
    _tourSearchResultBloc.getTourSearchResultData(
        argument: _argument,
        refreshData: refreshData,
        isFiltered: isFiltered,
        isForceFetch: isForceFetch,
        refreshLoading: refreshLoading);
  }

  @override
  void dispose() {
    _tourSearchResultBloc.dispose();
    _clearSearchKeyFirebaseData();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initialize();
    });

    super.initState();
    _tourSearchResultBloc.stream.listen((event) {
      if (_tourSearchResultBloc.state.tourSearchResultViewState ==
              TourSearchResultViewState.internetFailure ||
          _tourSearchResultBloc.state.tourSearchResultViewState ==
              TourSearchResultViewState.internetFailureRefresh) {
        OtaDialogLoader().hideLoader(context);
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (_tourSearchResultBloc.state.tourSearchResultViewState !=
          TourSearchResultViewState.filterLoading) {
        OtaDialogLoader().hideLoader(context);
      } else if (_tourSearchResultBloc.state.tourSearchResultViewState ==
          TourSearchResultViewState.filterLoading) {
        OtaDialogLoader().showLoader(context);
      }
      if (_tourSearchResultBloc.state.tourSearchResultViewState ==
              TourSearchResultViewState.success &&
          searchTextKey != null) {
        _publishFirebaseSearchResultData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _tourSearchResultBloc,
      builder: () {
        var selectedDateString =
            getTranslated(context, AppLocalizationsStrings.tourSelectDate);
        return Scaffold(
          appBar: TourSearchResultAppBar(
            locationName: _tourSearchResultBloc.state.locationName ?? '',
            selectDateText: TourSearchResultHelper.getSelectedDate(
                    _argument?.serviceDate) ??
                selectedDateString,
            onSelectDateTextTap: _selectTourDate,
            onFilterTap: _onFilterTap,
          ),
          body: _tourSearchResultBloc.isRefreshLoading
              ? const OTALoadingIndicator()
              : _successWidget(),
        );
      },
    );
  }

  Widget _successWidget() {
    return Column(
      children: [
        HorizontalCategoryList(
          categories: const [
            AppLocalizationsStrings.activity,
            AppLocalizationsStrings.ticket
          ],
          onCategorySelected: (value) {
            final playlistType = value == AppLocalizationsStrings.activity
                ? PlaylistType.tour
                : PlaylistType.ticket;
            tourOrTicketType = playlistType.value;
            _tourSearchResultBloc.onCategorySelected(playlistType);
            if (playlistType == PlaylistType.tour &&
                !_tourSearchResultBloc.isTourSearchListNotNullEmpty) {
              _getTourTicketSearchListData(
                  playlistName: playlistType.value,
                  pageNumber: currentTourPageNumber,
                  refreshData: false,
                  isForceFetch: true,
                  isFiltered: false);
            } else if (playlistType == PlaylistType.ticket &&
                !_tourSearchResultBloc.isTicketSearchListNotNullEmpty) {
              _getTourTicketSearchListData(
                  playlistName: playlistType.value,
                  pageNumber: currentTicketPageNumber,
                  refreshData: false,
                  isForceFetch: true,
                  isFiltered: false);
            }
          },
          disableCategoryPress: _tourSearchResultBloc.isLoading,
          selectedCatIndex:
              _tourSearchResultBloc.isTourSelectedCategory ? 0 : 1,
        ),
        _buildSearchResultList(),
      ],
    );
  }

  void _onFilterTap() async {
    if (_filterArgument != null) {
      if (_tourSearchResultBloc.isTourSelectedCategory) {
        _filterArgument!.serviceType = TourSearchServiceType.tour;
        if (_filterArgument!.tourModel == null) {
          _filterArgument!.filterData =
              _tourSearchResultBloc.state.tourFilterOption;
        }
      } else {
        _filterArgument!.serviceType = TourSearchServiceType.tickets;
        if (_filterArgument!.ticketModel == null) {
          _filterArgument!.filterData =
              _tourSearchResultBloc.state.ticketFilterOption;
        }
      }
    } else {
      if (_tourSearchResultBloc.isTourSelectedCategory) {
        _filterArgument = TourSearchFilterArgument(
            serviceType: TourSearchServiceType.tour,
            filterData: _tourSearchResultBloc.state.tourFilterOption);
      } else {
        _filterArgument = TourSearchFilterArgument(
            serviceType: TourSearchServiceType.tickets,
            filterData: _tourSearchResultBloc.state.ticketFilterOption);
      }
    }
    var result = await Navigator.pushNamed(
      context,
      AppRoutes.tourSearchFilterScreen,
      arguments: _filterArgument,
    );
    if (result is TourSearchFilterArgument) {
      _filterArgument = result;
      if (_filterArgument!.serviceType == TourSearchServiceType.tour &&
          _filterArgument!.tourModel != null) {
        _argument!.playlistName = _kTourKey;
        _argument!.tourfilterModel = TourFilterModel.mapFromFilterScreenData(
            _filterArgument!.tourModel!);
      } else if (_filterArgument!.serviceType ==
              TourSearchServiceType.tickets &&
          _filterArgument!.ticketModel != null) {
        _argument!.playlistName = _kTicketKey;
        _argument!.ticketfilterModel = TourFilterModel.mapFromFilterScreenData(
            _filterArgument!.ticketModel!);
      }
      tourOrTicketType == _kTourKey
          ? currentTourPageNumber = 1
          : currentTicketPageNumber = 1;
      _getTourTicketSearchListData(
          pageNumber: refreshPageNumber,
          playlistName: tourOrTicketType,
          isForceFetch: false,
          refreshData: true,
          isFiltered: true);
    }
  }

  bool isNewDataRequired(int index) {
    maxSizeTour = currentTourPageNumber * _kPageSize;
    maxSizeTicket = currentTicketPageNumber * _kPageSize;
    int maxSize = tourOrTicketType == _kTourKey ? maxSizeTour : maxSizeTicket;
    if (maxSize == (index + 1)) return true;
    return false;
  }

  Widget _buildSearchResultList() {
    int pageNumber = tourOrTicketType == _kTourKey
        ? currentTourPageNumber
        : currentTicketPageNumber;
    return Expanded(
      child: _tourSearchResultBloc.isLoading && (pageNumber == 1)
          ? const OTALoadingIndicator()
          : (!_tourSearchResultBloc.isFailure &&
                  _tourSearchResultBloc.isTourTicketSearchListAvailable)
              ? OtaRefreshIndicator(
                  text: _buildLoadingText(context),
                  onRefresh: () async {
                    tourOrTicketType == _kTourKey
                        ? currentTourPageNumber = 1
                        : currentTicketPageNumber = 1;
                    _getTourTicketSearchListData(
                        playlistName: tourOrTicketType,
                        pageNumber: refreshPageNumber,
                        refreshData: true,
                        isForceFetch: false,
                        isFiltered: false);
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSize24, vertical: kSize16),
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    key: ObjectKey(
                        _tourSearchResultBloc.tourTicketSearchList[0]),
                    itemCount: _tourSearchResultBloc.searchListSize,
                    itemBuilder: (context, index) {
                      if (isNewDataRequired(index)) {
                        if (tourOrTicketType == _kTourKey) {
                          currentPageNumber = currentTourPageNumber++;
                        } else if (tourOrTicketType == _kTicketKey) {
                          currentPageNumber = currentTicketPageNumber++;
                        }
                        _getTourTicketSearchListData(
                            playlistName: tourOrTicketType == _kTourKey
                                ? _kTourKey
                                : _kTicketKey,
                            pageNumber: tourOrTicketType == _kTourKey
                                ? currentTourPageNumber
                                : currentTicketPageNumber,
                            refreshData: false,
                            isForceFetch: false,
                            isFiltered: false);
                      }

                      return _buildSearchResultCard(
                          _tourSearchResultBloc.tourTicketSearchList[index],
                          index);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: kSize24),
                  ),
                )
              : _buildEmptyState(),
    );
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
    );
  }

  Widget _buildEmptyState() {
    if (tourOrTicketType == _kTourKey) {
      if (_tourSearchResultBloc.state.tourSearchList != null) {
        _tourSearchResultBloc.state.tourSearchList = null;
        _tourSearchResultBloc.state.tourFilterOption = null;
      }
    } else {
      if (_tourSearchResultBloc.state.ticketSearchList != null) {
        _tourSearchResultBloc.state.ticketSearchList = null;
        _tourSearchResultBloc.state.ticketFilterOption = null;
      }
    }
    return OtaSearchNoResultRefresh(
      padding: kPaddingHori24,
      height: MediaQuery.of(context).size.height - kSize257,
      onRefresh: () async {
        tourOrTicketType == _kTourKey
            ? currentTourPageNumber = 1
            : currentTicketPageNumber = 1;
        _getTourTicketSearchListData(
            playlistName: tourOrTicketType,
            pageNumber: refreshPageNumber,
            refreshData: true,
            isForceFetch: false,
            isFiltered: false);
      },
    );
  }

  Widget _buildSearchResultCard(TourSearchResultModel searchModel, int index) {
    return TourTicketPlaylistCard(
      name: searchModel.name,
      location: searchModel.locationName,
      category: searchModel.category,
      promotionTextTop: searchModel.promotionTextLine1,
      promotionTextBottom: searchModel.promotionTextLine2,
      imageUrl: searchModel.imageUrl,
      price: searchModel.startPrice,
      cityName: searchModel.cityName,
      playlistType: _tourSearchResultBloc.isTourSelectedCategory
          ? PlaylistType.tour
          : PlaylistType.ticket,
      isInHorizontalScroll: false,
      onPress: () {
        if (searchTextKey != null) {
          _publishFirebaseSearchResultClickData(searchModel, index);
        }
        _onSearchResultCardClick(
            searchModel.id, searchModel.cityId, searchModel.countryId);
      },
      amentities: _amenitiesList(searchModel.capsulePromotion),
      maxLines: _kTitleMaxLines,
    );
  }

  List<String>? _amenitiesList(
      List<TourSearchCapsulePromotion>? capsulePromotion) {
    if (capsulePromotion == null || capsulePromotion.isEmpty) {
      return null;
    }
    List<String> amenities = [];
    for (TourSearchCapsulePromotion capsule in capsulePromotion) {
      if (capsule.name != null) {
        amenities.add(capsule.name!);
      }
    }
    return amenities;
  }

  void _onSearchResultCardClick(String id, String cityId, String countryId) {
    final userType = getLoginProvider().userType;
    if (_tourSearchResultBloc.isTourSelectedCategory) {
      final tourDetailUserType = userType == UserType.guestUser
          ? TourDetailUserType.guestUser
          : TourDetailUserType.loggedInUser;
      final tourArgument = TourDetailArgument(
        userType: tourDetailUserType,
        tourId: id,
        cityId: cityId,
        countryId: countryId,
        tourDate: Helpers.getYYYYmmddFromDateTime(_argument!.serviceDate ??
            DateTime.now().add(const Duration(days: 1))),
      );
      Navigator.pushNamed(context, AppRoutes.tourDetailScreen,
          arguments: tourArgument);
    } else {
      final ticketDetailUserType = userType == UserType.guestUser
          ? TicketDetailUserType.guestUser
          : TicketDetailUserType.loggedInUser;
      final ticketArgument = TicketDetailArgument(
        userType: ticketDetailUserType,
        ticketId: id,
        cityId: cityId,
        countryId: countryId,
        ticketDate: Helpers.getYYYYmmddFromDateTime(_argument!.serviceDate ??
            DateTime.now().add(const Duration(days: 1))),
      );
      Navigator.pushNamed(context, AppRoutes.ticketDetailScreen,
          arguments: ticketArgument);
    }
  }

  _selectTourDate() {
    _tourDatePickerController.state.selectedDate =
        _argument?.serviceDate ?? DateTime.now().add(const Duration(days: 1));
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder(
          bloc: _tourDatePickerController,
          builder: () {
            return TourSearchDatePicker(
              selectedDate: _tourDatePickerController.state.selectedDate,
              onSubmit: (checkInDate) {
                _argument!.serviceDate = checkInDate;
                _dateSelectionTab();
              },
              onReset: () {
                _argument!.serviceDate = null;
                _tourDatePickerController.resetDate();
                _dateSelectionTab();
              },
            );
          },
        );
      },
    );
  }

  void _dateSelectionTab() {
    if (_tourSearchResultBloc.isTourSelectedCategory) {
      _tourSearchResultBloc.state.ticketSearchList?.clear();
      currentTourPageNumber = 1;
      _getTourTicketSearchListData(
          playlistName: PlaylistType.tour.value,
          pageNumber: refreshPageNumber,
          refreshData: true,
          isFiltered: true,
          isForceFetch: false);
    } else {
      currentTicketPageNumber = 1;
      _tourSearchResultBloc.state.tourSearchList?.clear();
      _getTourTicketSearchListData(
          playlistName: PlaylistType.ticket.value,
          pageNumber: refreshPageNumber,
          refreshData: true,
          isFiltered: true,
          isForceFetch: false);
    }
    Navigator.of(context).pop();
  }

  void _publishFirebaseSearchResultData() {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: TourSearchResultFirebase.activityKeywordSearch,
        value: TourSearchResultFirebase.searchKeyText);
    firebaseLogger.addKeyValue(
        key: TourSearchResultFirebase.activityService, value: tourOrTicketType);
    firebaseLogger.addUserLocation();
    firebaseLogger.addKeyValue(
        key: TourSearchResultFirebase.activityDestination,
        value: _argument?.searchKey);
    firebaseLogger.addDoubleValue(
        key: TourSearchResultFirebase.activityFilterPriceMin,
        value: tourOrTicketType == _kTourKey
            ? _argument?.tourfilterModel?.minPrice?.toDouble()
            : _argument?.ticketfilterModel?.minPrice?.toDouble());
    firebaseLogger.addDoubleValue(
        key: TourSearchResultFirebase.activityFilterPriceMax,
        value: tourOrTicketType == _kTourKey
            ? _argument?.tourfilterModel?.maxPrice?.toDouble()
            : _argument?.ticketfilterModel?.maxPrice?.toDouble());
    firebaseLogger.addCommaSeparatedList(
        key: TourSearchResultFirebase.activityFilterType,
        value: tourOrTicketType == _kTourKey
            ? _argument?.tourfilterModel?.styleName
            : _argument?.ticketfilterModel?.styleName);
    firebaseLogger.publishToSuperApp(FirebaseEvent.tourSearchResult);
  }

  void _publishFirebaseSearchResultClickData(
      TourSearchResultModel? model, int index) {
    FirebaseLogger firebaseLogger = FirebaseLogger();
    firebaseLogger.addKeyValue(
        key: TourSearchResultClickFirebase.activityKeywordSearch,
        value: TourSearchResultClickFirebase.searchKeyText);
    firebaseLogger.addKeyValue(
        key: TourSearchResultClickFirebase.activityService,
        value: tourOrTicketType);
    firebaseLogger.addUserLocation();
    firebaseLogger.addIntValue(
        value: index + 1, key: TourSearchResultClickFirebase.activitySequence);
    firebaseLogger.addKeyValue(
        key: TourSearchResultClickFirebase.activityId, value: model?.id);
    firebaseLogger.addKeyValue(
        key: TourSearchResultClickFirebase.activityName, value: model?.name);
    firebaseLogger.addDoubleValue(
        key: TourSearchResultClickFirebase.activityStartPrice,
        value: model?.startPrice);
    firebaseLogger.addCommaSeparatedList(
        value: model?.capsulePromotion?.map((e) => e.name).toList(),
        key: TourSearchResultClickFirebase.activityPromotionTag);
    firebaseLogger.publishToSuperApp(FirebaseEvent.tourSearchResultClick);
  }

  void _clearSearchKeyFirebaseData() {
    TourSearchResultFirebase.searchKeyText = "";
    TourSearchResultClickFirebase.searchKeyText = "";
  }
}
