import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/main.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/ota_filters/view_model/filter_ota_argument_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:provider/provider.dart';

import 'authentication/model/login_model.dart';
import 'car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';
import 'hotel/hotel_detail/view_model/argument_model.dart';
import 'hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';

final kThaiLocale =
    Locale(LanguageCodes.thai.code, LanguageCodes.thai.countryCode);
final kEngLocale =
    Locale(LanguageCodes.english.code, LanguageCodes.english.countryCode);

// Demo Screen to be removed
class DemoScreen extends StatefulWidget {
  const DemoScreen({Key? key}) : super(key: key);

  @override
  DemoScreenState createState() => DemoScreenState();
}

class DemoScreenState extends State<DemoScreen> {
  bool _loggedIn = Provider.of<LoginModel>(
              GlobalKeys.navigatorKey.currentContext!,
              listen: false)
          .userType ==
      UserType.loggedInUser;
  final bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  _getArgumentData() {
    return CarSupplierArgumentViewModel(
      carId: '2',
      pickupLocationId: '',
      returnLocationId: '',
      pickupLocation: '',
      returnLocation: '',
      pickupDate: DateTime.now(),
      returnDate: DateTime.now(),
      includeDriver: 'N',
      residenceCountry: '',
      currency: 'THB',
      rentalType: 'day',
      age: 8,
      pickupCounter: '06',
      returnCounter: '06',
      thumbImage: '',
      carName: 'March',
      brandName: 'Nisson',
      craftType: 'Small Cars',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          )
        : WillPopScope(
            onWillPop: () async => true,
            child: Scaffold(
              body: ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Tour Multiple Package'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.tourDetailScreen,
                              arguments: TourDetailArgument(
                                  userType: _loggedIn
                                      ? TourDetailUserType.loggedInUser
                                      : TourDetailUserType.guestUser,
                                  tourId: "MA2110000413",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Tour Single Package 1'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.tourDetailScreen,
                              arguments: TourDetailArgument(
                                  userType: _loggedIn
                                      ? TourDetailUserType.loggedInUser
                                      : TourDetailUserType.guestUser,
                                  tourId: "MA2111000068",
                                  tourDate: "2022-01-12",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: const Text('Tour Single package 2'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.tourDetailScreen,
                              arguments: TourDetailArgument(
                                  userType: _loggedIn
                                      ? TourDetailUserType.loggedInUser
                                      : TourDetailUserType.guestUser,
                                  tourId: "MA2111000115",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Tour Single package 3'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.tourDetailScreen,
                              arguments: TourDetailArgument(
                                  userType: _loggedIn
                                      ? TourDetailUserType.loggedInUser
                                      : TourDetailUserType.guestUser,
                                  tourId: "MA2110000383",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Tour No Data'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.tourDetailScreen,
                              arguments: TourDetailArgument(
                                  userType: _loggedIn
                                      ? TourDetailUserType.loggedInUser
                                      : TourDetailUserType.guestUser,
                                  tourId: "MA2111000009",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Ticket Multiple Package 1'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.ticketDetailScreen,
                              arguments: TicketDetailArgument(
                                  userType: _loggedIn
                                      ? TicketDetailUserType.loggedInUser
                                      : TicketDetailUserType.guestUser,
                                  ticketId: "MA2111000168",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Ticket Single package'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.ticketDetailScreen,
                              arguments: TicketDetailArgument(
                                  userType: _loggedIn
                                      ? TicketDetailUserType.loggedInUser
                                      : TicketDetailUserType.guestUser,
                                  ticketId: "MA2111000157",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Ticket Multiple Package 2'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.ticketDetailScreen,
                              arguments: TicketDetailArgument(
                                  userType: _loggedIn
                                      ? TicketDetailUserType.loggedInUser
                                      : TicketDetailUserType.guestUser,
                                  ticketId: "MA2110000388",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Ticket Multiple Package 3'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.ticketDetailScreen,
                              arguments: TicketDetailArgument(
                                  userType: _loggedIn
                                      ? TicketDetailUserType.loggedInUser
                                      : TicketDetailUserType.guestUser,
                                  ticketId: "MA2111000039",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Ticket No Data'),
                      onTap: () async => await _isInternetConnected()
                          ? Navigator.pushNamed(
                              context,
                              AppRoutes.ticketDetailScreen,
                              arguments: TicketDetailArgument(
                                  userType: _loggedIn
                                      ? TicketDetailUserType.loggedInUser
                                      : TicketDetailUserType.guestUser,
                                  ticketId: "MA2111000009",
                                  cityId: "MA05110041",
                                  countryId: "MA05110001"),
                            )
                          : _showNoInternetAlert(),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Hotel 1'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.carSupplierScreen,
                        arguments: _getArgumentData(),
                        // HotelDetailArgument(
                        //   currencyCode: AppConfig().currency,
                        //   userType: _loggedIn
                        //       ? HotelDetailUserType.loggedInUser
                        //       : HotelDetailUserType.guestUser,
                        //   checkOutDate: "2021-12-12",
                        //   checkInDate: "2021-11-11",
                        //   rooms: [
                        //     Room(
                        //       adults: 2,
                        //       children: 2,
                        //       childAge1: 12,
                        //       childAge2: 9,
                        //     )
                        //   ],
                        //   cityId: "MA05110041",
                        //   countryCode: "MA05110001",
                        //   hotelId: "MA1111000019",
                        // ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Hotel 2'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.hotelDetail,
                        arguments: HotelDetailArgument(
                          currencyCode: AppConfig().currency,
                          userType: _loggedIn
                              ? HotelDetailUserType.loggedInUser
                              : HotelDetailUserType.guestUser,
                          checkOutDate: "2021-12-12",
                          checkInDate: "2021-11-11",
                          rooms: [
                            Room(
                              adults: 3,
                              children: 0,
                              // childAge1: 12,
                              // childAge2: 9,
                            )
                          ],
                          cityId: "MA05110041",
                          countryCode: "MA05110001",
                          hotelId: "MA0511000344",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Hotel 3'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.hotelDetail,
                        arguments: HotelDetailArgument(
                          currencyCode: AppConfig().currency,
                          userType: _loggedIn
                              ? HotelDetailUserType.loggedInUser
                              : HotelDetailUserType.guestUser,
                          checkOutDate: "2021-12-12",
                          checkInDate: "2021-11-11",
                          rooms: [
                            Room(
                              adults: 2,
                              children: 2,
                              childAge1: 12,
                              childAge2: 9,
                            ),
                            Room(
                              adults: 3,
                              children: 1,
                              childAge1: 14,
                            ),
                          ],
                          cityId: "MA05110041",
                          countryCode: "MA05110001",
                          hotelId: "MA0511000294",
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Hotel 4'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.hotelDetail,
                        arguments: HotelDetailArgument(
                          currencyCode: AppConfig().currency,
                          userType: _loggedIn
                              ? HotelDetailUserType.loggedInUser
                              : HotelDetailUserType.guestUser,
                          checkOutDate: "2021-12-12",
                          checkInDate: "2021-11-11",
                          rooms: [
                            Room(
                              adults: 2,
                              children: 2,
                              childAge1: 12,
                              childAge2: 9,
                            ),
                            Room(adults: 3, children: 1, childAge1: 10)
                          ],
                          cityId: "MA05110041",
                          countryCode: "MA05110001",
                          hotelId: "MA0511000344",
                        ),
                      ),
                    ),
                  ),
                  //Room Reservation Screen
                  Card(
                    child: ListTile(
                      title: const Text('Payment Screen'),
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.hotelPaymentMainScreen,
                        arguments: HotelPaymentMainArgumentModel(
                          freefoodDelivery: false,
                          otaCountDownController:
                              OtaCountDownController(durationInSecond: 15 * 60),
                          totalCost: "200",
                          addonsModels: [
                            HotelPaymentAddonsModel(
                              quantity: "2",
                              selectedDate: DateTime.now(),
                              imageUrl: "",
                              cost: "12",
                              uniqueId: "123",
                              serviceName: "Service Name",
                              description: "Description",
                            )
                          ],
                          lastName: "last",
                          firstName: "first",
                          secondGuestName: "",
                          firstGuestName: "",
                          membershipId: "",
                          bookingUrn: "",
                          additionalNeedsText: "",
                          roomCode: "",
                          hotelId: "",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.translate),
                onPressed: () {
                  final currentLocale = MyApp.getLocal(context);
                  final newLocale =
                      LanguageCodes.thai.code == currentLocale.languageCode
                          ? kEngLocale
                          : kThaiLocale;

                  MyApp.setLocale(context, newLocale);
                },
              ),
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title:
                    Text(getTranslated(context, AppLocalizationsStrings.demo)),
                backgroundColor: Colors.blue,
                actions: [
                  IconButton(
                    padding: const EdgeInsets.only(right: kSize14),
                    icon:
                        SvgPicture.asset("assets/images/icons/icon_filter.svg"),
                    iconSize: kSize24,
                    onPressed: __filterButtonAction,
                  ),
                  TextButton(
                      onPressed: () {
                        _handleGuest();
                      },
                      child: Text(_loggedIn ? "Active" : "Guest",
                          style: const TextStyle(color: Colors.black54))),
                ],
              ),
            ),
          );
  }

  void _handleGuest() async {
    setState(() {
      _loggedIn = !_loggedIn;
    });
    // ignore: unrelated_type_equality_checks
    Provider.of<LoginModel>(GlobalKeys.navigatorKey.currentContext!, listen: false).userType =
        _loggedIn
            // ignore: unnecessary_statements
            ? UserType.loggedInUser
            // ignore: unnecessary_statements
            : UserType.guestUser;
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  void _showNoInternetAlert() {
    OtaNoInternetAlertDialog().showAlertDialog(context);
  }

  void useOtaSearchFilter() {
    Navigator.pushNamed(context, AppRoutes.filterOtaPage,
        arguments: FilterOtaArgumentModel(
          initialFilterOtaArgumentData: FilterOtaArgumentData(
            maximumPrice: 1000,
            startingPrice: 1,
          ),
          onSearchClicked: (updatedFilterOtaArgumentData) {},
        ));
  }

  void __filterButtonAction() {
    Navigator.pushNamed(
      context,
      AppRoutes.filterScreen,
      arguments: FilterArgument(
        checkInDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
            .add(Duration(days: AppConfig().configModel.checkInDeltaHotel))),
        checkOutDate: Helpers.getYYYYmmddFromDateTime(DateTime.now()
            .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel))),
        roomList: [
          RoomArgument(
            adults: 1,
            childAgeList: [],
          ),
        ],
        cityId: "MA05110041",
        countryCode: "MA05110001",
        hotelId: "MA0511000344",
      ),
    );
  }
}
