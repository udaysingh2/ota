import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/usecases/ota_ereceipt_handler_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToERecipt
    implements ChanelModuleHandler<OtaEReceiptHandlerModelChannel> {
  final OtaEReceiptHandlerUseCase propertyDetailHandlerUseCase =
      OtaEReceiptHandlerUseCaseImpl();
  late final BuildContext context;
  Function(OtaEReceiptHandlerModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "eReceipt";
  }

  @override
  Future<void> handle(
      {Function(OtaEReceiptHandlerModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    propertyDetailHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(OtaEReceiptHandlerModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    loginModel.loginDataSetter(
      context: context,
      userId: data.userId,
      language: data.language,
      env: data.env,
      userType: data.userType,
    );
    AuthHelper.setAuthTokenFromChannel(data);
    if (onHandleSuccess == null) return;
    onHandleSuccess!(data);
  }

  @override
  void dispose() {
    propertyDetailHandlerUseCase.dispose();
  }
}
