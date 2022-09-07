import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/modules/car_rental/car_booking_list/bloc/car_booking_list_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_list/view/car_booking_list_screen.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_model.dart';
import 'package:ota/modules/hotel/hotel_bookings/bloc/hotel_bookings_bloc.dart';
import 'package:ota/modules/hotel/hotel_bookings/view/hotel_bookings_screen.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_bookings_view_model.dart';
import 'package:ota/modules/ota_common/bloc/booking_dropdown.dart';
import 'package:ota/modules/ota_common/widgets/booking_options.dart';
import 'package:ota/modules/tours/tour_bookings/bloc/tour_bookings_bloc.dart';
import 'package:ota/modules/tours/tour_bookings/view/tour_bookings_screen.dart';
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

import '../../../common/utils/app_localization_strings.dart';
import '../../../common/utils/consts.dart';
import '../../../core_components/bloc/bloc_builder.dart';
import '../../../core_pack/custom_widgets/ota_app_bar.dart';
import '../../../core_pack/i18n/language_constants.dart';
import '../../favourites/view/widgets/favourites_network_error_widget.dart';
import '../bloc/booking_dropdown.dart';
import '../widgets/booking_option_list.dart';

const double _kOpacityConstant = 0.3;
const Duration _kAnimationDuration = Duration(milliseconds: 200);

class OtaBookingScreen extends StatefulWidget {
  const OtaBookingScreen({Key? key}) : super(key: key);

  @override
  OtaBookingScreenState createState() => OtaBookingScreenState();
}

class OtaBookingScreenState extends State<OtaBookingScreen> {
  final _bookingOptionsController = OtaBookingOptionsController();
  final TourBookingsBloc _tourBookingsBloc = TourBookingsBloc();
  final HotelBookingsBloc _hotelBookingsBloc = HotelBookingsBloc();
  final CarBookingListBloc _carBookingsBloc = CarBookingListBloc();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? bookingKey =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (bookingKey != null) {
        _bookingOptionsController.updateSelectedOption(bookingKey);
      }
      _getData();
    });
    _tourBookingsBloc.stream.listen((event) {
      if (_tourBookingsBloc.state.tourBookingsHistoryViewModelState ==
              TourBookingsHistoryViewModelState.failureNetwork ||
          _tourBookingsBloc.state.tourBookingsHistoryViewModelState ==
              TourBookingsHistoryViewModelState.failureNetworkRefresh) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
    _carBookingsBloc.stream.listen((event) {
      if ((_carBookingsBloc.state.carBookingsHistoryViewModelState ==
                  CarBookingsHistoryViewModelState.failureNetwork ||
              _carBookingsBloc.state.carBookingsHistoryViewModelState ==
                  CarBookingsHistoryViewModelState.failureNetworkRefresh) &&
          !event.isInternetFailurePopUpShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _carBookingsBloc.setInternetPopUpOpened();
      }
    });
    _hotelBookingsBloc.stream.listen((event) {
      if ((_hotelBookingsBloc.state.bookingHistoryViewModelState ==
                  BookingHistoryViewModelState.failureNetwork ||
              _hotelBookingsBloc.state.bookingHistoryViewModelState ==
                  BookingHistoryViewModelState.failureNetworkRefresh) &&
          !event.isInternetFailurePopUpShown) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
        _hotelBookingsBloc.setInternetPopUpOpened();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tourBookingsBloc.dispose();
    _hotelBookingsBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title: getTranslated(
          context,
          AppLocalizationsStrings.activities,
        ),
        isCenterTitle: false,
        trailingWidget: BookingOptions(
          otaBookingOptionsController: _bookingOptionsController,
        ),
        actions: const [
          OtaAppBarAction.customTrailingWidget,
          OtaAppBarAction.backButton,
        ],
      ),
      body: _buildScreen(),
    );
  }

  _buildBookingHistoryScreen() {
    switch (FavouriteHelper.getServiceKey(
        _bookingOptionsController.state.chosenOption)) {
      case FavouriteService.hotel:
        return HotelBookingsScreen(hotelBloc: _hotelBookingsBloc);
      case FavouriteService.toursAndTickets:
        return TourBookingsScreen(tourBloc: _tourBookingsBloc);
      case FavouriteService.carRental:
        return CarBookingsScreen(carBloc: _carBookingsBloc);
      default:
        return _buildNetworkErrorWidget();
    }
  }

  void _getHotelData() {
    _hotelBookingsBloc.resetBookingList();
    _hotelBookingsBloc.getBookingHistoryData(
      type: _bookingOptionsController.state.chosenOption,
      pullToRefresh: false,
    );
  }

  void _getTourData() {
    _tourBookingsBloc.resetTourBookingList();
    _tourBookingsBloc.getTourBookingHistoryData(
      type: _bookingOptionsController.state.chosenOption,
      pullToRefresh: false,
    );
  }

  void _getCarRentalsData() {
    _carBookingsBloc.resetCarBookingList();
    _carBookingsBloc.getCarBookingHistoryData(
      type: _bookingOptionsController.state.chosenOption,
      pullToRefresh: false,
    );
  }

  void _getData() {
    switch (FavouriteHelper.getServiceKey(
        _bookingOptionsController.state.chosenOption)) {
      case FavouriteService.hotel:
        _getHotelData();
        break;
      case FavouriteService.toursAndTickets:
        _getTourData();
        break;
      case FavouriteService.carRental:
        _getCarRentalsData();
        break;
      default:
        break;
    }
  }

  Widget _buildNetworkErrorWidget() {
    return FavoritesNetworkErrorWidget(
      height: MediaQuery.of(context).size.height - kSize200,
    );
  }

  Widget _buildScreen() {
    return BlocBuilder(
      bloc: _bookingOptionsController,
      builder: () {
        return Stack(
          children: [
            _buildBookingHistoryScreen(),
            _blurEffect(),
            _buildAppBarOptions(),
          ],
        );
      },
    );
  }

  Widget _buildAppBarOptions() {
    return BlocBuilder(
      bloc: _bookingOptionsController,
      builder: () {
        return AnimatedSwitcher(
          duration: _kAnimationDuration,
          child: _bookingOptionsController.isExpanded()
              ? GestureDetector(
                  onTap: () {
                    _carBookingsBloc.state.isInternetFailurePopUpShown =
                        _hotelBookingsBloc.state.isInternetFailurePopUpShown =
                            false;
                    _bookingOptionsController.setCollapsed();
                  },
                  child: BookingOptionList(
                    bookingsOptionsController: _bookingOptionsController,
                    onTap: () {
                      _carBookingsBloc.state.isInternetFailurePopUpShown =
                          _hotelBookingsBloc.state.isInternetFailurePopUpShown =
                              false;
                      _getData();
                    },
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _blurEffect() {
    return Positioned.fill(
      child: BlocBuilder(
        bloc: _bookingOptionsController,
        builder: () {
          return AnimatedSwitcher(
            duration: _kAnimationDuration,
            child: _bookingOptionsController.isExpanded()
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: kSize10,
                      sigmaY: kSize10,
                    ),
                    child: Container(
                      color:
                          AppColors.kTrueWhite.withOpacity(_kOpacityConstant),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
