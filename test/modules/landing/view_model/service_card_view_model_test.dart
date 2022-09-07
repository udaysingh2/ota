import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/landing/view_model/service_card_view_model.dart';

void main() {
  test('For class ServiceViewModel test', () {
    ServiceViewModel model = ServiceViewModel(
      title: 'title',
      description: 'description',
      imageUrl: 'imageUrl',
      service: 'service',
    );

    expect(model.title.isNotEmpty, true);
    expect(model.service, 'service');
  });

  group('For fromString(String) test ', () {
    test('For class fromString test', () {
      final actual = ServiceViewModelServiceExtension.fromString('Hotel');

      expect(actual, ServiceViewModelService.unknown);
    });

    test(
        'For class ServiceViewModelServiceExtension.inString() If Type is HOTEL test',
        () {
      final actual =
          ServiceViewModelServiceExtension(ServiceViewModelService.hotel)
              .inString();

      expect(actual, 'HOTEL');
    });

    test(
        'For class ServiceViewModelServiceExtension.inString() If Type is INSURANCE test',
        () {
      final actual =
          ServiceViewModelServiceExtension(ServiceViewModelService.insurance)
              .inString();

      expect(actual, 'INSURANCE');
    });

    test(
        'For class ServiceViewModelServiceExtension.inString() If Type is empty test',
        () {
      final actual =
          ServiceViewModelServiceExtension(ServiceViewModelService.unknown)
              .inString();

      expect(actual, '');
    });
  });
}
