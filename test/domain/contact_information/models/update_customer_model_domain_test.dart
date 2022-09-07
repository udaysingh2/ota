import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/contact_information/data_sources/update_customer_mock.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';

void main() {
  test("Hotel Bookings List Test", () {
    Map<String, dynamic> map =
        json.decode(UpdateCustomerMockDataSourceImpl.getMockData());
    Map<String, dynamic> jsonMap = map["data"];

    ///For class Message Model Domain
    UpdateCustomerData updateCustomerData = UpdateCustomerData.fromMap(jsonMap);
    String jsonStringData = updateCustomerData.toJson();
    UpdateCustomerData messageJson =
        UpdateCustomerData.fromJson(jsonStringData);
    expect(messageJson.updateCustomerDetails != null, true);

    ///For class get Notification Inquiry
    UpdateCustomerDetails? updateCustomerDetails =
        updateCustomerData.updateCustomerDetails;
    String bookingString = updateCustomerDetails!.toJson();
    UpdateCustomerDetails? bookingJson =
        UpdateCustomerDetails?.fromJson(bookingString);
    expect(bookingJson.data != null, true);

    ///For class Data
    Data? data = updateCustomerData.updateCustomerDetails?.data;
    String dataString = data!.toJson();
    Data? dataJson = Data?.fromJson(dataString);
    expect(dataJson.email != null, true);

    ///For class Status
    Status? status = updateCustomerData.updateCustomerDetails?.status;
    String statusString = status!.toJson();
    Status? statusJson = Status?.fromJson(statusString);
    expect(statusJson.code != null, true);
  });
}
