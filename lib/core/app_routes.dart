import 'package:flutter/material.dart';
import 'package:ota/modules/auth_landing.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view/car_booking_cancellation_screen.dart';
import 'package:ota/modules/car_rental/car_booking_mailer/view/car_booking_mailer_screen.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/view/car_date_time_selection.dart';
import 'package:ota/modules/car_rental/car_detail/view/car_detail_screen.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/car_detail_info_screen.dart';
import 'package:ota/modules/car_rental/car_detail_more_info/view/car_detail_more_info_screen.dart';
import 'package:ota/modules/car_rental/car_gallery/view/car_gallery_screen.dart';
import 'package:ota/modules/car_rental/car_landing/view/car_landing_screen.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view/car_booking_detail.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view/car_search_result.dart';
import 'package:ota/modules/car_rental/car_rental_vertical_palylist/view/car_rental_vertical_playlist.dart';
import 'package:ota/modules/car_rental/car_reservation/view/car_reservation_screen.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/add_additional_service.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/car_search_filter.dart';
import 'package:ota/modules/car_rental/car_supplier/view/car_supplier_screen.dart';
import 'package:ota/modules/car_rental/contact_information/view/contact_information_form_page.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view/guest_driver_details_screen.dart';
import 'package:ota/modules/demo_screen.dart';
import 'package:ota/modules/favourites/view/ota_favourite_listing_screen.dart';
import 'package:ota/modules/gallery/view/gallery_screen.dart';
import 'package:ota/modules/gallery/view/ota_gallery_screen.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view/hotel_booking_cancellation_screen.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/hotel_booking_details_screen.dart';
import 'package:ota/modules/hotel/hotel_booking_mailer/view/hotel_booking_mailer_screen.dart';
import 'package:ota/modules/hotel/hotel_detail/view/hotel_detail.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/facilities_details_widget.dart';
import 'package:ota/modules/hotel/hotel_landing/view/hotel_landing_screen.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/hotel_landing_dynamic_playlist_screen.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/hotel_landing_static_playlist_screen.dart';
import 'package:ota/modules/hotel/hotel_payment/view/hotel_payment_main_screen.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view/hotel_success_payment_screen.dart';
import 'package:ota/modules/hotel/room_detail/view/room_detail_screen.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view/hotel_addon_service_screen.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view/addon_service_calendar.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view/contact_information_form_page.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/reservation_screen.dart';
import 'package:ota/modules/insurance/view/insurance_error_web_view_screen.dart';
import 'package:ota/modules/insurance/view/insurance_landing_screen.dart';
import 'package:ota/modules/landing/view/landing_page.dart';
import 'package:ota/modules/message_and_notification/view/message_and_notification_screen.dart';
import 'package:ota/modules/ota_common/view/ota_booking_mailer_screen.dart';
import 'package:ota/modules/ota_common/view/ota_booking_screen.dart';
import 'package:ota/modules/ota_common/view/ota_landing_share_error_screen.dart';
import 'package:ota/modules/ota_common/view/ota_share_error_screen.dart';
import 'package:ota/modules/ota_date_range_picker/view/ota_date_range_picker_screen.dart';
import 'package:ota/modules/ota_reservation_success/view/ota_reservation_success.dart';
import 'package:ota/modules/payment_method/view/payment_loading_screen.dart';
import 'package:ota/modules/payment_method/view/payment_method_list_screen.dart';
import 'package:ota/modules/playlist/view/ota_vertical_playlist_screen.dart';
import 'package:ota/modules/playlist/view/playlist_screen.dart';
import 'package:ota/modules/preferences/view/preferences_screen.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/view/promo_detail_screen.dart';
import 'package:ota/modules/promo_engine/search_list/view/promo_code_search_screen.dart';
import 'package:ota/modules/review_filter/view/widget/review_filter_screen.dart';
import 'package:ota/modules/room_gallery/view/hotel_room_gallery_screen.dart';
import 'package:ota/modules/search/filters/view/filter_screen.dart';
import 'package:ota/modules/search/hotel/view/hotel_search_screen.dart';
import 'package:ota/modules/search/hotel_room_selection/view/hotel_room_selection_screen.dart';
import 'package:ota/modules/search/ota/view/ota_search_list_view.dart';
import 'package:ota/modules/search/ota/view/ota_search_screen.dart';
import 'package:ota/modules/search/ota_filters/view/filter_ota_page.dart';
import 'package:ota/modules/splash/view/splash_screen.dart';
import 'package:ota/modules/success_screen.dart';
import 'package:ota/modules/tickets/booking_details/view/ticket_booking_detail_screen.dart';
import 'package:ota/modules/tickets/booking_details/view/ticket_booking_details_description.dart';
import 'package:ota/modules/tickets/booking_details/view/ticket_booking_package_detail_screen.dart';
import 'package:ota/modules/tickets/confirm_booking/view/ticket_confirm_booking_screen.dart';
import 'package:ota/modules/tickets/confirm_booking/view/ticket_guest_detail_screen.dart';
import 'package:ota/modules/tickets/description/view/ticket_description_screen.dart';
import 'package:ota/modules/tickets/details/view/ticket_detail_screen.dart';
import 'package:ota/modules/tickets/package_details/view/tickets_package_detail_screen.dart';
import 'package:ota/modules/tickets/reservation/view/ticket_guest_information.dart';
import 'package:ota/modules/tickets/reservation/view/ticket_reservation.dart';
import 'package:ota/modules/tickets/ticket_booking_calendar/view/ticket_booking_calendar_screen.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view/ticket_booking_cancellation_screen.dart';
import 'package:ota/modules/tours/appointment_detail/view/appointment_detail_screen.dart';
import 'package:ota/modules/tours/booking_details/view/tour_booking_detail_screen.dart';
import 'package:ota/modules/tours/booking_details/view/tour_booking_details_description.dart';
import 'package:ota/modules/tours/booking_details/view/tour_booking_packge_detail_screen.dart';
import 'package:ota/modules/tours/confirm_booking/view/guest_detail_screen.dart';
import 'package:ota/modules/tours/confirm_booking/view/tour_confirm_booking_screen.dart';
import 'package:ota/modules/tours/description/tour_description_screen.dart';
import 'package:ota/modules/tours/details/view/tour_detail_screen.dart';
import 'package:ota/modules/tours/landing/view/tours_landing_screen.dart';
import 'package:ota/modules/tours/ota_bookings/booking_calendar/view/tour_booking_calendar_screen.dart';
import 'package:ota/modules/tours/ota_contact_information/view/ota_contact_information_form_page.dart';
import 'package:ota/modules/tours/ota_date_selection/view/ota_date_selection_screen.dart';
import 'package:ota/modules/tours/package_detail/view/tour_package_detail_screen.dart';
import 'package:ota/modules/tours/payment_status/view/new_payment_loading_screen.dart';
import 'package:ota/modules/tours/playlist/view/tour_ticket_playlist_screen.dart';
import 'package:ota/modules/tours/reservation/view/guest_information.dart';
import 'package:ota/modules/tours/reservation/view/tour_reservation.dart';
import 'package:ota/modules/tours/tour_booking_cancellation/view/tour_booking_cancellation_screen.dart';
import 'package:ota/modules/tours/tour_loading/view/tour_loading_screen.dart';
import 'package:ota/modules/tours/tour_search/results/view/tour_search_result_screen.dart';
import 'package:ota/modules/tours/tour_search/search/view/tour_search_suggestions_screen.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/tours_search_filter_screen.dart';
import 'package:ota/modules/web_view/web_view_screen.dart';

import '../modules/car_rental/car_landing/view/edit_search_screen.dart';
import '../modules/car_rental/car_payment/view/car_payment_screen.dart';
import '../modules/car_rental/car_search_suggestion/view/car_search_pickup_points.dart';
import '../modules/car_rental/car_search_suggestion/view/car_search_suggestion_screen.dart';
import '../modules/car_rental/car_success_payment/view/car_sucessful_payment_screen.dart';

class AppRoutes {
  // Route name constants
  static const String splashScreen = '/splashScreen';
  static const String hotelDetail = '/hotelDetail';
  static const String facilityDetails = '/facilityDetails';
  static const String roomDetails = '/roomDetails';
  static const String demoScreen = '/demoScreen';
  static const String galleryScreen = '/galleryScreen';
  static const String galleryOtaScreen = '/galleryOtaScreen';
  static const String filterScreen = '/filterScreen';
  static const String loginScreen = '/loginScreen';
  static const String authLanding = '/authLanding';
  static const String landingPage = '/landingPage';
  static const String hotelListView = '/hotelListView';
  static const String playlistScreen = '/playlistScreen';
  static const String otaVerticalPlaylistScreen = '/otaVerticalPlaylistScreen';
  static const String staticPlaylistScreen = '/staticPlaylistScreen';
  static const String hotelSearchScreen = '/hotelSearchScreen';
  static const String hotelLandingScreen = '/hotelLandingScreen';
  static const String filterOtaPage = '/filterOtaPage';
  static const String reviewFilterScreen = 'reviewFilterScreen';
  static const String webViewScreen = '/webViewScreen';
  static const String promoDetailScreen = '/promoDetailScreen';
  static const String promoCodeSearchScreen = '/promoSearchListingScreen';
  static const String tourBookingScreen = 'tourBookingScreen';

  static const String otaSearchScreen = '/otaSearchScreen';
  static const String reservationScreen = '/reservationScreen';
  static const String addonServiceCalendarScreen =
      '/addonServiceCalendarScreen';
  static const String contactInformationFormPage =
      '/contactInformationFormPage';
  static const String hotelAddonServiceScreen = '/hotelAddonServiceScreen';
  static const String successScreen = '/SuccessScreen';
  static const String paymentLoadingScreen = '/PaymentLoading';
  static const String hotelPaymentMainScreen = '/hotelPaymentMainScreen';
  static const String hotelSuccessPaymentScreen = '/hotelSuccessPaymentScreen';
  static const String paymentMethodListScreen = '/paymentMethodListScreen';
  static const String favouriteHotelScreen = '/favouriteHotelScreen';
  static const String otaFavouritesListingScreen =
      '/otaFavouritesListingScreen';
  static const String favouriteCarRentalScreen = '/favouriteCarRentalScreen';
  static const String otaBookingScreen = '/otaBookingScreen';
  static const String hotelBookingDetailScreen = '/hotelBookingDetailScreen';
  static const String hotelBookingCancellationScreen =
      '/hotelBookingCancellationScreen';
  static const String messageAndNotificationScreen =
      '/messageAndNotificationScreen';
  static const String hotelBookingMailerScreen = '/hotelBookingMailerScreen';
  static const String otaBookingMailerScreen = '/otaBookingMailerScreen';
  static const String carBookingMailerScreen = '/carBookingMailerScreen';
  static const String preferencesScreen = '/preferencesScreen';
  static const String roomGalleryScreen = '/roomGalleryScreen';

  static const String otaDateRangePickerScreen = '/otaDateRangePickerScreen';
  static const String hotelRoomSelectionScreen = '/hotelRoomSelectionScreen';
  static const String hotelLandingStaticPlaylistScreen =
      '/hotelLandingStaticPlaylistScreen';
  static const String hotelLandingDynamicPlaylistScreen =
      '/hotelLandingDynamicPlaylistScreen';

  //InsuranceLandingScreen
  static const String insuranceLandingScreen = '/insuranceLandingScreen';
  static const String insuranceErrorWebViewScreen =
      '/insuranceErrorWebViewScreen';
  static const String carLandingScreen = '/carLandingScreen';
  static const String carSupplierScreen = '/carSupplierScreen';
  static const String carDetailScreen = '/carDetailScreen';

  static const String carDetailInfoScreen = '/carDetailInfoScreen';
  static const String carDetailMoreInfoScreen = '/carDetailMoreInfoScreen';

  static const String carDateTimeSelectionScreen =
      '/carDateTimeSelectionScreen';
  static const String carGalleryScreen = '/carGalleryScreen';
  static const String carSearchSuggestionScreen = '/carSearchSuggestionScreen';
  static const String carSearchPickUpPointsScreen =
      '/carSearchPickUpPointsScreen';
  static const String carSearchResult = '/carSearchResult';
  static const String carReservationScreen = '/carReservationScreen';
  static const String carContactInformation = '/carContactInformation';
  static const String addAdditionalAddons = '/addAdditionalAddons';
  static const String carSearchFilter = '/carSearchFilter';
  static const String carPaymentMainScreen = '/carPaymentMainScreen';
  static const String guestDriverDetailsScreen = '/guestDriverDetailsScreen';
  static const String carBookingDetail = '/carBookingDetail';
  static const String carBookingCancellation = '/carBookingCancellation';
  static const carPaymentSuccessScreen = '/carPaymentSuccessScreen';
  static const String editSearchScreen = '/editSearchScreen';
  static const String otaShareErrorScreen = '/otaShareErrorScreen';
  static const String carRentalVerticalPlaylistScreen =
      '/carRentalVerticalPlaylistScreen';

  static const String toursLandingScreen = '/toursLandingScreen';
  static const String tourSearchScreen = '/tourSearchScreen';
  static const String tourDetailScreen = '/tourDetailScreen';
  static const String ticketDetailScreen = '/ticketDetailScreen';
  static const String tourPackageDetailScreen = '/tourPackageDetailScreen';
  static const String otaDateSelectionScreen = '/otaDateSelectionScreen';
  static const String tourDescriptionScreen = '/tourDescriptionScreen';
  static const String ticketPackageDetailScreen = '/ticketPackageDetailScreen';
  static const String ticketDescriptionScreen = '/ticketDescriptionScreen';
  static const String otaBookingCalenderScreen = '/otaBookingCalenderScreen';
  static const String ticketBookingCalenderScreen =
      '/ticketBookingCalenderScreen';
  static const String tourReservationScreen = '/tourReservationScreen';
  static const String ticketReservationScreen = '/ticketReservationScreen';
  static const String guestInformationFormPage = '/guestInformationFormPage';
  static const String ticketGuestInformationFormPage =
      '/ticketGuestInformationFormPage';
  static const String otaContactInformationFormPage =
      '/otaContactInformationFormPage';
  static const String tourTicketPlaylistScreen = '/tourTicketPlaylistScreen';
  static const String otaReservationSuccessScreen =
      '/otaReservationSuccessScreen';
  static const String tourConfirmBookingScreen = '/tourConfirmBookingScreen';
  static const String ticketConfirmBookingScreen =
      '/ticketConfirmBookingScreen';
  static const String guestDetailScreen = '/guestDetailScreen';
  static const String newPaymentLoadingScreen = '/newPaymentLoadingScreen';
  static const String tourSearchResultScreen = '/tourSearchResultScreen';
  static const String ticketGuestDetailScreen = '/ticketGuestDetailScreen';
  static const String tourLoadingScreen = '/tourLoadingScreen';
  static const String tourSearchFilterScreen = '/tourSearchFilterScreen';
  static const String tourBookingDetailScreen = '/tourBookingDetailScreen';
  static const String ticketBookingDetailScreen = '/ticketBookingDetailScreen';
  static const String otaBookingListScreen = '/otaBookingListScreen';
  static const String tourBookingPackageDetailScreen =
      '/tourBookingPackageDetailScreen';
  static const String ticketBookingPackageDetailScreen =
      '/ticketBookingPackageDetailScreen';
  static const String tourBookingCancellationScreen =
      '/tourBookingCancellationScreen';
  static const String ticketBookingCancellationScreen =
      '/ticketBookingCancellationScreen';
  static const String tourBookingDetailDescriptionScreen =
      '/tourBookingDetailDescriptionScreen';
  static const String ticketBookingDetailDescriptionScreen =
      '/ticketBookingDetailDescriptionScreen';
  static const String appointmentDetailScreen = '/appointmentDetailScreen';
  static const String otaLandingShareErrorScreen =
      '/otaLandingShareErrorScreen';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashScreen: (context) => const SplashScreen(),
      hotelDetail: (context) => const HotelDetailView(),
      facilityDetails: (context) => const FacilityDetailsView(),
      demoScreen: (context) => const DemoScreen(),
      galleryScreen: (context) => const GalleryScreen(),
      galleryOtaScreen: (context) => const OtaGalleryScreen(),
      filterScreen: (context) => const FilterScreen(),
      roomDetails: (context) => const RoomDetailScreen(),
      authLanding: (context) => const AuthLanding(),
      landingPage: (context) => const LandingPage(),
      playlistScreen: (context) => const PlaylistScreen(),
      otaVerticalPlaylistScreen: (context) => const OtaVerticalPlaylistScreen(),
      hotelSearchScreen: (context) => const HotelSearchScreen(),
      hotelListView: (context) => const HotelListView(),
      filterOtaPage: (context) => const FilterOtaPage(),
      reviewFilterScreen: (context) => const ReviewFilterScreen(),
      otaSearchScreen: (context) => const OtaSearchScreen(),
      reservationScreen: (context) => const ReservationScreen(),
      contactInformationFormPage: (context) =>
          const ContactInformationFormPage(),
      addonServiceCalendarScreen: (context) => AddonServiceCalendar(),
      hotelAddonServiceScreen: (context) => const HotelAddonServiceScreen(),
      successScreen: (context) => const SuccessScreen(),
      paymentLoadingScreen: (context) => const PaymentLoadingScreen(),
      hotelPaymentMainScreen: (context) => const HotelPaymentMainScreen(),
      hotelSuccessPaymentScreen: (context) => const HotelSuccessPaymentScreen(),
      paymentMethodListScreen: (context) => const PaymentMethodListScreen(),
      otaFavouritesListingScreen: (context) =>
          const OtaFavouritesListingScreen(),
      otaBookingScreen: (context) => const OtaBookingScreen(),
      hotelBookingDetailScreen: (context) => const HotelBookingDetailsScreen(),
      toursLandingScreen: (context) => const ToursLandingScreen(),
      tourSearchScreen: (context) => const TourSearchSuggestionsScreen(),
      tourDetailScreen: (context) => const TourDetailScreen(),
      ticketDetailScreen: (context) => const TicketDetailScreen(),
      tourReservationScreen: (context) => const TourReservationScreen(),
      ticketReservationScreen: (context) => const TicketReservationScreen(),
      hotelBookingCancellationScreen: (context) =>
          const HotelBookingCancellationScreen(),
      messageAndNotificationScreen: (context) =>
          const MessageAndNotificationScreen(),
      hotelBookingMailerScreen: (context) => const HotelBookingMailerScreen(),
      otaBookingMailerScreen: (context) => const OtaBookingMailerScreen(),
      carBookingMailerScreen: (context) => const CarBookingMailerScreen(),
      preferencesScreen: (context) => const PreferencesScreen(),
      hotelLandingScreen: (context) => const HotelLandingScreen(),
      webViewScreen: (context) => const WebViewScreen(),
      promoDetailScreen: (context) => const PromoDetailScreen(),
      promoCodeSearchScreen: (context) => const PromoCodeSearchScreen(),
      tourPackageDetailScreen: (context) => const TourPackageDetailScreen(),
      otaDateSelectionScreen: (context) => const OtaDateSelectionScreen(),
      tourDescriptionScreen: (context) => const TourDescriptionScreen(),
      ticketPackageDetailScreen: (context) => const TicketPackageDetailScreen(),
      ticketDescriptionScreen: (context) => const TicketDescriptionScreen(),
      otaBookingCalenderScreen: (context) => const TourBookingCalenderScreen(),
      ticketBookingCalenderScreen: (context) =>
          const TicketBookingCalenderScreen(),
      guestInformationFormPage: (context) => const GuestInformation(),
      ticketGuestInformationFormPage: (context) =>
          const TicketGuestInformation(),
      otaContactInformationFormPage: (context) =>
          const OtaContactInformationFormPage(),
      tourTicketPlaylistScreen: (context) => const TourTicketPlaylistScreen(),
      otaReservationSuccessScreen: (context) => const OtaReservationSuccess(),
      tourConfirmBookingScreen: (context) => const TourConfirmBookingScreen(),
      ticketConfirmBookingScreen: (context) =>
          const TicketConfirmBookingScreen(),
      newPaymentLoadingScreen: (context) => const NewPaymentLoadingScreen(),
      tourSearchResultScreen: (context) => const TourSearchResultScreen(),
      guestDetailScreen: (context) => const GuestDetailScreen(),
      ticketGuestDetailScreen: (context) => const TicketGuestDetailScreen(),
      tourLoadingScreen: (context) => const TourLoadingScreen(),
      tourSearchFilterScreen: (context) => const TourSearchFilterScreen(),
      tourBookingDetailScreen: (context) => const TourBookingDetailScreen(),
      ticketBookingDetailScreen: (context) => const TicketBookingDetailScreen(),
      roomGalleryScreen: (context) => const HotelRoomGalleryScreen(),
      otaDateRangePickerScreen: (context) => const OtaDateRangePickerScreen(),
      hotelRoomSelectionScreen: (context) => const HotelRoomSelectionScreen(),
      hotelLandingDynamicPlaylistScreen: (context) =>
          const HotelLandingDynamicPlaylistScreen(),
      hotelLandingStaticPlaylistScreen: (context) =>
          const HotelLandingStaticPlaylistScreen(),
      otaBookingListScreen: (context) => const OtaBookingScreen(),
      tourBookingPackageDetailScreen: (context) =>
          const TourBookingPackageDetailScreen(),
      ticketBookingPackageDetailScreen: (context) =>
          const TicketBookingPackageDetailScreen(),
      tourBookingCancellationScreen: (context) =>
          const TourBookingCancellationScreen(),
      ticketBookingCancellationScreen: (context) =>
          const TicketBookingCancellationScreen(),
      tourBookingDetailDescriptionScreen: (context) =>
          const TourBookingDetailDescriptionScreen(),
      ticketBookingDetailDescriptionScreen: (context) =>
          const TicketBookingDetailDescriptionScreen(),
      appointmentDetailScreen: (context) => const AppointmentDetailScreen(),
      insuranceLandingScreen: (context) => const InsuranceLandingScreen(),
      insuranceErrorWebViewScreen: (context) =>
          const InsuranceErrorWebViewScreen(),
      otaShareErrorScreen: (context) => const OtaShareErrorScreen(),
      carLandingScreen: (context) => const CarLandingScreen(),
      carSupplierScreen: (context) => const CarSupplierScreen(),
      carDetailScreen: (context) => const CarDetailScreen(),
      carDetailInfoScreen: (context) => const CarDetailInfoScreen(),
      carDetailMoreInfoScreen: (context) => const CarDetailMoreInfoScreen(),
      carDateTimeSelectionScreen: (context) =>
          const CarDateTimeSelectionScreen(),
      carGalleryScreen: (context) => const CarGalleryScreen(),
      carSearchSuggestionScreen: (context) => const CarSearchSuggestionScreen(),
      carSearchPickUpPointsScreen: (context) =>
          const CarSearchPickUpPointsScreen(),
      carSearchResult: (context) => const CarSearchResult(),
      carReservationScreen: (context) => const CarReservationScreen(),
      addAdditionalAddons: (context) => const AddAdditionalService(),
      carSearchFilter: (context) => const CarSearchFilter(),
      carContactInformation: (context) => const CarContactInformationFormPage(),
      guestDriverDetailsScreen: (context) => const GuestDriverDetailsScreen(),
      carPaymentMainScreen: (context) => const CarPaymentMainScreen(),
      carBookingDetail: (context) => const CarBookingDetail(),
      carBookingCancellation: (context) => const CarBookingCancellationScreen(),
      carPaymentSuccessScreen: (context) => const CarSuccessfulPaymentScreen(),
      editSearchScreen: (context) => const EditSearchScreen(),
      carRentalVerticalPlaylistScreen: (context) =>
          const CarRentalVerticalPlaylistScreen(),
      otaLandingShareErrorScreen: (context) =>
          const OtaLandingShareErrorScreen(),
    };
  }
}
