import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_payment/models/car_payment_model_domain.dart';

import '../../../../mocks/fixture_reader.dart';

void main() {
  final String json = fixture("car_payment/car_payment.json");
  CarPaymentDomainModelData carPaymentDomainModelData =
      CarPaymentDomainModelData.fromJson(json);
  SaveCarBookingConfirmationDetails saveCarBookingConfirmationDetails =
      SaveCarBookingConfirmationDetails.fromJson(json);

  AddOnService addOnService = AddOnService.fromJson(json);
  CancellationPolicy cancellationPolicy = CancellationPolicy.fromJson(json);

  test("car payment Model Domain", () {
    ///Convert into Model
    CarPaymentDomainModelData model = carPaymentDomainModelData;
    expect(model.saveCarBookingConfirmationDetails != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CarPaymentDomainModelData mapFromModel =
        CarPaymentDomainModelData.fromMap(map);
    expect(mapFromModel.saveCarBookingConfirmationDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car payment Model Domain", () {
    ///Convert into Model
    SaveCarBookingConfirmationDetails model = saveCarBookingConfirmationDetails;
    expect(model.status != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    SaveCarBookingConfirmationDetails mapFromModel =
        SaveCarBookingConfirmationDetails.fromMap(map);
    expect(mapFromModel.status != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car payment Model Domain", () {
    ///Convert into Model
    AddOnService model = addOnService;
    expect(model.description != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    AddOnService mapFromModel = AddOnService.fromMap(map);
    expect(mapFromModel.description != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
  test("car payment Model Domain", () {
    ///Convert into Model
    CancellationPolicy model = cancellationPolicy;
    expect(model.message != null, false);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    CancellationPolicy mapFromModel = CancellationPolicy.fromMap(map);
    expect(mapFromModel.message != null, false);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsondata = model.toJson();
    expect(jsondata.isNotEmpty, true);
  });
}
