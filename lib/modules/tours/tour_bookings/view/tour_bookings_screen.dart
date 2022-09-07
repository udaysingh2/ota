import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_network_error_with_refresh_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_refresh_indicator/ota_refresh_indicator.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/ota_common/view/ota_booking_chip.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';
import 'package:ota/modules/tours/tour_bookings/bloc/tour_bookings_bloc.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_no_result.dart';
import 'package:ota/modules/tours/tour_bookings/view/widgets/tour_booking_tile.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_detail_argument_type.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

class TourBookingsScreen extends StatefulWidget {
  final TourBookingsBloc tourBloc;
  const TourBookingsScreen({Key? key, required this.tourBloc})
      : super(key: key);

  @override
  TourBookingsScreenState createState() => TourBookingsScreenState();
}

class TourBookingsScreenState extends State<TourBookingsScreen> {
  _requestScreenData({bool pullToRefresh = true}) async {
    await widget.tourBloc.getTourBookingHistoryData(
      type: "tour_key",
      pullToRefresh: pullToRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: widget.tourBloc,
      builder: () {
        return _buildTourBookingHistoryWidget();
      },
    ));
  }

  Widget _buildTourBookingHistoryWidget() {
    return Column(
      children: [
        OtaChipBooking(
          selectedIndex: widget.tourBloc.getSelectedTourBookingType,
          onPressed: (index) {
            if (index != widget.tourBloc.getSelectedTourBookingType) {
              widget.tourBloc.updateTourBookingType(index);
              if (widget.tourBloc.getCurrentBooking().isEmpty) {
                _requestScreenData(pullToRefresh: false);
              } else {
                widget.tourBloc.emitSuccess();
              }
            }
          },
        ),
        Expanded(child: _getTourListView()),
      ],
    );
  }

  Widget _getTourListView() {
    switch (widget.tourBloc.state.tourBookingsHistoryViewModelState) {
      case TourBookingsHistoryViewModelState.loading:
      case TourBookingsHistoryViewModelState.pullDownLoading:
        return const Center(child: CircularProgressIndicator());
      case TourBookingsHistoryViewModelState.failure:
      case TourBookingsHistoryViewModelState.failureNetwork:
        return _buildNoInternetWidget();
      case TourBookingsHistoryViewModelState.success:
      case TourBookingsHistoryViewModelState.failureNetworkRefresh:
        return _successTourView();
      case TourBookingsHistoryViewModelState.none:
        return const SizedBox();
    }
  }

  Widget _getTourTicketView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: kSize24),
      itemCount: widget.tourBloc.selectedTourBookings.length,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemBuilder: (context, index) {
        if (widget.tourBloc.isNewDataRequired(index)) {
          _requestScreenData(pullToRefresh: false);
        }
        return TourBookingTile(
          tourBookings: widget.tourBloc.selectedTourBookings[index],
          onTap: () async {
            if (widget.tourBloc.selectedTourBookings[index].productType ==
                OtaServiceType.tour) {
              var bookingActivityArgument = await Navigator.pushNamed(
                context,
                AppRoutes.tourBookingDetailScreen,
                arguments: TourBookingDetailArgument(
                  bookingId:
                      widget.tourBloc.selectedTourBookings[index].bookingId,
                  bookingUrn: widget
                      .tourBloc.selectedTourBookings[index].tourBookingUrn,
                  bookingType:
                      widget.tourBloc.selectedTourBookings[index].productType,
                ),
              );
              if (bookingActivityArgument is TourBookingActivityArgument &&
                  bookingActivityArgument.isStatusChanged) {
                widget.tourBloc
                    .updateTourBookingType(bookingActivityArgument.index);
                _requestScreenData();
              }
            } else {
              var bookingActivityArgument = await Navigator.pushNamed(
                context,
                AppRoutes.ticketBookingDetailScreen,
                arguments: TicketBookingDetailArgument(
                  bookingId:
                      widget.tourBloc.selectedTourBookings[index].bookingId,
                  bookingUrn: widget
                      .tourBloc.selectedTourBookings[index].tourBookingUrn,
                  bookingType:
                      widget.tourBloc.selectedTourBookings[index].productType,
                ),
              );
              if (bookingActivityArgument is TourBookingActivityArgument &&
                  bookingActivityArgument.isStatusChanged) {
                widget.tourBloc
                    .updateTourBookingType(bookingActivityArgument.index);
                _requestScreenData();
              }
            }
          },
        );
      },
    );
  }

  Widget _successTourView() {
    bool isListEmpty = widget.tourBloc.selectedTourBookings.isEmpty;
    return isListEmpty
        ? _buildEmptyStateWidget()
        : OtaRefreshIndicator(
            text: Text(
              getTranslated(context, AppLocalizationsStrings.loading),
              style: AppTheme.kBody12,
            ),
            onRefresh: () async => await _requestScreenData(),
            child: _getTourTicketView(),
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

  Widget _buildEmptyStateWidget() {
    return TourBookingNoResultWithRefresh(
      height: MediaQuery.of(context).size.height - kSize200,
    );
  }
}
