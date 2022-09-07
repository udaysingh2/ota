import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_car_info.dart';

import '../../../../../helper.dart';

void main() {
  testWidgets("car payment info status test", (tester) async {
    Widget widget = getMaterialWrapper(CarPaymentCarInfo(
      imageUrl: '',
      noOfSeats: 1,
      noOfDoors: 1,
      noOfLargeBag: 1,
      noOfSmallBag: 1,
      name: 'CarPaymentDetails',
      serviceProvider: 'serviceProvider',
      cancellationPolicy: 'cancellationPolicy',
      totalPrice: 0.0,
      gear: 'gear',
      returnDate: DateTime.now(),
      pickUpDate: DateTime.now(),
      onPress: () {},
    ));
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
