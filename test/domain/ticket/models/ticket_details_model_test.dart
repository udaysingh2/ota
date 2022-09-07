import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tickets/details/data_source/ticket_details_mock_data_source.dart';
import 'package:ota/domain/tickets/details/models/ticket_detail_argument_domain.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';

void main() {
  TicketDetailArgumentDomain argument = TicketDetailArgumentDomain(
    cityId: "MA05110041",
    countryId: 'MA05110001',
    ticketId: 'MA05110042',
    ticketDate: '2021-12-26',
  );

  TestWidgetsFlutterBinding.ensureInitialized();
  TicketDetailsMockDataSource ticketDetailsMockDataSource =
      TicketDetailsMockDataSource();
  ticketDetailsMockDataSource.getTicketDetails(argument);
  TicketDetail? ticketDetail;
  test("TicketDetails Model", () async {
    ticketDetail = await ticketDetailsMockDataSource.getTicketDetails(argument);

    ///Convert into Model
    TicketDetail model = ticketDetail!;
    expect(model.getTicketDetails != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    TicketDetail mapFromModel = TicketDetail.fromMap(map);
    expect(mapFromModel.getTicketDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    TicketDetail modelFromJson = TicketDetail.fromJson(jsonData);
    expect(modelFromJson.getTicketDetails != null, true);
  });
  test("Details Model", () {
    ///Convert into Model
    GetTicketDetails? model = ticketDetail?.getTicketDetails;
    expect(model?.data != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    GetTicketDetails mapFromModel = GetTicketDetails.fromMap(map);
    expect(mapFromModel.data != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    GetTicketDetails modelFromJson = GetTicketDetails.fromJson(jsonData);
    expect(modelFromJson.data != null, true);
  });
  test("Data Details Model", () {
    ///Convert into Model
    Data? model = ticketDetail?.getTicketDetails?.data;
    expect(model?.ticket != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Data mapFromModel = Data.fromMap(map);
    expect(mapFromModel.ticket != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Data modelFromJson = Data.fromJson(jsonData);
    expect(modelFromJson.ticket != null, true);
  });
  test("Ticket Model", () {
    ///Convert into Model
    Ticket? model = ticketDetail?.getTicketDetails?.data?.ticket;
    expect(model?.id != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Ticket mapFromModel = Ticket.fromMap(map);
    expect(mapFromModel.id != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Ticket modelFromJson = Ticket.fromJson(jsonData);
    expect(modelFromJson.id != null, true);
  });

  test("Information Model", () {
    ///Convert into Model
    Information? model =
        ticketDetail?.getTicketDetails?.data?.ticket?.information;
    expect(model?.description != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Information mapFromModel = Information.fromMap(map);
    expect(mapFromModel.description != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Information modelFromJson = Information.fromJson(jsonData);
    expect(modelFromJson.description != null, true);
  });

  test("Package Model", () {
    ///Convert into Model
    List<Package>? model =
        ticketDetail?.getTicketDetails?.data?.ticket?.packages;
    expect(model!.isNotEmpty, true);

    ///convert into map
    Map<String, dynamic> map = model[0].toMap();

    ///Check map conversion
    Package mapFromModel = Package.fromMap(map);
    expect(mapFromModel.name != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model[0].toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Package modelFromJson = Package.fromJson(jsonData);
    expect(modelFromJson.name != null, true);
  });

  test("ChildInfo Model", () {
    ///Convert into Model
    ChildInfo? model =
        ticketDetail?.getTicketDetails?.data?.ticket?.packages?[0].childInfo;
    expect(model?.minAge != 0, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    ChildInfo mapFromModel = ChildInfo.fromMap(map);
    expect(mapFromModel.minAge != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    ChildInfo modelFromJson = ChildInfo.fromJson(jsonData);
    expect(modelFromJson.minAge != null, true);
  });

  test("Inclusions Model", () {
    ///Convert into Model
    Inclusions? model =
        ticketDetail?.getTicketDetails?.data?.ticket?.packages?[0].inclusions;
    expect(model?.all != null, true);

    ///convert into map
    Map<String, dynamic> map = model!.toMap();

    ///Check map conversion
    Inclusions mapFromModel = Inclusions.fromMap(map);
    expect(mapFromModel.all != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Inclusions modelFromJson = Inclusions.fromJson(jsonData);
    expect(modelFromJson.all != null, true);
  });

  test("Highlight Model", () {
    ///Convert into Model
    List<Highlight>? model = ticketDetail
        ?.getTicketDetails?.data?.ticket?.packages?[0].inclusions?.highlights;
    expect(model!.isNotEmpty, true);

    ///convert into map
    Map<String, dynamic> map = model[0].toMap();

    ///Check map conversion
    Highlight mapFromModel = Highlight.fromMap(map);
    expect(mapFromModel.key != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model[0].toJson();
    expect(jsonData.isNotEmpty, true);

    ///Check map conversion
    Highlight modelFromJson = Highlight.fromJson(jsonData);
    expect(modelFromJson.key != null, true);
  });
}
