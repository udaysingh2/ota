import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_addon_view.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Addon Screen Test', (tester) async {
    List<ExtraChargeData>? extraChargesData = [];
    ExtraChargeGroupData extraChargeGroup =
    ExtraChargeGroupData(id: 1, name: "name", description: "description");
    CarReservationBloc carReservationBloc = CarReservationBloc();
    ExtraChargeData extraCharge = ExtraChargeData(
        id: 13,
        fromDate: DateTime.now(),
        toDate: DateTime.now(),
        extraChargeGroup: extraChargeGroup,
        price: 1000,
        isCompulsory: true,
        chargeType: 1,
        description: "description");
    extraChargesData.add(extraCharge);
    Widget widget = getMaterialWrapper(ChangeNotifierProvider(
      create: (context) {
        return CarReservationAddOnViewModel();
      },
      builder: (_, child) {
        return CarAddonView(extraChargesData, carReservationBloc);
      },
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
