class QueryNames {
  const QueryNames._internal();
  factory QueryNames() {
    return shared;
  }
  static const QueryNames shared = QueryNames._internal();
  final String getRefreshToken = "getRefreshToken";
  final String getLoginDetails = "getLoginDetails";
  final String getLogoutDetails = "getLogoutDetails";
  final String getConfigDetails = "getConfigDetails";
  final String bookingConfirmation = "BookingConfirmation";
  final String updateCustomerDetails = "updateCustomerDetails";
  final String getAllFavorites = "getAllFavorites";
  final String deleteFavorite = "deleteFavorite";
  final String getImages = "getImages";
  final String getCustomerDetails = "getCustomerDetails";
  final String initiateBooking = "initiateBookingV2";
  final String getAddonServices = "getAddonServices";
  final String getBookingSummary = "getBookingSummary";
  final String rejectBooking = "rejectBooking";
  final String bookingDetails = "bookingDetailsV2";
  final String sendEmailConfirmation = "sendEmailConfirmation";
  final String addFavorite = "addFavorite";

  final String getHotelDetails = "getHotelDetails";
  final String checkFavorites = "checkFavorites";
  final String getHotelsYouMayLike = "getHotelsYouMayLike";
  final String getPlaylists = "getPlaylists";
  final String getRecommendedLocation = "getRecommendedLocation";
  final String getRoomDetails = "getRoomDetailsV2";
  final String getRecentViewPlaylist = "getRecentViewPlaylist";
  final String getBanners = "getBanners";
  final String getLandingPageDetails = "getLandingPageDetails";
  final String getServiceCard = "getServiceCard";
  final String getLoadScreen = "getLoadScreen";
  final String notificationRemove = "notificationRemove";
  final String notificationRead = "notificationRead";
  final String notificationInquiry = "notificationInquiry";
  final String getCustomerPaymentMethodDetails =
      "getCustomerPaymentMethodDetails";
  final String initiatePayment = "initiatePayment";
  final String initiatePaymentV2 = "initiatePaymentV2";
  final String paymentStatus = "paymentStatus";
  final String generateNewBookingUrn = "generateNewBookingUrn";
  final String getDynamicPlaylists = "getDynamicPlaylists";
  final String getStaticPlaylists = "getStaticPlaylists";
  final String getPopups = "getPopups";
  final String userPreferencePopup = "userPreferencePopup";
  final String getPreferences = "getPreferences";
  final String createPreference = "createPreference";
  final String getRoomImages = "getRoomImages";
  final String getOtaSearchResult = "getOtaSearchResult";
  final String getSearchRecommendation = "getSearchRecommendation";
  final String getSearchSuggestion = "getSearchSuggestion";
  final String getSplashScreen = "getSplashScreen";
  final String loadTranslation = "loadTranslation";
  final String searchPromoCode = "searchPromoCode";
  final String removePromoCode = "RemovePromoCode";
  final String applyPromoCode = "applyPromoCode";
  final String getAvailablePublicPromotions = "getAvailablePublicPromotions";
  final String getVaBalance = "getVaBalance";

  //TOUR
  final String getFavourites = "getFavourites";
  final String checkFavorite = "checkFavorite";
  final String removeFavorite = "removeFavorite";
  final String markFavorite = "markFavorite";
  final String getGalleryImages = "getGalleryImages";
  final String sendOtaBookingMailer = "sendOtaBookingMailer";
  final String getOtaStaticPlaylist = "getOtaStaticPlaylist";
  final String getTicketConfirmBookingData = "getTicketConfirmBookingData";
  final String getTicketPackageDetails = "getTicketPackageDetails";
  final String getTicketDetails = "getTicketDetails";
  final String getTicketReviewReservationData =
      "getTicketReviewReservationData";
  final String getTicketCancellationDetail = "getTicketCancellationDetail";
  final String getTicketBookingDetail = "otaBookingDetailsV2";
  final String getTourConfirmBookingData = "getTourConfirmBookingData";
  final String getTourDetails = "getTourDetails";
  final String getTourPackageDetails = "getTourPackageDetails";
  final String getTourAttractionsData = "getTourAttractionsData";
  final String getTourLoadingData = "getTourLoadingData";
  final String getTourBookingListData = "getTourBookingListData";
  final String getPaymentInitiateData = "getPaymentInitiateData";
  final String getNewBookingUrnData = "getNewBookingUrnData";
  final String getPaymentStatusData = "getPaymentStatusData";
  final String getTourTicketPlaylistData = "getTourTicketPlaylistData";
  final String getPickUpPointDetail = "getPickUpPointDetail";
  final String getTourReviewReservationData = "getTourReviewReservationData";
  final String saveTourSearchHistoryData = "saveTourSearchHistoryData";
  final String getTourSearchHistoryData = "getTourSearchHistoryData";
  final String getTourSearchSuggestionsData = "getTourSearchSuggestionsData";
  final String getTourSearchFilterData = "getTourSearchFilterData";
  final String getTourSearchResultData = "getTourSearchResultData";
  final String getServiceCardData = "getServiceCardData";
  final String getTourCancellationDetail = "getTourCancellationDetail";
  final String getTourBookingDetail = "otaBookingDetailsV2";
  final String getTourRecentPlaylist = "getTourRecentPlaylist";
  final String getInsurance = "getInsurance";
  final String checkCarFavorites = "checkCarFavorites";
  final String getCarRentalFavorites = "getCarRentalFavorites";
  final String getFavorites = "getFavorites";
  final String getCarRentalRecentSearches = "getCarRentalRecentSearches";
  final String getDataScienceAutoCompleteSearch =
      "getDataScienceAutoCompleteSearch";
  final String saveRecentCarRentalSearchHistory =
      "saveRecentCarRentalSearchHistory";
  final String getCarRentalSupplier = "getCarRentalSupplier";
  final String getSortCriteriaForService = "getSortCriteriaForService";
  final String getCarInitiateBookingResponse = "getCarInitiateBookingResponse";
  final String getCarRentalSearchResult = "getCarRentalSearchResult";
  final String getAllCarRentalImages = "getAllCarRentalImages";
  final String getCarRentalDetails = "getCarRentalDetails";
  final String getCarBookingCancellationData = "getCarBookingCancellationData";
  final String getCarBookingListData = "getCarBookingListData";
  final String sendCarBookingMailer = "sendCarBookingMailer";
  final String getRecentSearches = "getRecentSearches";
  final String clearRecentSearch = "clearRecentSearch";
  final String getCarPaymentData = "getCarPaymentData";
  final String getCarBookingDetailData = "otaBookingDetailsV2";
  final String getHotelSearchRecommendation = "getHotelSearchRecommendation";
  final String saveGuestRecentSearchPlaylistHistory =
      "saveGuestRecentSearchPlaylistHistory";
}
