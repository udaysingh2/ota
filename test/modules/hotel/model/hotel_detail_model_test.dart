import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  test("Hotel Detail Model Test", () {
    Map<String, dynamic> jsonMap =
        json.decode(fixture("hotel/hotel_with_full_list_mock.json"));

    ///For class HotelDetailModelDomain
    HotelDetailModelDomain hotelDetailModelDomain =
        HotelDetailModelDomain.fromMap(jsonMap);
    String jsonData = hotelDetailModelDomain.toJson();
    HotelDetailModelDomain hotelDetailJson =
        HotelDetailModelDomain.fromJson(jsonData);
    expect(hotelDetailJson.getHotelDetails != null, true);

    ///For class GetHotelDetails
    GetHotelDetails? hotel = hotelDetailModelDomain.getHotelDetails;
    String jsonStringData = hotel!.toJson();
    GetHotelDetails hotelJson = GetHotelDetails.fromJson(jsonStringData);
    expect(hotelJson.data != null, true);

    ///For class Data
    Data? data = hotel.data;
    String dataString = data!.toJson();
    Data? dataJson = Data?.fromJson(dataString);
    expect(dataJson.address != null, true);

    ///For class Facilities
    Facilities? facilities = hotel.data?.facilities;
    String facilitiesData = facilities!.toJson();
    Facilities? facilitiesJson = Facilities?.fromJson(facilitiesData);
    expect(facilitiesJson.list != null, true);

    ///For class ListElement
    ListElement? listElement = hotel.data?.facilities?.list?.first;
    String listElementData = listElement!.toJson();
    ListElement? listElementJson = ListElement?.fromJson(listElementData);
    expect(listElementJson.key != null, true);

    ///For class Promotions
    Promotions? promotions = hotel.data?.promotions![0];
    String promotionsData = promotions!.toJson();
    Promotions? promotionsJson = Promotions?.fromJson(promotionsData);
    expect(promotionsJson.title != null, true);

    ///For class Images
    Images? images = hotel.data?.images;
    String imagesStringData = images!.toJson();
    Images? imagesJson = Images?.fromJson(imagesStringData);
    expect(imagesJson.baseUri != null, true);

    ///For class Room
    Room? room = hotel.data?.rooms![0];
    String roomStringData = room!.toJson();
    Room roomJson = Room?.fromJson(roomStringData);
    expect(roomJson.details != null, true);

    ///For class Detail
    Detail? detail = hotel.data?.rooms![0].details![0];
    String detailStringData = detail!.toJson();
    Detail detailJson = Detail?.fromJson(detailStringData);
    expect(detailJson.nightPrice != null, true);

    ///For class Hotel Benefits
    HotelBenefits? hotelBenefits =
        hotel.data?.rooms![1].details![1].hotelBenefits![0];
    String hotelBenefitsData = hotelBenefits!.toJson();
    HotelBenefits hotelBenefitsJson =
        HotelBenefits?.fromJson(hotelBenefitsData);
    expect(hotelBenefitsJson.categoryName != null, true);

    ///For class Room Info
    RoomInfo? roomInfo = hotel.data?.rooms![0].roomInfo;
    String roomInfoData = roomInfo!.toJson();
    RoomInfo roomInfoJson = RoomInfo?.fromJson(roomInfoData);
    expect(roomInfoJson.promoteFlag != null, true);

    ///For class Room Offer
    RoomOffer? roomOffer = hotel.data?.rooms![0].details![0].roomOffer;
    String roomOfferStringData = roomOffer!.toJson();
    RoomOffer roomOfferJson = RoomOffer?.fromJson(roomOfferStringData);
    expect(roomOfferJson.cancellationPolicy != null, true);

    ///For class Room Facility
    RoomFacility? roomFacility =
        hotel.data?.rooms![0].roomInfo?.roomFacilities![0];
    String roomFacilityData = roomFacility!.toJson();
    RoomFacility roomFacilityJson = RoomFacility?.fromJson(roomFacilityData);
    expect(roomFacilityJson.name != null, true);

    // ///For class Metadata
    Metadata? metadata = hotel.metadata;
    String? metadataStringData = metadata?.toJson();
    Metadata metadataJson = Metadata?.fromJson(metadataStringData!);
    expect(metadataJson.source != null, true);

    ///For class Status
    Status? status = hotel.status;
    String? statusStringData = status?.toJson();
    Status statusJson = Status?.fromJson(statusStringData!);
    expect(statusJson.code != null, true);
  });
}
