import 'package:ota/domain/search/models/ota_search_argument.dart';
import 'package:ota/domain/search/models/ota_search_model.dart';

import 'ota_search_remote_data_source.dart';

class OtaSearchMockDataSourceImpl implements OtaSearchRemoteDataSource {
  OtaSearchMockDataSourceImpl();
  @override
  Future<OtaSearchData> getOtaSearchData(OtaSearchDataArgument argument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return OtaSearchData.fromJson(_responseMock);
  }
}

var _responseMock = """
{
		"getOtaSearchResult": {
			"data": {
				"hotel": {
					"filter": {
						"minPrice": 1000,
						"maxPrice": 1000,
						"rating": [
							3
						],
						"reviewScore": [
							4
						],
						"adminPromotion": [
							"แอดมิน โปรโม1"
						],
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"infotechPromotion": [
							"ออรี่เบิร์ด"
						],
						"promotion": null,
						"availableHotel": null
					},
					"hotelList": [{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					},{
						"locationName": "ปากช่อง",
						"countryId": "MA05110001",
						"address": "ปากช่อง, นครราชสีมา",
						"sortSequence": 0,
						"hotelStatus": "open",
						"hotelId": "MA1809001981",
						"hotelName": "แคปปิตอล เจ เขาใหญ่",
						"hotelImage": "https://trbhmanage.travflex.com/ImageData/Hotel/capital_j_at_khao_yai-general1.jpg",
						"rating": 3,
						"percentageDiscount": 17,
						"rackRate": 1200,
						"rackRatePerNight": 200,
						"totalPrice": 1000,
						"pricePerNight": 1000,
						"ratingTitle": null,
						"reviewText": null,
						"offerPercent": null,
						"discount": null,
						"adminPromotionLine1": "แอดมิน",
						"adminPromotionLine2": "โปรโม1",
						"capsulePromotion": [{
							"name": "ส่งอาหารฟรี",
							"code": "FREE01"
						}],
						"review": {
							"score": 4,
							"totalReview": 10,
							"reviewText": "superb"
						},
						"cityName": "นครราชสีมา",
						"score": null,
						"infotech11Promotion": null
					}]
				},
				"tourActivity": {
					"filter": {
						"minPrice": 1445,
						"maxPrice": 1884,
						"styleName": [
							"styleName1",
							"styleName2"
						]
					},
					"tourActivityList": [{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            }]
				},
				"ticketActivity": {
					"filter": {
						"minPrice": 0,
						"maxPrice": 30000,
						"styleName": [
							"สวนสนุก",
							"สถานที่ท่องเที่ยว"
						]
					},
					"ticketActivityList": [{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
                {
                  "name": "ส่งอาหารฟรี",
                  "code": "FREE01"
                }
              ]
            },{
              "id": "MA2110000373",
              "name": "เกาะพีพี1",
              "styleName": "styleName1",
              "locationName": "Ko Phi Phi",
              "cityId": "MA05110062",
              "cityName": "ภูเก็ต",
              "countryId": "MA05110001",
              "countryName": "ไทย",
              "imageUrl": "https://trbhmanage.travflex.com/SightSeeing/images/350/CL213/koh-phi-phi-ma2110000373-general1.jpg",
              "startPrice": 1445,
              "promotionText_line1": "โปรโมชัน_1",
              "promotionText_line2": "โปรโมชัน_2",
              "capsulePromotion": [
              ]
            }]
				}
			},
			"status": {
				"code": "1000",
				"header": "",
				"description": "Success"
			}
		}
	}
""";
