import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_page_error_widget.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/bloc/tour_filter_bloc.dart';
import 'package:ota/modules/tours/tour_search/search_filter/helper/tour_filter_helper.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_chip_button/tour_filter_view_more_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_package_drop_off_location_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_live_wrap_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_argument.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

const double _kAppBarHeight = 79;

class TourSearchFilterScreen extends StatefulWidget {
  const TourSearchFilterScreen({Key? key}) : super(key: key);

  @override
  TourSearchFilterScreenState createState() => TourSearchFilterScreenState();
}

class TourSearchFilterScreenState extends State<TourSearchFilterScreen> {
  final TourFilterSortController _filterSortController =
      TourFilterSortController();
  final SliderController _sliderController = SliderController();
  final TourFilterViewMoreController _viewMoreController =
      TourFilterViewMoreController();
  final TourFilterBloc _bloc = TourFilterBloc();
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  TourSearchFilterArgument? _argument;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _argument = ModalRoute.of(context)?.settings.arguments
          as TourSearchFilterArgument?;
      _bloc.getScreenData(_argument);
    });
    super.initState();
    _bloc.stream.listen(
      (event) {
        if (_bloc.state.pageState ==
            TourSearchFilterPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.sortAndFilter),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return BlocBuilder(
      bloc: _bloc,
      builder: () {
        switch (_bloc.state.pageState) {
          case TourSearchFilterPageState.success:
            return _successWidget();
          case TourSearchFilterPageState.initial:
            return _defaultWidget();
          case TourSearchFilterPageState.loading:
            return _loadIngWidget();
          case TourSearchFilterPageState.failure:
          case TourSearchFilterPageState.internetFailure:
            return _failureReviewState();
        }
      },
    );
  }

  Widget _defaultWidget() {
    return const SizedBox();
  }

  Widget _loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Widget _failureReviewState() {
    return FavouritesPageErrorWidgetWithRefresh(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async => _refreshPage(),
    );
  }

  void _refreshPage() {
    _bloc.makeAnApiCallIfNoDataFound(_argument);
  }

  Widget _successWidget() {
    var value = MediaQuery.of(context).padding.bottom;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSize100 + value),
          child: ListView(
            padding: const EdgeInsets.symmetric(
                vertical: kSize16, horizontal: kSize24),
            children: _getChildrenWidget(),
          ),
        ),
        _getBottomBar(),
      ],
    );
  }

  List<Widget> _getChildrenWidget() {
    List<Widget> childrenList = [];
    TourSearchFilterData data = _bloc.state.data!;

    //Drop Down
    if (data.sortInfo != null && data.sortInfo!.isNotEmpty) {
      childrenList.add(_getHeading(
          getTranslated(context, AppLocalizationsStrings.sortByFilter)));
      childrenList.add(const SizedBox(height: kSize8));
      childrenList.add(_getDropDown(data.sortInfo!));
      childrenList.add(const SizedBox(height: kSize24));
    }

    if (data.categoryInfo != null && data.categoryInfo!.isNotEmpty) {
      childrenList.add(_getHeading(
          getTranslated(context, AppLocalizationsStrings.filterBy)));
      for (TourFilterCategoryViewModel categoryFilter in data.categoryInfo!) {
        //Price Slider
        if (categoryFilter.categoryKey == TourFilterHelperConst.criteriaPrice &&
            _bloc.state.data!.minPrice != null &&
            _bloc.state.data!.maxPrice != null) {
          childrenList.add(const SizedBox(height: kSize16));
          childrenList.add(_getBody(
              getTranslated(context, AppLocalizationsStrings.priceRange)));
          if (categoryFilter.description != null) {
            childrenList.add(const SizedBox(height: kSize2));
            childrenList.add(_getDescription(categoryFilter.description!));
          }
          childrenList.add(const SizedBox(height: kSize8));
          childrenList.add(_getPriceRangeWidget());
          childrenList.add(_getSlider());
          childrenList.add(const SizedBox(height: kSize24));
        }
        ////Style chips
        else if (categoryFilter.categoryKey ==
                TourFilterHelperConst.criteriaStyle &&
            _bloc.state.data!.styleList != null &&
            _bloc.state.data!.styleList!.isNotEmpty) {
          childrenList.add(_getBody(getTranslated(
              context, AppLocalizationsStrings.tourFilterInterests)));
          if (categoryFilter.description != null) {
            childrenList.add(const SizedBox(height: kSize2));
            childrenList.add(_getDescription(getTranslated(
                context, AppLocalizationsStrings.tourFilterSelectOneOrMore)));
          }
          childrenList.add(const SizedBox(height: kSize16));
          childrenList.add(_buildChipList());
          childrenList.add(const SizedBox(height: kSize8));
        }
      }
    }

    return childrenList;
  }

  Widget _getHeading(String heading) {
    return Text(heading, style: AppTheme.kHeading1Medium);
  }

  Widget _getBody(String bodyText) {
    return Text(bodyText, style: AppTheme.kHBody);
  }

  Widget _getDescription(String discriptionText) {
    return Text(discriptionText,
        style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50));
  }

  Widget _getDropDown(List<TourFilterCategoryViewModel> sortCategoryList) {
    _filterSortController.updateChosenOption(TourFilterHelper.getSelectedIndex(
        _bloc.state.data!.selectedSortInfo!, _bloc.state.data!.sortInfo!));
    return TourFilterSortWidget(
      labelList: sortCategoryList,
      tourFilterSortController: _filterSortController,
      onPressed: (chosenOption) {
        _filterSortController.updateChosenOption(chosenOption);
        _bloc.onSortIndexChanged(chosenOption);
      },
    );
  }

  Widget _getPriceRangeWidget() {
    _sliderController.updateRange(RangeValues(
        _bloc.state.data!.rangeMinPrice!, _bloc.state.data!.rangeMaxPrice!));
    return BlocBuilder(
      bloc: _sliderController,
      builder: () {
        return Row(
          children: [
            Text(
              _currencyUtil
                  .getFormattedPrice(_bloc.state.data!.rangeMinPrice!.round()),
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGreyScale),
            ),
            const Spacer(),
            Text(
              _currencyUtil
                  .getFormattedPrice(_bloc.state.data!.rangeMaxPrice!.round()),
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGreyScale),
            ),
          ],
        );
      },
    );
  }

  Widget _getSlider() {
    return OtaSlider(
      min: _bloc.state.data!.minPrice!,
      max: _bloc.state.data!.maxPrice!,
      sliderController: _sliderController,
      onChanged: (value) {
        if (value.start == value.end) {
          return;
        }
        _bloc.updateSliderValue(value);
        _sliderController.updateRange(value);
      },
    );
  }

  Widget _buildChipList() {
    return BlocBuilder(
      bloc: _viewMoreController,
      builder: () {
        return TourLiveWrapViewWidget(
          styleList: _bloc.state.data!.styleList!,
          getMoreView: () {
            return _getViewMoreText();
          },
          getStyleView: (Widget widget) {
            return Container(
              constraints: BoxConstraints(
                  maxHeight: _viewMoreController.state.visibleHeight),
              child: widget,
            );
          },
        );
      },
    );
  }

  Widget _getViewMoreText() {
    return BlocBuilder(
      bloc: _viewMoreController,
      builder: () {
        return Padding(
          padding: _viewMoreController.isExpanded()
              ? const EdgeInsets.only(top: kSize8)
              : const EdgeInsets.only(top: kSize2),
          child: Row(
            children: [
              OtaGradientTextWidget(
                text: _viewMoreController.isExpanded()
                    ? getTranslated(
                        context, AppLocalizationsStrings.seeLessFilter)
                    : getTranslated(
                        context, AppLocalizationsStrings.seeAllFilter),
                style: AppTheme.kButton,
                onTap: () {
                  _viewMoreController.viewMoreToggle();
                },
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget _getBottomBar() {
    return OtaBottomButtonBar(
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.tourFilterReset),
        onPressed: () {
          _bloc.resetEverything(_sliderController);
          if (_argument!.serviceType == TourSearchServiceType.tour) {
            _argument!.tourModel = _bloc.state.data;
          } else if (_argument!.serviceType == TourSearchServiceType.tickets) {
            _argument!.ticketModel = _bloc.state.data;
          }
        },
        backgroundColor: Colors.transparent,
        fontColor: AppColors.kGradientStart,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient1.createShader(Offset.zero & bounds.size);
          },
          child: Text(
            getTranslated(context, AppLocalizationsStrings.tourFilterReset),
            style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      button2: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.tourFilterSearch),
        child: Text(
          getTranslated(context, AppLocalizationsStrings.tourFilterSearch),
          style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          if (_argument!.serviceType == TourSearchServiceType.tour) {
            _argument!.tourModel = _bloc.state.data;
          } else if (_argument!.serviceType == TourSearchServiceType.tickets) {
            _argument!.ticketModel = _bloc.state.data;
          }
          Navigator.pop(context, _argument);
        },
      ),
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
    );
  }
}
