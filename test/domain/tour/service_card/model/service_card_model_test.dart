import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  String jsonData = fixture("tour/service_card/service_card_mock.json");
  ServiceCardModelDomain serviceCardModelDomain =
      ServiceCardModelDomain.fromJson(jsonData);
  test("Tour Service Card model domain test", () {
    String stringData = serviceCardModelDomain.toString();
    expect(stringData.isNotEmpty, true);

    String jsonData = serviceCardModelDomain.toJson();
    expect(jsonData.isNotEmpty, true);
  });
  test("Tour Service card GetTourServiceCards", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    GetTourServiceCards getTourServiceCards =
        GetTourServiceCards.fromJson(jsonData);
    Map<String, dynamic> map = getTourServiceCards.toMap();

    GetTourServiceCards mapFromModel = GetTourServiceCards.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data = mapFromModel.toJson();
    expect(data.isNotEmpty, true);
  });
  test("Tour and Ticket Service", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    Ticket ticket = Ticket.fromJson(jsonData);
    Map<String, dynamic> map = ticket.toMap();

    Ticket mapFromModel = Ticket.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data1 = mapFromModel.toJson();
    expect(data1.isNotEmpty, true);
  });
  test("Tour Service Card data", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    Data data = Data.fromJson(jsonData);
    Map<String, dynamic> map = data.toMap();

    Data mapFromModel = Data.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data1 = mapFromModel.toJson();
    expect(data1.isNotEmpty, true);
  });
  test("Tour Service Card Status", () {
    String jsonData =
        fixture("tour/search_filter/tour_search_filter_mock.json");

    Status status = Status.fromJson(jsonData);
    Map<String, dynamic> map = status.toMap();

    Status mapFromModel = Status.fromMap(map);

    String stringData = mapFromModel.toString();
    expect(stringData.isNotEmpty, true);

    String data1 = mapFromModel.toJson();
    expect(data1.isNotEmpty, true);
  });
}
