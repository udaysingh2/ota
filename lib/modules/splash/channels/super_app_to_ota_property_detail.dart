import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/ota_property_method_handler/models/ota_property_reponse_model_channel.dart';
import 'package:ota/channels/ota_property_method_handler/usecases/ota_property_channel_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToOtaProperty
    implements ChanelModuleHandler<OtaPropertyHandlerModelChannel> {
  final OtaPropertyHandlerUseCase otaPropertyHandlerUseCase =
      OtaPropertyHandlerUseCaseImpl();
  late final BuildContext context;
  Function(OtaPropertyHandlerModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "otaProperty";
  }

  @override
  Future<void> handle(
      {Function(OtaPropertyHandlerModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    otaPropertyHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(OtaPropertyHandlerModelChannel data) async {
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
    otaPropertyHandlerUseCase.dispose();
  }
}
