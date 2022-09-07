import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_supplier/view_model/car_supplier_arguments_view_model.dart';

void main() {
  test(
    'Car Rental View Argument Tests',
    () async {
      CarSupplierArgumentViewModel carSupplierArgumentViewModel =
          CarSupplierArgumentViewModel(
        age: 2,
        brandName: "",
        carId: "",
        carName: '',
        craftType: '',
        currency: '',
        includeDriver: '',
        pickupCounter: '',
        pickupLocation: '',
      );

      expect(carSupplierArgumentViewModel.age, 2);
      expect(carSupplierArgumentViewModel.brandName, '');
      expect(carSupplierArgumentViewModel.carId, '');
      expect(carSupplierArgumentViewModel.craftType, '');
      expect(carSupplierArgumentViewModel.carName, '');
      expect(carSupplierArgumentViewModel.includeDriver, '');
      expect(carSupplierArgumentViewModel.pickupCounter, '');
    },
  );
}
