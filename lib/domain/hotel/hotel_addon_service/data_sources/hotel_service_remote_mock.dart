import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';

class HotelServicelMockDataSourceImpl implements HotelServiceRemoteDataSource {
  HotelServicelMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<HotelServiceResultModel> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    await Future.delayed(const Duration(seconds: 1));
    return HotelServiceResultModel.fromJson(_responseMock);
  }
}

String _responseMock = '''{
  "getAddonServices": {
    "data": {
      "hotelEnhancements": [
        {
          "hotelEnhancementId": "279",
          "hotelEnhancementName": "Golf Course",
          "currency": "THB",
          "price": "2100",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "280",
          "hotelEnhancementName": "Spa Aroma",
          "currency": "THB",
          "price": "2300",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "281",
          "hotelEnhancementName": "Buffet",
          "currency": "THB",
          "price": "200",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "282",
          "hotelEnhancementName": "Buffet 01",
          "currency": "THB",
          "price": "210",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "283",
          "hotelEnhancementName": "Golf Course 01",
          "currency": "THB",
          "price": "2100",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "284",
          "hotelEnhancementName": "Spa Aroma 01",
          "currency": "THB",
          "price": "2300",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "285",
          "hotelEnhancementName": "Buffet 02",
          "currency": "THB",
          "price": "200",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "286",
          "hotelEnhancementName": "Buffet 03",
          "currency": "THB",
          "price": "210",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "287",
          "hotelEnhancementName": "Golf Course 06",
          "currency": "THB",
          "price": "2100",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        },
        {
          "hotelEnhancementId": "288",
          "hotelEnhancementName": "Spa Aroma 07",
          "currency": "THB",
          "price": "2300",
          "image": "https://trbhmanage.travflex.com/ImageData/Miscellaneous/misc-279-golf_course.jpg",
          "isFlight": false,
          "description": "<p>Courtyard By Marriott Bangkok has Muang Kaew Golf Club (10.0), Navathanee Golf Course (30.0), Muang ake Golf Course (30.0), Alpine Golf and Sport Club (40.0).</p>"
        }
      ]
    }
  }
}''';
