import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_page_error_widget.dart';
import 'package:ota/modules/message_and_notification/bloc/news_bloc.dart';
import 'package:ota/modules/message_and_notification/bloc/receipt_bloc.dart';
import 'package:ota/modules/message_and_notification/view/widgets/chip_button_list.dart';
import 'package:ota/modules/message_and_notification/view/widgets/list_tile.dart';
import 'package:ota/modules/message_and_notification/view/widgets/message_empty_state.dart';
import 'package:ota/modules/message_and_notification/view/widgets/message_webview.dart';
import 'package:ota/modules/message_and_notification/view_model/message_and_notification_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

const double _kExtentRatio = 0.25;
const String _kCheckCircle = "assets/images/icons/uil_check-circle.svg";
const String _kExclamationCircle =
    "assets/images/icons/exclamation_circle1.svg";
// const _kEreceiptEmptyStateIcon = "assets/images/icons/ereceipt_empty_state.svg";
const _kNetworkErrorIcon = 'assets/images/icons/search_empty_error.svg';

class MessageAndNotificationScreen extends StatefulWidget {
  const MessageAndNotificationScreen({Key? key}) : super(key: key);

  @override
  MessageAndNotificationScreenState createState() =>
      MessageAndNotificationScreenState();
}

class MessageAndNotificationScreenState
    extends State<MessageAndNotificationScreen> {
  final OtaRadioOptionListBloc _otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final NewsBloc _newsBloc = NewsBloc();
  final ReceiptBloc _receiptBloc = ReceiptBloc();
  int _previousSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNewsData();
    });
    _receiptBloc.stream.listen((event) {
      if ((_receiptBloc.state.receiptState ==
                  MessageViewModelState.internetFailure ||
              _receiptBloc.state.receiptState ==
                  MessageViewModelState.internetFailureRefresh) &&
          !event.isInternetPopUpShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _receiptBloc.setInternetPopupShown();
      }
    });
    _newsBloc.stream.listen((event) {
      if ((_newsBloc.state.newsState == MessageViewModelState.internetFailure ||
              _newsBloc.state.newsState ==
                  MessageViewModelState.internetFailureRefresh) &&
          !event.isInternetPopupShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _newsBloc.setInternetPopupShown();
      }
    });
  }

  @override
  void dispose() {
    _newsBloc.dispose();
    _receiptBloc.dispose();
    _otaRadioOptionListBloc.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _otaRadioOptionListBloc.state.selectedIndex = 0;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OtaAppBar(
              title: getTranslated(context, AppLocalizationsStrings.messages),
              isCenterTitle: true,
            ),
            MessageAndNotificationChipButton(
              otaRadioOptionListBloc: _otaRadioOptionListBloc,
              onEReciptsTap: () {
                if (_previousSelectedIndex !=
                    _otaRadioOptionListBloc.state.selectedIndex) {
                  _previousSelectedIndex =
                      _otaRadioOptionListBloc.state.selectedIndex!;
                  _getReceiptData();
                  _newsBloc.resetInternetPopupShown();
                  _receiptBloc.resetInternetPopupShown();
                }
              },
              onNotificationTap: () {
                if (_previousSelectedIndex !=
                    _otaRadioOptionListBloc.state.selectedIndex) {
                  _previousSelectedIndex =
                      _otaRadioOptionListBloc.state.selectedIndex!;

                  _getNewsData();
                  _newsBloc.resetInternetPopupShown();
                  _receiptBloc.resetInternetPopupShown();
                }
              },
            ),
            BlocBuilder(
              bloc: _otaRadioOptionListBloc,
              builder: () {
                return Expanded(
                  child: _otaRadioOptionListBloc.state.selectedIndex == 0
                      ? _buildNewsScreen()
                      : _buildReceiptScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoInternetWidget(dynamic refreshFunction) {
    return FavouritesPageErrorWidgetWithRefresh(
        imageURL: _kNetworkErrorIcon,
        height: MediaQuery.of(context).size.height - kSize200,
        onRefresh: () => refreshFunction());
  }

  Widget _buildEmptyWidget(dynamic refreshFunction) {
    return MessageAndNotificationEmptyStateWithRefresh(
        height: MediaQuery.of(context).size.height - kSize200,
        onRefresh: () => refreshFunction());
  }

  Text _buildLoadingText(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.loading),
      style: AppTheme.kBody12,
    );
  }

  bool isNewDataNewsRequired(int index) {
    bool isLastIndex = index == (_newsBloc.state.newsList.length - 1);
    if (_newsBloc.isNewDataRequired) {
      return isLastIndex;
    }
    return false;
  }

  bool isNewDataReceiptRequired(int index) {
    bool isLastIndex = index == (_receiptBloc.state.receiptList.length - 1);
    if (_receiptBloc.isNewDataRequired) {
      return isLastIndex;
    }
    return false;
  }

  _getNewsData() async {
    _newsBloc.state.isInternetPopupShown = false;
    await _newsBloc.getNewsData();
  }

  _getReceiptData() async {
    _receiptBloc.state.isInternetPopUpShown = false;

    await _receiptBloc.getReceiptData();
  }

  void _onDeleteButtonPressed(int index, int chipIndex) {
    OtaAlertDialog(
      buttonTitle: getTranslated(context, AppLocalizationsStrings.cancel),
      errorMessage: getTranslated(
          context, AppLocalizationsStrings.confirmToDeleteMessage),
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.confirmToDeleteTitle),
      button2: true,
      button2Title: getTranslated(context, AppLocalizationsStrings.confirm),
      padding:
          const EdgeInsets.symmetric(horizontal: kSize30, vertical: kSize32),
      onPressedButton2: () {
        Navigator.of(context).pop();
        chipIndex == 0
            ? _confirmDeleteNews(index)
            : _confirmDeleteReceipt(index);
      },
    ).showAlertDialog(context);
  }

  void _confirmDeleteNews(int index) async {
    await _newsBloc.deleteNews(index);
    switch (_newsBloc.state.newsDeleteState) {
      case MessageDeleteState.deleteSuccessful:
        _showDeleteBannerSuccessful();
        break;
      case MessageDeleteState.deleteUnsuccessful:
        _showDeleteBannerUnSuccessful();
        break;
      case MessageDeleteState.internetFailure:
        OtaNoInternetAlertDialog().showAlertDialog(context);
        break;
      default:
        Navigator.of(context).pop();
    }
  }

  void _confirmDeleteReceipt(int index) async {
    await _receiptBloc.deleteReceipt(index);
    switch (_receiptBloc.state.receiptDeleteState) {
      case MessageDeleteState.deleteSuccessful:
        _showDeleteBannerSuccessful();
        break;
      case MessageDeleteState.deleteUnsuccessful:
        _showDeleteBannerUnSuccessful();
        break;
      case MessageDeleteState.internetFailure:
        OtaNoInternetAlertDialog().showAlertDialog(context);
        break;
      default:
        Navigator.of(context).pop();
    }
  }

  void _showDeleteBannerSuccessful() {
    OtaBanner().showMaterialBanner(
      context,
      getTranslated(context, AppLocalizationsStrings.deleteSuccess),
      AppColors.kSystemSuccess,
      _kCheckCircle,
    );
  }

  void _showDeleteBannerUnSuccessful() {
    OtaBanner().showMaterialBanner(
      context,
      getTranslated(context, AppLocalizationsStrings.deleteFailed),
      AppColors.kSystemWrong,
      _kExclamationCircle,
    );
  }

  void _openDeepLinkUrl(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  Widget _buildNewsScreen() {
    return BlocBuilder(
        bloc: _newsBloc,
        builder: () {
          bool isLoading =
              _newsBloc.state.newsState == MessageViewModelState.loading &&
                  _newsBloc.state.newsList.isEmpty;
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isFailure =
              (_newsBloc.state.newsState == MessageViewModelState.failure ||
                  _newsBloc.state.newsState ==
                      MessageViewModelState.internetFailure ||
                  _newsBloc.state.newsState ==
                      MessageViewModelState.internetFailureRefresh);
          bool isListEmpty = _newsBloc.state.newsList.isEmpty;
          if (isFailure) {
            if (isListEmpty) {
              return _buildNoInternetWidget(_getNewsData);
            } else {
              return _buildNewsPromotionTile();
            }
          } else {
            if (isListEmpty) {
              return _buildEmptyWidget(_getNewsData);
            } else {
              return _buildNewsPromotionTile();
            }
          }
        });
  }

  Widget _buildNewsPromotionTile() {
    return OtaRefreshIndicator(
      onRefresh: () => _getNewsData(),
      text: _buildLoadingText(context),
      child: ListView.builder(
        key: Key(_otaRadioOptionListBloc.state.selectedIndex.toString()),
        itemCount: _newsBloc.state.newsList.length,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (isNewDataNewsRequired(index)) {
            _newsBloc.setNewDataRequired();
            _newsBloc.getNewsData(refreshData: false);
          }
          return Column(
            children: [
              Slidable(
                endActionPane: ActionPane(
                  extentRatio: _kExtentRatio,
                  motion: const DrawerMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) {
                        _onDeleteButtonPressed(index,
                            _otaRadioOptionListBloc.state.selectedIndex ?? 0);
                      },
                      backgroundColor: AppColors.kSystemWrong,
                      child: Center(
                        child: Text(
                          getTranslated(
                              context, AppLocalizationsStrings.delete),
                          style: AppTheme.kBodyRegular
                              .copyWith(color: AppColors.kLoadingBackground),
                        ),
                      ),
                    ),
                  ],
                ),
                child: MessageListTile(
                  key: Key("messageNewsTile$index"),
                  iconWidth: kSize40,
                  title: _newsBloc.state.newsList[index].subject,
                  type: _newsBloc.state.newsList[index].category,
                  body: _newsBloc.state.newsList[index].body,
                  readFlag: _newsBloc.state.newsList[index].readFlag,
                  onTap: () async {
                    if (!_newsBloc.state.newsList[index].readFlag &&
                        await _isInternetConnected()) {
                      _newsBloc.markNewsRead(index);
                    }
                    showModalBottomSheet(
                      backgroundColor: AppColors.kWhiteColor,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(kSize10),
                            topRight: Radius.circular(kSize10)),
                      ),
                      isScrollControlled: true,
                      isDismissible: false,
                      builder: (context) {
                        return MessageWebViewWidget(
                          type: _newsBloc.state.newsList[index].category,
                          title: _newsBloc.state.newsList[index].subject,
                          body: _newsBloc.state.newsList[index].body,
                          createDate: Helpers.getddMMMMyyyykkmm(
                              DateTime.tryParse(_newsBloc
                                          .state.newsList[index].createDate ??
                                      "") ??
                                  DateTime.now()),
                        );
                      },
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize24),
                child: OtaHorizontalDivider(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReceiptScreen() {
    return BlocBuilder(
        bloc: _receiptBloc,
        builder: () {
          bool isLoading = _receiptBloc.state.receiptState ==
                  MessageViewModelState.loading &&
              _receiptBloc.state.receiptList.isEmpty;
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          bool isFailure = (_receiptBloc.state.receiptState ==
                  MessageViewModelState.failure ||
              _receiptBloc.state.receiptState ==
                  MessageViewModelState.internetFailure ||
              _receiptBloc.state.receiptState ==
                  MessageViewModelState.internetFailureRefresh);
          bool isListEmpty = _receiptBloc.state.receiptList.isEmpty;
          if (isFailure) {
            if (isListEmpty) {
              return _buildNoInternetWidget(_getReceiptData);
            } else {
              return _buildReceiptTile();
            }
          } else {
            if (isListEmpty) {
              return _buildEmptyWidget(_getReceiptData);
            } else {
              return _buildReceiptTile();
            }
          }
        });
  }

  Widget _buildReceiptTile() {
    return OtaRefreshIndicator(
      onRefresh: () => _getReceiptData(),
      text: _buildLoadingText(context),
      child: ListView.builder(
        key: Key(_otaRadioOptionListBloc.state.selectedIndex.toString()),
        padding: EdgeInsets.zero,
        itemCount: _receiptBloc.state.receiptList.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (isNewDataReceiptRequired(index)) {
            _receiptBloc.setNewDataRequired();
            _receiptBloc.getReceiptData(refreshData: false);
          }
          return Column(
            children: [
              Slidable(
                endActionPane: ActionPane(
                  extentRatio: _kExtentRatio,
                  motion: const DrawerMotion(),
                  children: [
                    CustomSlidableAction(
                      onPressed: (context) {
                        _onDeleteButtonPressed(index,
                            _otaRadioOptionListBloc.state.selectedIndex ?? 0);
                      },
                      backgroundColor: AppColors.kSystemWrong,
                      child: Center(
                        child: Text(
                          getTranslated(
                              context, AppLocalizationsStrings.delete),
                          style: AppTheme.kBody.copyWith(
                              fontSize: kSize18,
                              color: AppColors.kLoadingBackground),
                        ),
                      ),
                    ),
                  ],
                ),
                child: MessageListTile(
                  key: Key("messageReceiptTile$index"),
                  iconWidth: kSize44,
                  statusIconSize: kSize10,
                  iconAdditionalPadding: kSize5,
                  title: _receiptBloc.state.receiptList[index].subject,
                  type: _receiptBloc.state.receiptList[index].category,
                  body: _receiptBloc.state.receiptList[index].body,
                  readFlag: _receiptBloc.state.receiptList[index].readFlag,
                  onTap: () async {
                    if (!_receiptBloc.state.receiptList[index].readFlag &&
                        await _isInternetConnected()) {
                      _receiptBloc.markReceiptRead(index);
                    }

                    _openDeepLinkUrl(
                        _receiptBloc.state.receiptList[index].deepUrl);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize24),
                child: OtaHorizontalDivider(),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();

    return await internetConnectionInfo.isConnected;
  }
}
