import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/preferences/bloc/preferences_app_bar_bloc.dart';
import 'package:ota/modules/preferences/bloc/preferences_progress_bloc.dart';
import 'package:ota/modules/preferences/bloc/preferences_submit_bloc.dart';
import 'package:ota/modules/preferences/view/widgets/questionnaire_chip_view_widget.dart';
import 'package:ota/modules/preferences/view/widgets/questionnaire_grid_view_widget.dart';
import 'package:ota/modules/preferences/view/widgets/questionnaire_top_widget.dart';
import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';

const double _kExpandableMaxHeight = 72;
const double _kCollapsedViewElevation = 4.0;
const double _kBottomPadding = 76;
const int _kOpacityDuration = 100;
const _kGradientRotation = GradientRotation((47.99 * (22 / 7) / 180));
const Key _kKeyCollapsedView = Key('key_collapsed_view');
const Key _kKeyExpandedView = Key('key_expanded_view');
const String _kSubmitPreferencesButtonKey = "submit_preferences_button_key";

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final ScrollController _scrollController = ScrollController();
  final PreferencesAppBarBloc _appBarBloc = PreferencesAppBarBloc();
  final PreferencesProgressBloc _progressBloc = PreferencesProgressBloc();
  final PreferencesSubmitBloc _submitBloc = PreferencesSubmitBloc();
  final OtaRadioOptionListBloc _gridViewSelectionBloc =
      OtaRadioOptionListBloc();
  final OtaRadioOptionListBloc _chipViewSelectionBloc =
      OtaRadioOptionListBloc();

  @override
  void dispose() {
    _appBarBloc.dispose();
    _progressBloc.dispose();
    _gridViewSelectionBloc.dispose();
    _chipViewSelectionBloc.dispose();
    _submitBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      _appBarBloc.setStatusOnScroll(_scrollController);
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _submitBloc.stream.listen(
        (event) {
          if (!_submitBloc.isLoading) {
            if (_submitBloc.isFailure) {
              _showSubmittionAlertDialog(
                  !_submitBloc.isRetryCountReached, context);
            } else if (_submitBloc.isSuccess) {
              Navigator.of(context).pop(true);
            }
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PreferencesArgumentModel>? argumentModelList = ModalRoute.of(context)
        ?.settings
        .arguments as List<PreferencesArgumentModel>;
    _progressBloc.initPreferences(argumentModelList);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildSliverAppBar(),
                _buildSliverList(),
                _buildQuestionnaireView(),
              ],
            ),
            _buildTopCollapedView(),
            _buildActionButton(context),
            BlocBuilder(
              bloc: _submitBloc,
              builder: () {
                if (_submitBloc.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      elevation: kSize0,
      leading: Padding(
        padding: const EdgeInsets.only(left: kSize14),
        child: _buildAppBar(),
      ),
      backgroundColor: AppColors.kWhiteColor,
      floating: false,
      pinned: true,
      toolbarHeight: kToolbarHeight,
      collapsedHeight: kToolbarHeight,
      expandedHeight: _kExpandableMaxHeight,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            Platform.isIOS ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            Platform.isIOS ? Brightness.light : Brightness.dark,
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _buildTopGradient(),
      ),
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Container(
          height: kSize24,
          decoration: const BoxDecoration(
            color: AppColors.kLight100,
            borderRadius: AppTheme.kBorderRadiusTop24,
          ),
        ),
      ),
    );
  }

  SliverList _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding:
                const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, kSize0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_buildQuestionAndProgressView(true)],
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  SliverPadding _buildQuestionnaireView() {
    return SliverPadding(
      padding:
          const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, _kBottomPadding),
      sliver: BlocBuilder(
        bloc: _progressBloc,
        builder: () {
          if (_progressBloc.isGridView) {
            return QuestionnaireGridViewWidget(
              key: Key(_progressBloc.currentQuestionNumber.toString()),
              otaRadioOptionListBloc: _gridViewSelectionBloc,
              isMultiChoice: _progressBloc.isMultiChoice,
              optionsModelList: _progressBloc.currentOptionList,
              onSelected: (index, selected) => _progressBloc
                  .updateCurrentQuestionOptionSelection(index, selected),
            );
          }
          return SliverToBoxAdapter(
            key: Key(_progressBloc.currentQuestionNumber.toString()),
            child: QuestionnaireChipViewWidget(
              optionsModelList: _progressBloc.currentOptionList,
              otaRadioOptionListBloc: _chipViewSelectionBloc,
              isMultiChoice: _progressBloc.isMultiChoice,
              imageUrl: _progressBloc.currentQuestionImageUrl,
              questionNumber: _progressBloc.currentQuestionNumber,
              onSelected: (index, selected) => _progressBloc
                  .updateCurrentQuestionOptionSelection(index, selected),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuestionAndProgressView(bool isExpandedView) {
    return BlocBuilder(
      bloc: _progressBloc,
      builder: () {
        return BlocBuilder(
            bloc: _appBarBloc,
            builder: () {
              return QuestionnaireTopWidget(
                key: isExpandedView ? _kKeyExpandedView : _kKeyCollapsedView,
                showProgressIndicator:
                    !(!_appBarBloc.isOpened() && isExpandedView),
                limit: _progressBloc.questionsCount,
                progress: _progressBloc.currentQuestionNumber,
                question: _progressBloc.currentQuestion,
                questionDescription: _progressBloc.currentQuestionDesc,
              );
            });
      },
    );
  }

  Widget _buildTopGradient() {
    return BlocBuilder(
      bloc: _appBarBloc,
      builder: () {
        return _appBarBloc.isOpened()
            ? Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.kGradientStartOpacity70,
                      AppColors.kGradientEndOpacity70,
                    ],
                    transform: _kGradientRotation,
                  ),
                ),
              )
            : Container(color: AppColors.kLight100);
      },
    );
  }

  Widget _buildTopCollapedView() {
    return BlocBuilder(
      bloc: _appBarBloc,
      builder: () {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: _kOpacityDuration),
          opacity: _appBarBloc.isOpened() ? kSize0 : kSize1,
          child: Material(
            elevation: _kCollapsedViewElevation,
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.fromLTRB(kSize24, kSize0, kSize24, kSize0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAppBar(),
                    _buildQuestionAndProgressView(false),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return BlocBuilder(
      bloc: _appBarBloc,
      builder: () {
        return IconButton(
          padding: EdgeInsets.zero,
          constraints:
              const BoxConstraints(minHeight: kMinInteractiveDimension),
          icon: const Icon(Icons.arrow_back_ios),
          color:
              _appBarBloc.isOpened() ? AppColors.kLight100 : AppColors.kGrey70,
          iconSize: kSize24,
          onPressed: () => _moveToPreviousQuestion(),
        );
      },
    );
  }

  Future<bool> _onWillPop() async => _moveToPreviousQuestion();

  bool _moveToPreviousQuestion() {
    if (_progressBloc.currentQuestionNumber != 1) {
      _progressBloc.moveToPreviousQuestion();
      return false;
    } else {
      Navigator.of(context).pop();
      NavigatorHelper.shouldSystemPop(context);
      return true;
    }
  }

  Widget _buildActionButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.kLight100,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: _kOpacityDuration),
          width: double.infinity,
          padding: const EdgeInsets.only(
              left: kSize24, right: kSize24, top: kSize16, bottom: kSize32),
          child: BlocBuilder(
            bloc: _progressBloc,
            builder: () {
              return OtaTextButton(
                key: const Key(_kSubmitPreferencesButtonKey),
                title: _progressBloc.isLastQuestion
                    ? getTranslated(
                        context, AppLocalizationsStrings.letsGoOnTrip)
                    : getTranslated(context, AppLocalizationsStrings.next),
                onPressed: () {
                  if (_progressBloc.isLastQuestion) {
                    _submitPreferenceData();
                  } else {
                    _progressBloc.moveToNextQuestion();
                  }
                },
                isDisabled: !_progressBloc.isCurrentQuestionOptionSelected,
              );
            },
          ),
        ),
      ),
    );
  }

  void _submitPreferenceData() {
    _submitBloc.submitPreferencesData(_progressBloc.state.preferenceModelList);
  }

  void _showSubmittionAlertDialog(bool isTryAgain, BuildContext context) {
    OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(
          context,
          isTryAgain
              ? AppLocalizationsStrings.unbaleToSubmitTryAgain
              : AppLocalizationsStrings.unbaleToSubmitSkip),
      buttonTitle: getTranslated(
        context,
        isTryAgain ? AppLocalizationsStrings.ok : AppLocalizationsStrings.skip,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        isTryAgain ? _submitPreferenceData() : Navigator.of(context).pop(false);
      },
    ).showAlertDialog(context);
  }
}
