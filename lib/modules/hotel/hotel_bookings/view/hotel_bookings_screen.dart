import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';
import 'package:ota/modules/hotel/hotel_bookings/bloc/hotel_bookings_bloc.dart';
import 'package:ota/modules/hotel/hotel_bookings/view/widgets/hotel_booking_tile.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_booking_argument_model.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_bookings_view_model.dart';
import 'package:ota/modules/ota_common/view/ota_booking_chip.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_no_result.dart';

class HotelBookingsScreen extends StatefulWidget {
  final HotelBookingsBloc hotelBloc;

  const HotelBookingsScreen({Key? key, required this.hotelBloc})
      : super(key: key);

  @override
  HotelBookingsScreenState createState() => HotelBookingsScreenState();
}

class HotelBookingsScreenState extends State<HotelBookingsScreen> {
  _requestScreenData({bool pullToRefresh = true}) async {
    await widget.hotelBloc.getBookingHistoryData(
      type: "hotel_key",
      pullToRefresh: pullToRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: widget.hotelBloc,
      builder: () {
        return _buildBookingHistoryWidget();
      },
    ));
  }

  Widget _buildBookingHistoryWidget() {
    return Column(
      children: [
        OtaChipBooking(
            selectedIndex: widget.hotelBloc.getSelectedBookingType,
            onPressed: (index) {
              widget.hotelBloc.state.isInternetFailurePopUpShown = false;
              if (index != widget.hotelBloc.getSelectedBookingType) {
                widget.hotelBloc.updateBookingType(index);
                if (widget.hotelBloc.getCurrentBooking().isEmpty) {
                  _requestScreenData(pullToRefresh: false);
                } else {
                  widget.hotelBloc.emitSuccess();
                }
              }
            }),
        Expanded(child: _getHotelListView()),
      ],
    );
  }

  Widget _getHotelListView() {
    switch (widget.hotelBloc.state.bookingHistoryViewModelState) {
      case BookingHistoryViewModelState.loading:
      case BookingHistoryViewModelState.pullDownLoading:
        return const Center(child: CircularProgressIndicator());
      case BookingHistoryViewModelState.failure:
      case BookingHistoryViewModelState.failureNetwork:
        return _buildNoInternetWidget();
      case BookingHistoryViewModelState.success:
      case BookingHistoryViewModelState.failureNetworkRefresh:
        return _successHotelView();
      case BookingHistoryViewModelState.none:
        return const SizedBox();
    }
  }

  Widget _successHotelView() {
    bool isListEmpty = widget.hotelBloc.selectedBookings.isEmpty;
    return isListEmpty
        ? _buildEmptyStateWidget()
        : OtaRefreshIndicator(
            text: Text(
              getTranslated(context, AppLocalizationsStrings.loading),
              style: AppTheme.kBody12,
            ),
            onRefresh: () async => await _requestScreenData(),
            child: _hotelListView(),
          );
  }

  Widget _hotelListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: kSize24),
      itemCount: widget.hotelBloc.selectedBookings.length,
      itemBuilder: (context, index) {
        if (widget.hotelBloc.isNewDataRequired(index)) {
          _requestScreenData(pullToRefresh: false);
        }
        final selectedBooking = widget.hotelBloc.selectedBookings[index];
        return HotelBookingTile(
          hotelBookings: selectedBooking,
          onTap: () async {
            widget.hotelBloc.state.prevSelectedActivityStatus =
                selectedBooking.activityStatus;
            final bookingType = await Navigator.pushNamed(
              context,
              AppRoutes.hotelBookingDetailScreen,
              arguments: HotelBookingDetailArgument(
                confirmationNo: selectedBooking.bookingId,
                bookingUrn: selectedBooking.bookingUrn,
              ),
            );
            _updateBookingType(bookingType);
          },
        );
      },
    );
  }

  _updateBookingType(Object? argument) async {
    if (argument is HotelBookingsArgumentModel) {
      widget.hotelBloc.updateBookingType(argument.bookingType ?? 0);
      if ((argument.bookingType != null &&
              widget.hotelBloc.state.prevSelectedIndex !=
                  argument.bookingType) ||
          (argument.activityStatus != null &&
              argument.activityStatus !=
                  widget.hotelBloc.state.prevSelectedActivityStatus)) {
        widget.hotelBloc.state.prevSelectedIndex = argument.bookingType!;
        widget.hotelBloc.state.prevSelectedActivityStatus =
            argument.activityStatus!;
        await _requestScreenData(pullToRefresh: false);
      }
    }
  }

  Widget _buildEmptyStateWidget() {
    return TourBookingNoResultWithRefresh(
      height: MediaQuery.of(context).size.height - kSize200,
    );
  }

  Widget _buildNoInternetWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: OtaNetworkErrorWidgetWithRefresh(
        height: MediaQuery.of(context).size.height - kSize200,
        onRefresh: () async => await _requestScreenData(),
      ),
    );
  }
}
