import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_string_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_range_picker.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_search_input_parameters.dart';
import 'package:ota/modules/search/filters/bloc/filters_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/counter_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_tile_widget.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  final FiltersBloc _bloc = FiltersBloc();
  final List<String> bedTypeList = AppConfig().configModel.bedTypes.split(',');

  void _setFilterData() {
    FilterArgument argument =
        ModalRoute.of(context)?.settings.arguments as FilterArgument;
    _bloc.setFilterViewModelData(argument);
  }

  void _onConfirmClick() {
    _getHotelSearchInputData(FirebaseEvent.hotelSearchInput);
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
    FilterArgument inArgument =
        ModalRoute.of(context)?.settings.arguments as FilterArgument;
    if (inArgument.pushScreen == AppRoutes.hotelDetail ||
        inArgument.pushScreen == AppRoutes.hotelListView) {
      // The way passing data back to hotel detail screen
      // will change, once we received request params from BE
      final filterArgument = FilterArgument.fromFilterViewModel(_bloc.state);
      // final selectedFilter = {'adults': adultsCount, 'children': childrenCount};
      // Helpers.debugPrint(selectedFilter.toString());
      Navigator.of(context).pop(filterArgument);
    }
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
            getTranslated(context, AppLocalizationsStrings.reservationDetails),
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
                  _buildTitleWidget(context),
                  _buildCheckInOutPeriodWidget(context),
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
      showHorizontalDivider: false,
      padding: const EdgeInsets.only(
          left: kSize24, right: kSize24, top: kSize16, bottom: kSize9),
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.searchLabel),
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

  void _showDateSelectionSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return OTADateRangePicker(
          titleTopPadding: kSize16,
          preSetCheckinDate: _bloc.state.checkInDate ??
              DateTime.now().add(
                  Duration(days: AppConfig().configModel.checkInDeltaHotel)),
          preSetCheckoutDate: _bloc.state.checkOutDate ??
              DateTime.now().add(
                  Duration(days: AppConfig().configModel.checkOutDeltaHotel)),
          onSumbit: (checkinDate, checkoutDate) {
            _bloc.setSelectedCheckInOutPeriod(checkinDate, checkoutDate);
            Navigator.of(context).pop();
          },
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

  Widget _buildTitleWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kSize8),
      child: Text(
        getTranslated(context, AppLocalizationsStrings.checkInCheckOutDate),
        style: AppTheme.kHeading1Medium,
      ),
    );
  }

  Widget _buildCheckInOutPeriodWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kSize12, bottom: kSize32),
      child: InkWell(
        key: const Key("showCalender"),
        borderRadius: BorderRadius.circular(kSize8),
        onTap: _showDateSelectionSheet,
        child: Ink(
          key: const Key("dateRange"),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.kGrey4,
            borderRadius: BorderRadius.circular(kSize8),
          ),
          padding: const EdgeInsets.all(kSize10),
          child: Text(
            _getCheckInOutPeriodText(context),
            style: AppTheme.kBodyRegular,
          ),
        ),
      ),
    );
  }

  String _getCheckInOutPeriodText(BuildContext context) {
    return '${Helpers.getwwddMMMyy(_bloc.state.checkInDate!)} - ${Helpers.getwwddMMMyy(_bloc.state.checkOutDate!)}';
  }

  _getHotelSearchInputData(String eventName) {
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelNoRoom,
        value: _bloc.state.roomList.length.toString());
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelNoAdult,
        value: _bloc.getAdultsCount().toString());
    FirebaseHelper.addKeyValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelNoChild,
        value: _bloc.getChildrenCount().toString());
    FirebaseHelper.addIntValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelNoNight,
        value: Helpers.daysBetween(
            start: _bloc.state.checkInDate.toString(),
            end: _bloc.state.checkOutDate.toString()));
    FirebaseHelper.addDateValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelStartDate,
        value: _bloc.state.checkInDate);
    FirebaseHelper.addDateValue(
        eventName: eventName,
        key: HotelSearchInputParameters.hotelEndDate,
        value: _bloc.state.checkOutDate);
  }
}
