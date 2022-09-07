import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/channels/ota_payment_handler/usecases/ota_payment_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';

class SuperAppToOtaPayment
    implements ChanelModuleHandler<OtaPaymentModelChannel> {
  final OtaPaymentUseCases propertyDetailHandlerUseCase =
      OtaPaymentUseCasesImpl();
  late final BuildContext context;
  Function(OtaPaymentModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "otaPayment";
  }

  @override
  Future<void> handle(
      {Function(OtaPaymentModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    propertyDetailHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(OtaPaymentModelChannel data) async {
    AuthHelper.setAuthTokenFromChannel(data);
    if (onHandleSuccess == null) return;
    onHandleSuccess!(data);
  }

  @override
  void dispose() {
    propertyDetailHandlerUseCase.dispose();
  }
}
