import 'dart:async';

import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/channels/register_confirm_booking_handler/repositories/register_confirm_booking_repository.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class RegisterConfirmBookingUseCases extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName});
}

class RegisterConfirmBookingUseCasesImpl
    implements RegisterConfirmBookingUseCases {
  RegisterConfirmBookingRepository? registerConfirmBookingRepository;

  /// Dependence injection via constructor
  RegisterConfirmBookingUseCasesImpl(
      {RegisterConfirmBookingRepository? repository}) {
    if (repository == null) {
      registerConfirmBookingRepository = RegisterConfirmBookingRepositoryImpl();
    } else {
      registerConfirmBookingRepository = repository;
    }
  }

  @override
  void dispose() {
    registerConfirmBookingRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmBookingModelChannel) nativeResponse,
      required String methodName}) {
    return registerConfirmBookingRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
