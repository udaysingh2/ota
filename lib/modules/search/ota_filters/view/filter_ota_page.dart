import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_page_error_widget.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_view_model.dart';
import 'package:ota/modules/search/ota_filters/bloc/filter_ota_bloc.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/custom_ota_search_sort_sheet.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/drop_down_static.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/promotions_button.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/star_button.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_view_model.dart';

const double _kMaximumPrice = 100;
const double _kStartingPrice = 1;
const EdgeInsets _kTotalPadding = EdgeInsets.only(left: 24, right: 24);
const double _kHeaderTopPadding = 16;
const double _kHeaderBottomPadding = 8;
const double _kBigSpace = 24;
const double _kStarSpacing = 8;
const double _kAppBarHeight = 79;

class FilterOtaPage extends StatefulWidget {
  const FilterOtaPage({Key? key}) : super(key: key);

  @override
  FilterOtaPageState createState() => FilterOtaPageState();
}

class FilterOtaPageState extends State<FilterOtaPage> {
  FilterOtaBloc filterOtaBloc = FilterOtaBloc();
  SliderController sliderController = SliderController();

  void loadFromArgument() {
    FilterOtaArgumentModel? argumentModel =
        ModalRoute.of(context)?.settings.arguments as FilterOtaArgumentModel;
    filterOtaBloc.mapFromArgument(argumentModel);
    sliderController.updateRange(RangeValues(
        filterOtaBloc.state.rangeStaringPrice?.toDouble() ?? _kStartingPrice,
        filterOtaBloc.state.rangeEndingPrice?.toDouble() ?? _kMaximumPrice));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      loadFromArgument();
    });
    super.initState();
    filterOtaBloc.stream.listen(
      (event) {
        if (filterOtaBloc.state.filterOtaViewPageState ==
            FilterOtaViewPageState.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLight100,
      appBar: OtaAppBar(
        title: getTranslated(context, AppLocalizationsStrings.sortAndFilter),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return BlocBuilder(
      bloc: filterOtaBloc,
      builder: () {
        switch (filterOtaBloc.state.filterOtaViewPageState) {
          case FilterOtaViewPageState.initial:
          case FilterOtaViewPageState.success:
            return _successWidget();
          case FilterOtaViewPageState.loading:
            return _loadIngWidget();
          case FilterOtaViewPageState.failure:
          case FilterOtaViewPageState.internetFailure:
            return _failureReviewState();
          default:
            return _defaultWidget();
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
    loadFromArgument();
  }

  Widget _successWidget() {
    return Stack(children: [
      SafeArea(
        minimum: const EdgeInsets.only(bottom: kSize100),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: _kTotalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:
                _getFilterScreenWidget(filterOtaBloc.state.filterCriteriaList),
          ),
        ),
      ),
      OtaBottomButtonBar(
        safeAreaBottom: false,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize32),
        spaceBetweenButton: kSize32,
        isExpandedRightButton: true,
        button1: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.reset),
          backgroundColor: AppColors.kLight100,
          fontColor: AppColors.kGradientStart,
          onPressed: () {
            filterOtaBloc.resetEverything(sliderController);
          },
        ),
        button2: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.searchLabel),
          onPressed: () {
            if ((filterOtaBloc.state.listOfSortString?.length ?? 0) > 0) {
              filterOtaBloc.onSearchClicked();
              Navigator.pop(context);
            }
          },
        ),
        containerHeight: kSize92,
      ),
    ]);
  }

  List<Widget> _getFilterScreenWidget(
      List<FilterCriteriaViewModel>? filterList) {
    List<Widget> filterCriteriaList = [];
    bool isSliderVisible = (_isSliderVisible(
      maxPrice: filterOtaBloc.state.maximumPrice?.toDouble() ?? 1,
      startPrice: filterOtaBloc.state.startingPrice?.toDouble() ?? 1,
    ));
    CurrencyUtil currencyUtil = CurrencyUtil();

    //Sort info
    filterCriteriaList.add(const SizedBox(height: _kHeaderTopPadding));
    filterCriteriaList.add(_getHeader(AppLocalizationsStrings.sortOf));
    filterCriteriaList.add(const SizedBox(height: _kHeaderBottomPadding));
    filterCriteriaList.add(
      GestureDetector(
        onTap: () {
          if (filterOtaBloc.state.listOfSortString?.isEmpty ?? true) {
            return;
          }
          CustomOtaSearchSortSheet().showCustomModelSheet(
              context,
              filterOtaBloc,
              getTranslated(context, AppLocalizationsStrings.sortOf));
        },
        child: BlocBuilder(
          bloc: filterOtaBloc,
          builder: () {
            return DropDownStatic(
              buttonText: filterOtaBloc.getSelectedSortingString(),
            );
          },
        ),
      ),
    );
    filterCriteriaList.add(const SizedBox(height: _kBigSpace));

    ///Criteria Filter
    if (filterList != null && filterList.isNotEmpty) {
      filterCriteriaList
          .add(_getHeader(AppLocalizationsStrings.reviewFilterTitle));
      filterCriteriaList.add(const SizedBox(height: _kHeaderTopPadding));

      for (FilterCriteriaViewModel filterCriteriaViewModel in filterList) {
        ///Promotion
        if (filterCriteriaViewModel.categoryKey == OtaCriteriaKey.promotion &&
            _arePromotionsVisible(filterOtaBloc.state.promotions)) {
          filterCriteriaList
              .add(_getBody(filterCriteriaViewModel.displayTitle));
          filterCriteriaList.add(const SizedBox(height: kSize8));
          filterCriteriaList.add(
            BlocBuilder(
              bloc: filterOtaBloc,
              builder: () {
                return Wrap(
                  alignment: WrapAlignment.start,
                  spacing: kSize16,
                  runSpacing: kSize8,
                  children: _promotionsFilter(filterOtaBloc.state.promotions,
                      filterOtaBloc.state.selectedPromotionsCodeSet ?? {},
                      (promotion) {
                    filterOtaBloc.selectPromotion(promotion);
                  }),
                );
              },
            ),
          );
          filterCriteriaList.add(const SizedBox(height: _kHeaderTopPadding));
        }

        ///Price
        if (filterCriteriaViewModel.categoryKey == OtaCriteriaKey.price &&
            isSliderVisible) {
          filterCriteriaList
              .add(_getBody(filterCriteriaViewModel.displayTitle));
          filterCriteriaList.add(const SizedBox(height: _kHeaderBottomPadding));
          filterCriteriaList.add(
            BlocBuilder(
              bloc: sliderController,
              builder: () {
                return Row(
                  children: [
                    Text(
                      currencyUtil.getFormattedPrice(
                          sliderController.state.rangeValues.start),
                      style: AppTheme.kBodyRegular
                          .copyWith(color: AppColors.kGrey50),
                    ),
                    const Spacer(),
                    Text(
                      currencyUtil.getFormattedPrice(
                          sliderController.state.rangeValues.end),
                      style: AppTheme.kBodyRegular
                          .copyWith(color: AppColors.kGrey50),
                    ),
                  ],
                );
              },
            ),
          );
          filterCriteriaList.add(
            OtaSlider(
              max: filterOtaBloc.state.maximumPrice?.toDouble() ?? 1,
              min: filterOtaBloc.state.startingPrice?.toDouble() ?? 1,
              onChanged: (value) {
                if (value.start == value.end) {
                  return;
                }
                filterOtaBloc.state.rangeStaringPrice = value.start.toInt();
                filterOtaBloc.state.rangeEndingPrice = value.end.toInt();
                sliderController.updateRange(value);
              },
              sliderController: sliderController,
            ),
          );
        }

        /// Star
        if (filterCriteriaViewModel.categoryKey == OtaCriteriaKey.star) {
          filterCriteriaList.add(const SizedBox(height: _kHeaderTopPadding));
          filterCriteriaList
              .add(_getBody(filterCriteriaViewModel.displayTitle));
          filterCriteriaList.add(const SizedBox(height: _kHeaderTopPadding));
          filterCriteriaList.add(
            BlocBuilder(
              bloc: filterOtaBloc,
              builder: () {
                return Row(
                  children: _starListFilter(
                      filterOtaBloc.state.starRating ?? {}, (index) {
                    filterOtaBloc.selectStar(index);
                  }),
                );
              },
            ),
          );
          filterCriteriaList.add(const SizedBox(height: _kBigSpace));
        }

        /// Sha
        if (filterCriteriaViewModel.categoryKey == OtaCriteriaKey.sha &&
            _shouldShowSHA(filterOtaBloc.state.sha)) {
          filterCriteriaList.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getBody(filterCriteriaViewModel.displayTitle),
                const SizedBox(height: _kHeaderTopPadding),
                BlocBuilder(
                  bloc: filterOtaBloc,
                  builder: () {
                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: kSize16,
                      runSpacing: kSize8,
                      children: _shaFilter(filterOtaBloc.state.sha,
                          filterOtaBloc.state.selectedSha ?? {}, (sha) {
                        filterOtaBloc.selectSha(sha);
                      }),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }
    }
    return filterCriteriaList;
  }

  bool _isSliderVisible(
      {required double maxPrice, required double startPrice}) {
    if (startPrice < maxPrice) return true;
    return false;
  }

  bool _arePromotionsVisible(List<CapsulePromotions> promotions) {
    if (promotions.isEmpty) return false;
    return true;
  }

  bool _shouldShowSHA(List<String> sha) {
    return (sha.isNotEmpty);
  }

  Widget _getHeader(String header) {
    return Text(
      getTranslated(context, header),
      style: AppTheme.kHeading1Medium,
    );
  }

  Widget _getBody(String body) {
    return Text(
      getTranslated(context, body),
      style: AppTheme.kBodyMedium,
    );
  }

  List<Widget> _starListFilter(
      Set<int> selectors, Function(int) onRatingClicked) {
    List<Widget> starLists = [];
    for (int i = 0; i < 5; i++) {
      starLists.add(
        StarButton(
          buttonText: (i + 1).toString(),
          onRatingClicked: () {
            onRatingClicked(i + 1);
          },
          isSelected: selectors.contains(i + 1),
        ),
      );
      if (i == 4) break;
      starLists.add(
        const SizedBox(
          width: _kStarSpacing,
        ),
      );
    }
    return starLists;
  }

  List<Widget> _promotionsFilter(List<CapsulePromotions> list,
      Set<String> selectors, Function(CapsulePromotions) onButtonClicked) {
    List<Widget> promotionsList = [];
    for (int i = 0; i < list.length; i++) {
      promotionsList.add(
        PromotionsButton(
          buttonText: list[i].name,
          onButtonClicked: () {
            onButtonClicked(list[i]);
          },
          isSelected: selectors.contains(list[i].code),
        ),
      );
    }
    return promotionsList;
  }

  List<Widget> _shaFilter(List<String> list, Set<String> selectors,
      Function(String) onButtonClicked) {
    List<Widget> shaList = [];
    for (int i = 0; i < list.length; i++) {
      shaList.add(
        PromotionsButton(
          buttonText: list[i],
          onButtonClicked: () {
            onButtonClicked(list[i]);
          },
          isSelected: selectors.contains(list[i]),
        ),
      );
    }
    return shaList;
  }
}
