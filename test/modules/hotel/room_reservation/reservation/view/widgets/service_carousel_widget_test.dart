import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/service_carousel_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

void main() {
  testWidgets('Addon service carouse widget test ...', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ServiceCarouselWidget(
            serviceList: [
              AddonsModel(
                  cost: "200",
                  imageUrl: '',
                  quantity: "",
                  isFlight: true,
                  serviceName: "serviceName 1"),
              AddonsModel(
                  cost: "250",
                  imageUrl: '',
                  quantity: "",
                  isFlight: true,
                  serviceName: "serviceName 2")
            ],
            onItemClicked: (integer) {},
          ),
        ),
      ),
    );
  });
}
