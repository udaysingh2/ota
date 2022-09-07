import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_booking_list/bloc/car_booking_list_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_list/view/widgets/car_booking_list_tile_widget.dart';
import 'package:ota/modules/ota_common/view/ota_no_result_booking_list.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_argument_model.dart';
import 'package:ota/modules/ota_common/view/ota_booking_chip.dart';
import 'widgets/car_booking_error_widget.dart';

const _serviceType = "CARRENTAL";
const String _kCarKey = "car_key";
const String _kCarScrollKey = "CarScrollKey";

class CarBookingsScreen extends StatefulWidget {
  final CarBookingListBloc carBloc;
  const CarBookingsScreen({Key? key, required this.carBloc}) : super(key: key);

  @override
  CarBookingsScreenState createState() => CarBookingsScreenState();
}

class CarBookingsScreenState extends State<CarBookingsScreen> {
  final globalKey = GlobalKey<ScaffoldState>();
  _requestScreenData({bool pullToRefresh = true}) async {
    await widget.carBloc.getCarBookingHistoryData(
      type: _kCarKey,
      pullToRefresh: pullToRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: widget.carBloc,
        builder: () {
          return _buildCarBookingHistoryWidget();
        },
      ),
    );
  }

  Widget _buildCarBookingHistoryWidget() {
    return Column(
      children: [
        OtaChipBooking(
          selectedIndex: widget.carBloc.getSelectedCarBookingType,
          onPressed: (index) {
            if (index != widget.carBloc.getSelectedCarBookingType) {
              widget.carBloc.updateCarBookingType(index);
              widget.carBloc.state.isInternetFailurePopUpShown = false;
              if (widget.carBloc.getCurrentBooking().isEmpty) {
                _requestScreenData(pullToRefresh: false);
              } else {
                widget.carBloc.emitSuccess();
              }
            }
          },
        ),
        Expanded(child: _getCarListView()),
      ],
    );
  }

  Widget _getCarListView() {
    switch (widget.carBloc.state.carBookingsHistoryViewModelState) {
      case CarBookingsHistoryViewModelState.loading:
      case CarBookingsHistoryViewModelState.pullDownLoading:
        return const Center(child: CircularProgressIndicator());
      case CarBookingsHistoryViewModelState.failure:
      case CarBookingsHistoryViewModelState.failureNetwork:
        return _buildNoInternetWidget();
      case CarBookingsHistoryViewModelState.success:
      case CarBookingsHistoryViewModelState.failureNetworkRefresh:
        return _successCarView();

      case CarBookingsHistoryViewModelState.none:
        return const SizedBox();
    }
  }

  Widget _getCarView() {
    return ListView.builder(
      key: const Key(_kCarScrollKey),
      padding: const EdgeInsets.only(top: kSize24),
      itemCount: widget.carBloc.selectedCarBookings.length,
      itemBuilder: (context, index) {
        if (widget.carBloc.isNewDataRequired(index)) {
          _requestScreenData(pullToRefresh: false);
        }

        return CarBookingListTile(
          carBookings: widget.carBloc.selectedCarBookings[index],
          onTap: () async {
            CarBookingViewModel carBookingViewModel =
                widget.carBloc.selectedCarBookings[index];
            var data = await Navigator.pushNamed(
              context,
              AppRoutes.carBookingDetail,
              arguments: CarBookingDetailArgumentModel(
                bookingId: carBookingViewModel.bookingId,
                bookingType: _serviceType,
                bookingUrn: carBookingViewModel.carBookingUrn,
              ),
            );
            if (data != null) {
              _updateBookingType(data);
            }
          },
        );
      },
    );
  }

  _updateBookingType(Object? argument) async {
    if (argument is int) {
      if (widget.carBloc.getSelectedCarBookingType != argument) {
        widget.carBloc.updateCarBookingType(argument);
        await _requestScreenData();
      }
    }
  }

  Widget _successCarView() {
    bool isListEmpty = widget.carBloc.selectedCarBookings.isEmpty;
    return isListEmpty
        ? _buildEmptyStateWidget()
        : OtaRefreshIndicator(
            text: Text(
              getTranslated(context, AppLocalizationsStrings.loading),
              style: AppTheme.kBody12,
            ),
            onRefresh: () async => await _requestScreenData(),
            child: _getCarView(),
          );
  }

  Widget _buildNoInternetWidget() {
    var height = globalKey.currentState?.appBarMaxHeight ?? 0;
    double topSpace = kSize45 + height;

    return CarBookingErrorWidget(
      height: MediaQuery.of(context).size.height - (topSpace * 2),
      onRefresh: () async => await _requestScreenData(),
    );
  }

  Widget _buildEmptyStateWidget() {
    return OtaBookingNoResult(
      errorMsg: widget.carBloc.bookingType == CarBookingType.ongoingBooking
          ? AppLocalizationsStrings.noOngoingBookings
          : widget.carBloc.bookingType == CarBookingType.completeBooking
              ? AppLocalizationsStrings.noCompletedBookings
              : AppLocalizationsStrings.noCancelledBookings,
    );
  }
}
