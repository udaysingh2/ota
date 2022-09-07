import 'dart:async';

import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';
import 'package:ota/channels/booking_confirm_payment_handler/repositories/booking_confirm_handler_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class BookingConfirmHandlerUseCase extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName});
}

class BookingConfirmHandlerUseCaseImpl implements BookingConfirmHandlerUseCase {
  BookingConfirmHandlerRepository? otaRepository;

  /// Dependence injection via constructor
  BookingConfirmHandlerUseCaseImpl(
      {BookingConfirmHandlerRepository? repository}) {
    if (repository == null) {
      otaRepository = BookingConfirmHandlerRepositoryImpl();
    } else {
      otaRepository = repository;
    }
  }

  @override
  void dispose() {
    otaRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(BookingConfirmHandlerModelChannel) nativeResponse,
      required String methodName}) {
    return otaRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
