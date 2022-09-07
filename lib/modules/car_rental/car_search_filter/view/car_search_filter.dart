import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_matching_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/widget/car_custom_error_widget.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/bloc/car_search_filter_bloc.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/filter_selection_button.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/price_range_slider.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_controllder.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_filter.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';

import 'widget/multi_selection_filter_widget/multi_selection_filter.dart';
import 'widget/multi_selection_filter_widget/multi_selection_filter_controller.dart';
import 'widget/multi_selection_filter_widget/multi_selection_filter_model.dart';

const double _kTopHeight = 180;
const int _kMaxLines = 1;
const String _kDefaultSort = 'rbh_suggest';

class CarSearchFilter extends StatefulWidget {
  const CarSearchFilter({Key? key}) : super(key: key);

  @override
  CarSearchFilterState createState() => CarSearchFilterState();
}

class CarSearchFilterState extends State<CarSearchFilter> {
  final CarSearchFilterBloc _carSearchFilterBloc = CarSearchFilterBloc();
  final SortByController _sortByController = SortByController();
  final MultiSelectionFilterController _promotionController =
      MultiSelectionFilterController();
  final MultiSelectionFilterController _carTypeController =
      MultiSelectionFilterController();
  final MultiSelectionFilterController _carBrandController =
      MultiSelectionFilterController();
  final MultiSelectionFilterController _carSupplierController =
      MultiSelectionFilterController();
  final SliderController _sliderController = SliderController();
  CarSearchFilterArgumentViewModel? _arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _arguments = ModalRoute.of(context)?.settings.arguments
          as CarSearchFilterArgumentViewModel;
      _setArgumentModel();
      _getCarSearchFilterData();
    });

    _carSearchFilterBloc.stream.listen((event) {
      if (_carSearchFilterBloc.state.pageState ==
          CarSearchFilterPageState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  _setArgumentModel() {
    if (_arguments?.selectedFilter?.sortByValue != null) {
      _sortByController.state.sortInfo =
          _arguments!.selectedFilter!.sortByValue!;
    }
    _promotionController.state.selectedFilterIds =
        _arguments?.selectedFilter?.promotionCodes ?? [];
    _sliderController.state.rangeValues = RangeValues(
      _arguments?.selectedFilter?.minPrice ??
          _arguments?.availableFilterViewModel?.minPrice ??
          0,
      _arguments?.selectedFilter?.maxPrice ??
          _arguments?.availableFilterViewModel?.maxPrice ??
          0,
    );
    _carTypeController.state.selectedFilterIds =
        _arguments?.selectedFilter?.carType ?? [];
    _carTypeController.state.viweState = _getSelectionViewState(
        _arguments?.availableFilterViewModel?.carType ?? []);
    _carBrandController.state.selectedFilterIds =
        _arguments?.selectedFilter?.carBrand ?? [];
    _carBrandController.state.viweState = _getSelectionViewState(
        _arguments?.availableFilterViewModel?.carBrand ?? []);
    _carSupplierController.state.selectedFilterIds =
        _arguments?.selectedFilter?.carSupplier ?? [];
    _carSupplierController.state.viweState = _getSelectionViewState(
        _arguments?.availableFilterViewModel?.carSupplier ?? []);
  }

  SelectionViewState _getSelectionViewState(List<FilterViewModel> filterList) {
    double totalCapsuleWidth = 0;
    double screenSpace = MediaQuery.of(context).size.width - kSize48;
    double totalCapsuleSpace = (filterList.length - 1) * kSize16;
    for (FilterViewModel filter in filterList) {
      totalCapsuleWidth += _getCapsuleWidth(text: filter.name ?? '');
    }
    double totalWidgetWidth = (totalCapsuleSpace + totalCapsuleWidth);
    return totalWidgetWidth > (screenSpace * 3)
        ? SelectionViewState.collapsed
        : SelectionViewState.none;
  }

  double _getCapsuleWidth({required String text}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTheme.kSmallRegular,
      ),
      maxLines: _kMaxLines,
      textDirection: TextDirection.ltr,
    )..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
    return textPainter.size.width + kSize16;
  }

  _getCarSearchFilterData() async {
    await _carSearchFilterBloc.getCarSearchFilterData(arguments: _arguments);
    List<CriterionModel>? sortInfo =
        _carSearchFilterBloc.state.carSearchFilter?.sortInfo ?? [];

    if (sortInfo.isNotEmpty && _sortByController.state.sortInfo == null) {
      final index = _carSearchFilterBloc.state.carSearchFilter!.sortInfo!
          .indexWhere((element) => element.value == _kDefaultSort);
      _sortByController.setInitialSort(
          _carSearchFilterBloc.state.carSearchFilter!.sortInfo![index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.sortAndFilter),
      ),
      body: BlocBuilder(
        bloc: _carSearchFilterBloc,
        builder: () {
          return _buildStateView();
        },
      ),
    );
  }

  Widget _buildStateView() {
    switch (_carSearchFilterBloc.state.pageState) {
      case CarSearchFilterPageState.noFilterData:
        return OtaNoMatchingResultWidget(
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
          errorTextFooter: getTranslated(
              context, AppLocalizationsStrings.informationNotAvialable),
        );
      case CarSearchFilterPageState.loading:
        return const OTALoadingIndicator();
      case CarSearchFilterPageState.noFilterValue:
        return CarCustomErrorWidgetWithRefresh(
          onRefresh: () => _getCarSearchFilterData(),
          height: MediaQuery.of(context).size.height - _kTopHeight,
          errorTextHeader:
              getTranslated(context, AppLocalizationsStrings.sorry),
          errorTextFooter: getTranslated(
              context, AppLocalizationsStrings.informationNotAvialable),
        );
      case CarSearchFilterPageState.failureNetwork:
        return OtaNetworkErrorWidgetWithRefresh(
          onRefresh: () => _getCarSearchFilterData(),
          height: MediaQuery.of(context).size.height - _kTopHeight,
        );
      case CarSearchFilterPageState.failure:
        return OtaNetworkErrorWidgetWithRefresh(
          onRefresh: () => _getCarSearchFilterData(),
          height: MediaQuery.of(context).size.height - _kTopHeight,
        );
      case CarSearchFilterPageState.success:
        return _buildSuccessView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSuccessView() {
    ///TODO: Not in the current scope.
    // List<FilterViewModel>? promotionList =
    //     _arguments?.availableFilterViewModel?.promotionList ?? [];
    List<FilterViewModel>? carBrand =
        _arguments?.availableFilterViewModel?.carBrand ?? [];
    List<FilterViewModel>? carSupplier =
        _arguments?.availableFilterViewModel?.carSupplier ?? [];
    List<FilterViewModel>? carType =
        _arguments?.availableFilterViewModel?.carType ?? [];
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            children: [
              SortByFilterBox(
                sortByController: _sortByController,
                sortInfo:
                    _carSearchFilterBloc.state.carSearchFilter?.sortInfo ?? [],
              ),
              if (_arguments?.availableFilterViewModel?.maxPrice != 0)
                Padding(
                  padding: const EdgeInsets.only(top: kSize24, bottom: kSize16),
                  child: Text(
                    getTranslated(context, AppLocalizationsStrings.filterBy),
                    overflow: TextOverflow.ellipsis,
                    maxLines: _kMaxLines,
                    style: AppTheme.kHeading1Medium,
                  ),
                ),

              ///TODO: Not in the current scope.
              // if (_carSearchFilterBloc.isPromotionFilterAvailable &&
              //     promotionList.isNotEmpty)
              //   MultiSelectionFilter(
              //     title:
              //         getTranslated(context, AppLocalizationsStrings.promotion),
              //     filterModel: promotionList,
              //     multiSelectionFilterController: _promotionController,
              //     spacePadding: kSize12,
              //     bottomPadding: kSize16,
              //   ),
              if (_arguments?.availableFilterViewModel?.maxPrice != 0)
                PriceRangeSlider(
                  minPrice: _arguments?.availableFilterViewModel?.minPrice ?? 0,
                  maxPrice: _arguments?.availableFilterViewModel?.maxPrice ?? 1,
                  sliderController: _sliderController,
                ),
              if (_carSearchFilterBloc.isCarTypeFilterAvailable &&
                  carType.isNotEmpty)
                MultiSelectionFilter(
                  isCarType: _carSearchFilterBloc.isCarTypeFilterAvailable,
                  title:
                      getTranslated(context, AppLocalizationsStrings.carType),
                  description: getTranslated(context,
                      AppLocalizationsStrings.youCanSelectMoreThanOneItem),
                  filterModel: carType,
                  multiSelectionFilterController: _carTypeController,
                ),
              if (_carSearchFilterBloc.isCarBrandFilterAvailable &&
                  carBrand.isNotEmpty)
                MultiSelectionFilter(
                  isBrand: _carSearchFilterBloc.isCarBrandFilterAvailable,
                  title:
                      getTranslated(context, AppLocalizationsStrings.carBrand),
                  description: getTranslated(context,
                      AppLocalizationsStrings.youCanSelectMoreThanOneItem),
                  filterModel: carBrand,
                  multiSelectionFilterController: _carBrandController,
                ),
              if (_carSearchFilterBloc.isCarSupplierFilterAvailable &&
                  carSupplier.isNotEmpty)
                MultiSelectionFilter(
                  isSupplier: _carSearchFilterBloc.isCarSupplierFilterAvailable,
                  title: getTranslated(
                      context, AppLocalizationsStrings.serviceProvider),
                  description: getTranslated(context,
                      AppLocalizationsStrings.youCanSelectMoreThanOneItem),
                  filterModel: carSupplier,
                  multiSelectionFilterController: _carSupplierController,
                ),
            ],
          ),
        ),
        FilterSelectionButton(
          onResetPressed: () => _resetFilter(),
          onSearchPressed: () => _searchFilteredData(),
        ),
      ],
    );
  }

  _searchFilteredData() {
    Navigator.of(context).pop(
      FilterValue(
        sortByValue: _sortByController.state.sortInfo,
        promotionCodes: _promotionController.state.selectedFilterIds,
        minPrice: _sliderController.state.rangeValues.start,
        maxPrice: _sliderController.state.rangeValues.end,
        carType: _carTypeController.state.selectedFilterIds,
        carBrand: _carBrandController.state.selectedFilterIds,
        carSupplier: _carSupplierController.state.selectedFilterIds,
      ),
    );
  }

  _resetFilter() {
    List<CriterionModel>? sortInfo =
        _carSearchFilterBloc.state.carSearchFilter?.sortInfo ?? [];
    if (sortInfo.isNotEmpty) {
      _sortByController.setInitialSort(
          _carSearchFilterBloc.state.carSearchFilter!.sortInfo!.first);
    }
    _promotionController.resetState();
    _carTypeController.resetState();
    _carBrandController.resetState();
    _carSupplierController.resetState();
    _sliderController.updateRange(
      RangeValues(
        _arguments?.availableFilterViewModel?.minPrice ?? 0,
        _arguments?.availableFilterViewModel?.maxPrice ?? 0,
      ),
    );
  }
}
