import 'dart:async';

import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';
import 'package:ota/channels/register_confirm_landing_handler/repositories/register_confirm_landing_repository_impl.dart';
import 'package:ota/common/network/disposer.dart';

/// Interface for ExampleUseCases.
abstract class RegisterConfirmLandingUseCases extends Disposer {
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmLandingModelChannel) nativeResponse,
      required String methodName});
}

class RegisterConfirmLandingUseCasesImpl
    implements RegisterConfirmLandingUseCases {
  RegisterConfirmLandingRepository? registerConfirmLandingRepository;

  /// Dependence injection via constructor
  RegisterConfirmLandingUseCasesImpl(
      {RegisterConfirmLandingRepository? repository}) {
    if (repository == null) {
      registerConfirmLandingRepository = RegisterConfirmLandingRepositoryImpl();
    } else {
      registerConfirmLandingRepository = repository;
    }
  }

  @override
  void dispose() {
    registerConfirmLandingRepository?.dispose();
  }

  @override
  StreamSubscription handleMethodChannel(
      {required Function(RegisterConfirmLandingModelChannel) nativeResponse,
      required String methodName}) {
    return registerConfirmLandingRepository!.handleMethodChannel(
        nativeResponse: nativeResponse, methodName: methodName);
  }
}
