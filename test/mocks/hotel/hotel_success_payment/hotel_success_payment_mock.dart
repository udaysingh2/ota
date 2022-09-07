import 'package:ota/core/app_config.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';

HotelSuccessPaymentArgumentModel getHotelSuccessPaymentArgumentModel() {
  return HotelSuccessPaymentArgumentModel(
    addonsModels: [
      AddonsModel(
        cost: "2100",
        description: "description",
        imageUrl:
            "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
        quantity: "2",
        selectedDate: DateTime.now(),
        serviceName: "Golf Course",
        uniqueId: "279",
      ),
      AddonsModel(
        cost: "1200",
        description: "description",
        imageUrl:
            "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
        quantity: "1",
        selectedDate: DateTime.now().add(const Duration(days: 1)),
        serviceName: "Spa Aroma",
        uniqueId: "280",
      ),
    ],
    cancellationPolicyStatus: "policy.cancellation.free",
    checkInDate: DateTime.now(),
    checkOutDate: DateTime.now().add(const Duration(days: 3)),
    currency: AppConfig().currency,
    facilityMap: [
      FacilityList(
        key: "Wifi",
        value: "free.wifi",
      ),
      FacilityList(
        key: "Payment",
        value: "instant.payment",
      ),
    ],
    hotelId: "MA1111000019",
    imageUrl:
        "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg",
    numberOfAdults: 2,
    numberOfChildren: 2,
    numberOfNights: 3,
    numberOfRooms: 2,
    offerName: "Superior Room Only",
    pricePerNight: 1200,
    propertyName: "Amora Neoluxe Bangkok",
    roomCode: "MA02033539",
    roomDetailsList: [
      RoomDetails(
          category: "Superior", numberOfRooms: 2, roomType: "Double Bed"),
      RoomDetails(
          category: "Superior", numberOfRooms: 1, roomType: "Triple Bed"),
    ],
  );
}

List<ServiceViewModel> getLandingPageServiceCards() {
  return [
    ServiceViewModel(
      deepLinkUrl: "https://robinhood/",
      description: "100,000+ Hotels",
      imageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      largeImageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      service: "HOTEL",
      serviceText: "Hotels",
      title: "more than 1,000",
    ),
    ServiceViewModel(
      deepLinkUrl: "https://robinhood/",
      description: "100,000+ Hotels",
      imageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      largeImageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      service: "FLIGHT",
      serviceText: "Flights",
      title: "more than 1,000",
    ),
    ServiceViewModel(
      deepLinkUrl: "https://robinhood/",
      description: "100,000+ Hotels",
      imageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      largeImageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      service: "TOUR",
      serviceText: "Tours And Activities",
      title: "more than 1,000",
    ),
    ServiceViewModel(
      deepLinkUrl: "https://robinhood/",
      description: "100,000+ Hotels",
      imageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      largeImageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      service: "CARRENTAL",
      serviceText: "Car Rentals",
      title: "more than 1,000",
    ),
    ServiceViewModel(
      deepLinkUrl: "https://robinhood/",
      description: "100,000+ Hotels",
      imageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      largeImageUrl: "https://www.linkpicture.com/q/hotel_card.png",
      service: "INSURANCE",
      serviceText: "Insurance",
      title: "more than 1,000",
    ),
  ];
}
