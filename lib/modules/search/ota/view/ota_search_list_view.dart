import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_discount_price_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_playlist_amenities/ota_suggestion_card_with_amentities.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_search_input_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_search_result_parameters.dart';
import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/loading/view/loading_screen.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/helpers/ota_search_util.dart';
import 'package:ota/modules/search/ota/bloc/ota_search_bloc.dart';
import 'package:ota/modules/search/ota/view/widgets/ota_search_list_view_app_bar.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_state_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';

const _kTopHeight = 180;
const _serviceName = "HOTEL";

class HotelListView extends StatefulWidget {
  const HotelListView({Key? key}) : super(key: key);

  @override
  HotelListViewState createState() => HotelListViewState();
}

class HotelListViewState extends State<HotelListView> {
  final OtaSearchBloc _otaSearchBloc = OtaSearchBloc();
  FilterOtaArgumentData? _filterOtaArgumentData;
  FilterArgument? _filterArgument;
  OtaSearchStateModel? _arguments;
  OtaSearchUtil? _otaSearchUtil;
  String? name;
  String? hotelId;
  String? locationId;
  String? cityId;
  String? countryId;
  final LoginModel _loginModel = getLoginProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _arguments =
          ModalRoute.of(context)?.settings.arguments as OtaSearchStateModel;
      switch (_arguments!.pageType) {
        case PageType.search:
          name = _arguments?.suggestion?.name ??
              _arguments?.searchHistoryModel?.keyword;
          locationId = _arguments?.suggestion?.locationId ?? '';
          hotelId = _arguments?.suggestion?.hotelId ??
              _arguments?.searchHistoryModel?.hotelId;
          cityId = _arguments?.suggestion?.cityId ??
              _arguments?.searchHistoryModel?.cityId;
          countryId = _arguments?.suggestion?.countryId ??
              _arguments?.searchHistoryModel?.countryId;
          _otaSearchUtil = OtaSearchUtil(
              searchKey: name!,
              locationId: locationId!,
              hotelId: hotelId ?? '',
              cityId: cityId!,
              searchAvailableApi: false,
              countryId: countryId!);
          _filterArgument = _arguments?.filterArgument;
          if (_arguments?.filterArgument != null) {
            _otaSearchUtil?.updateFilterArgument(_filterArgument!,
                isDefault: true);
          }
          _otaSearchBloc
              .initPreLoadedData(_arguments!.hotelView?.hotelList ?? []);
          break;
        case PageType.filter:
        case PageType.hotel:
          name = _arguments?.filterArgument?.name;
          hotelId = _arguments?.filterArgument?.hotelId;
          locationId = _arguments?.filterArgument?.locationId;
          cityId = _arguments?.filterArgument?.cityId;
          countryId = _arguments?.filterArgument?.countryCode;
          _otaSearchUtil = OtaSearchUtil(
              searchKey: name!,
              hotelId: hotelId!,
              locationId: locationId ?? '',
              cityId: cityId!,
              searchAvailableApi: true,
              countryId: countryId!);
          _filterArgument = _arguments?.filterArgument;
          _otaSearchUtil?.updateFilterArgument(_filterArgument!,
              isDefault: true);
          _getSearchData();
          break;
        default:
          break;
      }

      _otaSearchBloc.stream.listen((event) {
        _otaSearchBloc.isLoadingFilter
            ? OtaDialogLoader().showLoader(context)
            : OtaDialogLoader().hideLoader(context);

        if (_otaSearchBloc.state.pageState ==
            OtaSearchViewPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
        if (_otaSearchBloc.state.pageState == OtaSearchViewPageState.success ||
            _otaSearchBloc.state.pageState == OtaSearchViewPageState.empty) {
          if (_arguments?.pageType == PageType.hotel &&
              _otaSearchBloc.currentPageNumber <= 1) {
            _triggerFirebaseEvent(FirebaseEvent.hotelSearchResultEvent);
            _hotelSearchSuccess();
          }
        }
      });
    });
  }

  Future<bool> _onWillPop() async {
    if (_arguments != null && _arguments!.pageType == PageType.hotel) {
      Navigator.of(context).pop(_filterArgument);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(body: _buildBody()),
    );
  }

  void _getSearchData({bool isFilterLoading = false, bool isRefresh = false}) {
    _otaSearchBloc.getHotelSearchResult(_otaSearchUtil!.getArguments(),
        isFilterLoading: isFilterLoading, isRefresh: isRefresh);
  }

  bool _isNewDataRequired(int index) {
    int listSize = _otaSearchBloc.hotelListData.length;
    bool isLastPage = _otaSearchBloc.isPreLoaded
        ? _arguments?.lastPageFlag ?? true
        : (_otaSearchBloc.state.data?.lastPageFlag ?? true);
    return !isLastPage && listSize == (index + 1);
  }

  Widget _buildResultList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _otaSearchBloc.hotelListData.length,
        padding: const EdgeInsets.only(top: kSize12, bottom: kSize48),
        itemBuilder: (context, index) {
          if (_isNewDataRequired(index) &&
              !_otaSearchBloc.isLoading &&
              !_otaSearchBloc.isLoadingFilter) {
            _getSearchData();
          }
          return _getItemAtIndex(_otaSearchBloc.hotelListData.elementAt(index),
              index, _arguments?.pageType == PageType.search);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: kSize24);
        },
      ),
    );
  }

  Widget _getItemAtIndex(
      HotelListResult hotelListResult, int index, bool isOtaSearch) {
    if (hotelListResult.hotelName.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        children: [
          OtaSuggestionCardHorizontalAmenities(
            isSoldOut: _isHotelSoldOut(hotelListResult),
            isInHorizontalScroll: false,
            headerText: hotelListResult.hotelName,
            ratingText: hotelListResult.rating.toString(),
            addressText: hotelListResult.address,
            reviewText: hotelListResult.reviewText,
            ratingTitle: hotelListResult.ratingTitle,
            offerPercent: hotelListResult.offerPercent,
            discount: hotelListResult.discount,
            imageUrl: hotelListResult.hotelImage,
            score: hotelListResult.score,
            adminPromotionLine1: hotelListResult.adminPromotionLine1,
            adminPromotionLine2: hotelListResult.adminPromotionLine2,
            amenitiesList: isOtaSearch
                ? hotelListResult.capsulePromotions
                : hotelListResult.capsulePromotions +
                    hotelListResult.infoPromotions,
            onPress: () {
              if (_arguments?.pageType == PageType.hotel) {
                _triggerFirebaseEvent(FirebaseEvent.hotelSearchResultSelect,
                    hotelListResult, index);
              }
              openHotelDetailScreen(hotelListResult.hotelId!);
            },
          ),
          Offstage(
            offstage: _arguments!.pageType == PageType.search,
            child: _getCardBottomBar(hotelListResult),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder(
      bloc: _otaSearchBloc,
      builder: () {
        if (_filterOtaArgumentData == null && _otaSearchBloc.isSuccess) {
          _initFilterData(_otaSearchBloc.state.data!.hotelView!.filter!);
        }
        if (_filterOtaArgumentData == null && _otaSearchBloc.isPreLoaded) {
          _initFilterData(_arguments!.hotelView!.filter!);
        }
        return (_otaSearchBloc.isLoading && _otaSearchBloc.isHotelListEmpty)
            ? const LoadingScreen(_serviceName)
            : Column(
                children: [
                  _buildNavigationBarWidget(),
                  _buildMainWidget(),
                ],
              );
      },
    );
  }

  Widget _buildNavigationBarWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          kSize16, MediaQuery.of(context).padding.top, kSize16, kSize0),
      child: HotelListViewAppBar(
        isFromOTASearch: _arguments!.pageType == PageType.search,
        searchFilterText: _otaSearchUtil!.getDateRoomParseInfo(),
        totalNumOfPeople: _otaSearchUtil!.totalNumberOfPeople.toString(),
        title: _otaSearchUtil!.getSearchKey(),
        onTapFilter: (_filterOtaArgumentData != null)
            ? () {
                if (_filterOtaArgumentData != null) {
                  _useOtaSearchFilter(
                      _otaSearchBloc.state.data?.hotelView?.filter);
                }
              }
            : null,
        onTapSearch: onTapSearch,
        onBackClicked: () {
          if (_filterArgument != null && _filterArgument!.onUpdated != null) {
            _filterArgument!.onUpdated!(_filterArgument!);
          }

          Navigator.of(context).pop(_filterArgument);
        },
      ),
    );
  }

  void openHotelDetailScreen(String hotelId) {
    final hotelArgument = HotelDetailArgument.getBookingArgument(
      hotelId: hotelId,
      cityId: cityId!,
      countryId: countryId!,
      bookingViewData: _otaSearchUtil!.getBookingData()!,
      userType: _loginModel.userType.getHotelDetailType(),
    );

    Navigator.pushNamed(context, AppRoutes.hotelDetail,
        arguments: hotelArgument);
  }

  void onTapSearch() async {
    HotelSearchInputParameters.isFromSearch = true;
    if (_arguments!.pageType == PageType.search) {
      _filterArgument = await Navigator.pushNamed(
          context, AppRoutes.filterScreen,
          arguments: _filterArgument ??
              FilterArgument.fromHotelDetailArguments(
                  HotelDetailArgument.getDefaulArgument(
                      name, cityId, countryId),
                  pushScreen: AppRoutes.hotelListView)) as FilterArgument;

      _otaSearchUtil?.updateFilterArgument(_filterArgument!);
      _getSearchData();
    } else if (_arguments != null && _arguments!.pageType == PageType.hotel) {
      if (_filterArgument != null) {
        _filterArgument!.pushScreen = AppRoutes.hotelListView;
      }
      final updateFilterArguemnt = await Navigator.of(context)
              .pushNamed(AppRoutes.filterScreen, arguments: _filterArgument)
          as FilterArgument?;
      if (updateFilterArguemnt != null) {
        _otaSearchUtil?.updateFilterArgument(updateFilterArguemnt);
        _getSearchData(isFilterLoading: true);
        if (_filterArgument != null) {
          _filterArgument!.checkInDate = updateFilterArguemnt.checkInDate;
          _filterArgument!.checkOutDate = updateFilterArguemnt.checkOutDate;
          _filterArgument!.roomList = updateFilterArguemnt.roomList;
        }
      }
    }
  }

  void _useOtaSearchFilter(FilterResult? filterResult) {
    HotelSearchInputParameters.isFromSearch = false;
    Navigator.pushNamed(context, AppRoutes.filterOtaPage,
        arguments: FilterOtaArgumentModel(
          initialFilterOtaArgumentData: _filterOtaArgumentData?.copy(),
          promotions: filterResult?.capsulePromotion ?? [],
          sha: filterResult?.sha ?? [],
          onSearchClicked: (updatedFilterOtaArgumentData) {
            _otaSearchUtil!.updateFilterData(updatedFilterOtaArgumentData);
            _filterOtaArgumentData = updatedFilterOtaArgumentData;
            _getSearchData(isFilterLoading: true);
          },
        ));
  }

  void _initFilterData(FilterResult filterResult) {
    _filterOtaArgumentData = FilterOtaArgumentData(
        startingPrice: filterResult.minPrice,
        maximumPrice: filterResult.maxPrice);
  }

  Future<void> _onRefresh() async {
    _getSearchData(isRefresh: true);
  }

  Widget _buildMainWidget() {
    switch (_otaSearchBloc.state.pageState) {
      case OtaSearchViewPageState.preLoaded:
      case OtaSearchViewPageState.success:
        return _buildResultList();
      case OtaSearchViewPageState.failure:
      case OtaSearchViewPageState.internetFailure:
        return _otaSearchBloc.isHotelListEmpty
            ? _buildFailureWidget
            : _buildResultList();
      case OtaSearchViewPageState.empty:
        return _otaSearchBloc.isHotelListEmpty
            ? _buildEmptyWidget
            : _buildResultList();
      default:
        return _buildResultList();
    }
  }

  Widget get _buildFailureWidget => Padding(
        padding: const EdgeInsets.only(top: kSize24),
        child: Material(
          child: OtaNetworkErrorWidgetWithRefresh(
            height: MediaQuery.of(context).size.height - _kTopHeight,
            onRefresh: () => _onRefresh(),
          ),
        ),
      );

  Widget get _buildEmptyWidget => Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, kSize24),
          child: Center(
            child: OtaSearchNoResultWidget(
              errorTextFooter: getTranslated(
                  context, AppLocalizationsStrings.errorNoRoomsAvailable),
            ),
          ),
        ),
      );

  Widget _getCardBottomBar(HotelListResult hotelListResult) {
    return _isHotelSoldOut(hotelListResult)
        ? Container(
            padding: const EdgeInsets.only(top: kSize8),
            alignment: Alignment.topRight,
            child: Text(
              getTranslated(context, AppLocalizationsStrings.soldOutLabel),
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
            ),
          )
        : OtaDiscountPriceWidget(
            pricePerNight: hotelListResult.pricePerNight ?? 0,
            totalAmount: hotelListResult.totalPrice ?? 0,
            percentageDiscount: hotelListResult.maxDiscount?.toInt(),
            priceBeforeDiscount: hotelListResult.priceWithoutDiscount);
  }

  bool _isHotelSoldOut(HotelListResult hotelListResult) {
    return hotelListResult.hotelId == _arguments?.filterArgument?.hotelId &&
        hotelListResult.totalPrice == 0.0;
  }

  void _triggerFirebaseEvent(String eventName,
      [HotelListResult? hotel, int? index]) {
    FirebaseLogger logger = FirebaseLogger();

    FilterData? filter = _otaSearchUtil!.getArguments().hotelData?.filterData;
    List<HotelListResult>? list =
        _otaSearchBloc.state.data?.hotelView?.hotelList ?? [];

    logger.addKeyValue(
        key: HotelSearchResultFirebase.hotelKeywordSearch,
        value: _arguments?.filterArgument?.name);
    logger.addKeyValue(
        key: HotelSearchResultFirebase.hotelDestinationId,
        value: _arguments?.filterArgument?.cityId);
    logger.addKeyValue(
        key: HotelSearchResultFirebase.hotelDestinationName,
        value: HotelSearchInputParameters.hotelDestination);
    logger.addDateValue(
        key: HotelSearchResultFirebase.hotelStartDate,
        value: Helpers()
            .parseDateTime(_arguments?.filterArgument?.checkInDate ?? ''));
    logger.addDateValue(
        key: HotelSearchResultFirebase.hotelEndDate,
        value: Helpers()
            .parseDateTime(_arguments?.filterArgument?.checkOutDate ?? ''));
    logger.addIntValue(
        key: HotelSearchResultFirebase.hotelNumberAdult,
        value: _otaSearchUtil!.numAdult);
    logger.addIntValue(
        key: HotelSearchResultFirebase.hotelNumberChild,
        value: _otaSearchUtil!.numChild);
    logger.addIntValue(
        key: HotelSearchResultFirebase.hotelNumberRoom,
        value: _otaSearchUtil!.roomNumber);
    logger.addIntValue(
        key: HotelSearchResultFirebase.hotelNumberNight,
        value: Helpers.daysBetween(
            start: _arguments?.filterArgument?.checkInDate ?? '',
            end: _arguments?.filterArgument?.checkOutDate ?? ''));
    logger.addIntValue(
        key: HotelSearchResultFirebase.hotelSearchSuccess,
        value: list.isEmpty ? 0 : 1);
    logger.addCommaSeparatedList(
        value: _getHotelIdsList(list),
        key: HotelSearchResultFirebase.hotelShow);

    //when select any card
    if (hotel != null && eventName == FirebaseEvent.hotelSearchResultSelect) {
      logger.addIntValue(
          key: HotelSearchResultFirebase.hotelSequence, value: index! + 1);
      logger.addKeyValue(
          key: HotelSearchResultFirebase.hotelId, value: hotel.hotelId);
      logger.addKeyValue(
          key: HotelSearchResultFirebase.hotelName, value: hotel.hotelName);
      logger.addDoubleValue(
          key: HotelSearchResultFirebase.hotelPricePerNight,
          value: hotel.pricePerNight);
      logger.addDoubleValue(
          key: HotelSearchResultFirebase.hotelTotalPrice,
          value: hotel.totalPrice);
      logger.addKeyWithPercentValue(
          key: HotelSearchResultFirebase.hotelDiscountPercent,
          value: hotel.maxDiscount != null ? hotel.maxDiscount.toString() : '');
      logger.addKeyValue(
          key: HotelSearchResultFirebase.hotelPromotionTag,
          value: hotel.capsulePromotions.toString());
      logger.addCommaSeparatedList(
          value: _getHotelIdsList(list),
          key: HotelSearchResultFirebase.hotelShow);
    }
    logger.addDoubleValue(
        key: HotelSearchResultFirebase.hotelFilterPriceMin,
        value: filter?.minPrice != null ? filter?.minPrice?.toDouble() : 0.00);
    logger.addDoubleValue(
        key: HotelSearchResultFirebase.hotelFilterPriceMax,
        value: filter?.maxPrice != null ? filter?.maxPrice?.toDouble() : 0.00);
    logger.addKeyValue(
        key: HotelSearchResultFirebase.hotelFilterStandard,
        value: filter?.sha != null ? filter?.sha.toString() : '');
    logger.addKeyValue(
        key: HotelSearchResultFirebase.hotelFilterStar,
        value: filter?.rating != null ? filter?.rating.toString() : '');

    logger.publishToSuperApp(eventName);
  }

  void _hotelSearchSuccess() {
    List<HotelListResult> list =
        _otaSearchBloc.state.data?.hotelView?.hotelList ?? [];
    FirebaseHelper.addIntValue(
        eventName: FirebaseEvent.hotelSearchInput,
        key: HotelSearchInputParameters.hotelSearchSuccess,
        value: list.isNotEmpty ? 1 : 0);

    if (HotelSearchInputParameters.isFromSearch) {
      FirebaseHelper.stopCapturingEvent(FirebaseEvent.hotelSearchInput);
    }
  }

  List<String> _getHotelIdsList(List<HotelListResult>? hotelListResult) {
    List<String> listOfHotelIds = [];
    if (hotelListResult != null) {
      for (int i = 0; i < hotelListResult.length; i++) {
        listOfHotelIds.add(hotelListResult[i].hotelId ?? '');
      }
      return listOfHotelIds;
    }
    return [];
  }
}
