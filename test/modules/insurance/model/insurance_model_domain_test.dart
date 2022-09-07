import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/insurance/data_source/insurance_mock_data_source.dart';
import 'package:ota/domain/insurance/models/insurance_model_domain.dart';

void main() {
  test("Insuarance Model Domain test", () {
    Map<String, dynamic> jsonMap =
        json.decode(InsuranceMockDataSourceImpl.getMockData());

    ///For class Insurance Model Domain
    InsuranceModelDomain insuranceModelDomain =
        InsuranceModelDomain.fromMap(jsonMap);
    String jsonStringData = insuranceModelDomain.toJson();
    InsuranceModelDomain messageJson =
        InsuranceModelDomain.fromJson(jsonStringData);
    expect(messageJson.getInsurance != null, true);

    ///For class get GetInsurance
    GetInsurance? getInsurance = insuranceModelDomain.getInsurance;
    String insuranceString = getInsurance!.toJson();
    GetInsurance? bookingJson = GetInsurance?.fromJson(insuranceString);
    expect(bookingJson.data != null, true);

    ///For class Data
    Data? data = insuranceModelDomain.getInsurance!.data;
    String dataString = data!.toJson();
    Data? dataJson = Data?.fromJson(dataString);
    expect(dataJson.insurances != null, true);

    ///For class Insurance List
    Insurance? insuranceList =
        insuranceModelDomain.getInsurance!.data!.insurances![0];
    String insuranceListStringData = insuranceList.toJson();
    Insurance? insuranceListJson = Insurance?.fromJson(insuranceListStringData);
    expect(insuranceListJson.insuranceCategories != null, true);

    ///For class Promotion List
    Popup? popup =
        insuranceModelDomain.getInsurance!.data!.insurances![0].popup;
    String popupStringData = popup!.toJson();
    Popup? popupListJson = Popup?.fromJson(popupStringData);
    expect(popupListJson.actionType != null, true);

    ///For class Promotion List
    Promotions? promotions =
        insuranceModelDomain.getInsurance!.data!.insurances![0].promotions;
    String promotionStringData = promotions!.toJson();
    Promotions? promotionListJson = Promotions?.fromJson(promotionStringData);
    expect(promotionListJson.promotionTextLine1 != null, true);

    ///For class Status
    Status? status = insuranceModelDomain.getInsurance?.status;
    String statusStringData = status!.toJson();
    Status? statusJson = Status?.fromJson(statusStringData);
    expect(statusJson.code != null, true);
  });
}
