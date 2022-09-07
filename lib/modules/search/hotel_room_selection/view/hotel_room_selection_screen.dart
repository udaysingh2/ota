import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_string_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/counter_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_tile_widget.dart';
import 'package:ota/modules/search/hotel_room_selection/bloc/hotel_room_selection_bloc.dart';
import 'package:ota/modules/search/hotel_room_selection/view_model/hotel_room_selection_argument_model.dart';

class HotelRoomSelectionScreen extends StatefulWidget {
  const HotelRoomSelectionScreen({Key? key}) : super(key: key);

  @override
  HotelRoomSelectionScreenState createState() =>
      HotelRoomSelectionScreenState();
}

class HotelRoomSelectionScreenState extends State<HotelRoomSelectionScreen> {
  final HotelRoomSelectionBloc _bloc = HotelRoomSelectionBloc();
  final List<String> bedTypeList = AppConfig().configModel.bedTypes.split(',');

  void _setFilterData() {
    HotelRoomSelectionArgumentModel argument = ModalRoute.of(context)
        ?.settings
        .arguments as HotelRoomSelectionArgumentModel;
    _bloc.setHotelRoomSelectionViewModelData(argument);
  }

  void _onConfirmClick() {
    final adultsCount = _bloc.getAdultsCount();
    final totalGuests = adultsCount;
    if (totalGuests > AppConfig().configModel.maxGuestsAllowed) {
      OtaAlertDialog(
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        errorMessage: getTranslated(context,
            AppLocalizationsStrings.boookingMaxGuestLimitExceededMessage),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
      ).showAlertDialog(context);
      return;
    }

    final updatedArgument =
        HotelRoomSelectionArgumentModel.fromViewModel(_bloc.state);
    Navigator.of(context).pop(updatedArgument);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setFilterData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kTrueWhite,
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.noOfGuestAndRooms),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: kSize16, left: kSize24, right: kSize24),
        child: BlocBuilder(
            bloc: _bloc,
            builder: () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNoOfRoomsWidget(context),
                  const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                  _buildRoomsListView(),
                  _buildBottomBar(),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildRoomsListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _bloc.state.roomList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final roomViewModel = _bloc.state.roomList[index];
          final roomNumber = index + 1;
          return FilterTileWidget(
            key: Key(roomNumber.toString()),
            roomNumber: roomNumber,
            adults: roomViewModel.adults,
            childAgeList: roomViewModel.childAgeList,
            bedTypeKey: roomViewModel.bedTypeKey,
            onAdultAdded: (value) {
              _bloc.addAdult(index, value);
            },
            onAdultRemoved: (value) {
              _bloc.removeAdult(index, value);
            },
            onChildAdded: (value) {
              _showAddChildAgeSheet(
                  context, index, _bloc.getRoomChildrenCount(index));
            },
            onChildRemoved: (_) {
              _bloc.removeChild(index);
            },
            onChildAgeUpdate: (childIndex) {
              final int oldAge = roomViewModel.childAgeList[childIndex];
              _showAddChildAgeSheet(context, index, childIndex, oldAge: oldAge);
            },
            onBedTypeUpdate: (bedTypeKey) {
              _showBedTypeSheet(context, index, bedTypeKey);
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    return OtaBottomButtonBar(
      containerHeight: kSize74,
      padding: const EdgeInsets.only(
        left: kSize24,
        right: kSize24,
        top: kSize16,
        bottom: kSize9,
      ),
      showHorizontalDivider: false,
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.ok),
        isSelected: true,
        onPressed: _onConfirmClick,
      ),
    );
  }

  void _showBedTypeSheet(BuildContext context, int index, String bedTypeKey) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.kLight100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kSize24),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoStringWidget(
            title:
                getTranslated(context, AppLocalizationsStrings.selectBedType),
            list: bedTypeList,
            selectedBedTypeKey: bedTypeKey,
            onAgreeClicked: (bedTypeKey) {
              _bloc.updateBedType(index, bedTypeKey);
            },
          ),
        );
      },
    );
  }

  void _showAddChildAgeSheet(
      BuildContext context, int roomIndex, int childAgeIndex,
      {int? oldAge}) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: AppColors.kLight100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kSize24),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoWidget(
            title:
                '${getTranslated(context, AppLocalizationsStrings.ageOfChild)} ${childAgeIndex + 1}',
            maxInputValueLimit: AppConfig().configModel.maxChildAge,
            oldAge: oldAge,
            onAgreeClicked: (newAge) {
              if (oldAge == null) {
                _bloc.addChild(roomIndex, newAge);
              } else {
                _bloc.updateChild(roomIndex, childAgeIndex, newAge);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildNoOfRoomsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize12),
      child: FilterRowWidget(
        key: Key(FilterRowType.room.toString()),
        title: getTranslated(context, AppLocalizationsStrings.noOfRooms),
        initialValue: _bloc.state.roomList.length,
        titleStyle: AppTheme.kHeading1Medium,
        onValueAdded: (_) => _bloc.addNewRoom(),
        onValueRemoved: (_) => _bloc.removeRoom(),
      ),
    );
  }
}
