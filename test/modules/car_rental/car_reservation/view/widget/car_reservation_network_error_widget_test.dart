import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_network_error_widget.dart';
import '../../../../../helper.dart';

void main() {
  testWidgets('Network Error Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        getMaterialWrapper(const OtaCarReservationNetworkErrorWidget()));
    await tester.pumpAndSettle();
  });
}
