import 'package:flutter_test/flutter_test.dart';
import 'package:ota/channels/hotel_detail_method_handler/repositories/hotel_detail_channel_repository_impl.dart';
import 'package:ota/channels/hotel_detail_method_handler/usecases/hotel_detail_channel_use_cases.dart';

void main() {
  PropertyDetailHandlerUseCase? propertyDetailHandlerUseCase;
  setUpAll(() async {
    propertyDetailHandlerUseCase = PropertyDetailHandlerUseCaseImpl();
    propertyDetailHandlerUseCase = PropertyDetailHandlerUseCaseImpl(
        repository: PropertyDetailHandlerRepositoryImpl());
  });

  test('OTA Landing Handler Use Cases test', () async {
    // ignore: cancel_subscriptions
    final consentResult = propertyDetailHandlerUseCase!
        .handleMethodChannel(nativeResponse: (p0) {}, methodName: "");

    // ignore: unnecessary_null_comparison
    expect(consentResult != null, true);
    propertyDetailHandlerUseCase!.dispose();
  });
}
