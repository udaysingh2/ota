class HotelDetailActivityStatusResponse {
  static String getDetailsActivityStatus(
      String activityStatus,
      ) {
    return """
{
      "data": {
      "__typename": "BookingDetailsResponseObject",
      "bookingStatus": "CONFIRMED",
      "bookingStatusCode": null,
      "bookingId": "B2CMMA220211084",
      "bookingUrn": "H220228-AA-0068",
      "referenceId": "B2CMMA220211084",
      "bookingType": "HOTEL",
      "activityStatus": "$activityStatus",
    "promotion": {
    "promotionId": 1,
    "promotionName": "RBH Special",
    "shortDescription": "ส่วนลดมูลค่า 50 บาท",
    "discount": 40,
    "maximumDiscount": 100.6,
    "discountType": "PERCENT",
    "discountFor": "ORDER",
    "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
    "promotionType": "PUBLIC",
    "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
    "voucherCode": "RBH50",
    "promotionCode": "RBH50",
    "startDate": "2020-07-24T08:44:39.000+00:00",
    "endDate": "2020-07-24T08:44:39.000+00:00",
    "applicationKey": "HOTEL"
  },
  "priceDetails": {
    "effectiveDiscount": 80,
    "orderPrice": 200,
    "addonPrice": 200,
    "billingAmount": 320,
    "totalAmount": 400
  },
      "hotelBookingDetail": {
        "__typename": "HotelBookingDetailsParentObj",
        "totalPrice": 4950,
        "hotelDetails": {
          "__typename": "BookingHotelDetailsObj",
          "cityId": "MA05110041",
          "hotelId": "MA1012120002",
          "name": "แกรนด์ โฟร์วิงส์ คอนเวนชั่น",
          "countryId": "MA05110001",
          "imageUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/grand_four_wings_convention-general1.jpg",
          "checkInDate": "2022-03-01",
          "checkOutDate": "2022-03-02",
          "address": "333 ถ.ศรีนครินทร์ บางกะปิ หัวหมาก, 10240, กรุงเทพมหานคร, ประเทศไทย",
          "phoneNumber": "(66) 2378 - 8000",
          "rating": null,
          "latitude": "13.754071606896346",
          "longitude": "100.64594955649227",
          "roomInfo": {
            "__typename": "RoomInfoObject",
            "roomOfferName": null,
            "promoteFlag": null,
            "dimension": null,
            "doubleBedFlag": null,
            "twinBedFlag": null,
            "queenBedflag": null,
            "smorkingFlag": null,
            "nonSmorkingFlag": null,
            "noWindowFlag": null,
            "balconyFlag": null,
            "wifiFlag": null,
            "maxPaxNbr": null,
            "roomFacilities": []
          },
          "freeFoodDelivery": true,
          "roomDetails": [
            {
              "__typename": "BookingRoomDetailsObj",
              "type": "Double",
              "price": "4950",
              "name": "EXECUTIVE ROOM",
              "noOfRoom": "1",
              "noOfAdult": "2",
              "noOfChild": "0",
              "priceOfRoomWithChildMeal": 0,
              "noOfRoomsAndName": "1 x EXECUTIVE ROOM"
            }
          ],
          "facilities": [
            {
              "__typename": "BaseMap",
              "key": "PAYMENT",
              "value": "instant.payment"
            },
            {
              "__typename": "BaseMap",
              "key": "NO_OF_ROOMS_AND_NAME",
              "value": "1 x EXECUTIVE ROOM"
            }
          ],
          "guestInfo": [
            {
              "__typename": "GuestInfoResponseObject",
              "firstName": "ygggh",
              "lastName": "gggghh",
              "title": "Khun"
            }
          ],
          "addOnServices": [
          {
           "serviceName": "",
           "price": "",
           "noOfItem":"",
           "serviceDate": "30-01-2022"
           }
           ],
          "cancellationPolicy": [
            {
              "__typename": "CancellationPolicyObject",
              "days": null,
              "cancellationDaysDescription": null,
              "cancellationChargeDescription": "การจองครั้งนี้ตกอยู่ภายใต้เงื่อนไขที่จะไม่สามารถเรียกร้องขอคืนเงินได้ในทุกกรณี เมื่อมีการยกเลิกการจอง,เช็คอินล่าช้า,เช็คเอาท์ก่อนเวลาหรือไม่มาไม่แสดงตัวเพื่อรับบริการ",
              "cancellationStatus": null
            }
          ],
          "totalNights": "1",
          "totalRooms": "1",
          "promotion": [
            {
              "__typename": "PromotionObjectList",
              "productId": "MA1012120002",
              "productType": "HOTEL",
              "promotionType": "OVERLAY",
              "promotionCode": "FREE01",
              "line1": "การลดราคา",
              "line2": "50%",
              "startDate": "2022-02-10 11:00:00",
              "endDate": "2022-07-10 23:59:00"
            },
            {
              "__typename": "PromotionObjectList",
              "productId": "MA1012120002",
              "productType": "HOTEL",
              "promotionType": "CAPSULE",
              "promotionCode": "FREEDELIVERY",
              "line1": null,
              "line2": null,
              "startDate": "2022-02-09 22:00:00",
              "endDate": "2022-07-09 23:59:00"
            },
            {
              "__typename": "PromotionObjectList",
              "productId": "MA1012120002",
              "productType": "HOTEL",
              "promotionType": "CAPSULE",
              "promotionCode": "FREEDELIVERY",
              "line1": null,
              "line2": null,
              "startDate": "2022-02-09 22:00:00",
              "endDate": "2022-07-09 23:59:00"
            }
          ],
          "hotelBenefits": [
            {
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						},
             {
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						},
             {
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						},
             {
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						},
             {
							"topic": "RBH Privilege",
							"shortDescription": "Special privileges for customers ",
							"longDescription": "Special privileges for customers to receive Vouchers worth 5000 can be used instead of cash in the hotel.",
							"categoryId": "5",
							"categoryName": "RBH Privilege"
						}
            ]
        },
        "netPrice": 4950,
        "perNightPrice": 4950,
        "addonPrice": 0,
        "discount": 0,
        "amountAdminfee": 0,
        "amountCancelCharge": 0,
        "paymentDetails": {
          "__typename": "PaymentDetailsResponseObject",
          "paymentMethod": "SCB EASY",
          "paymentStatus": "SUCCESS",
          "cardType": null,
          "cardNo": null,
          "cardNickName": null
        },
        "cancellationDate": null,
        "cancellationReason": null,
        "totalRefundAmount": 0,
        "confirmationDate": "2022-02-28"
      }
    }
}
    
""";
  }
}
