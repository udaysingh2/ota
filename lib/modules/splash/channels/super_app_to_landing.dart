import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_method_handler/usecases/ota_landing_handler_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToLanding
    implements ChanelModuleHandler<OtaLandingHandlerModelChannel> {
  final OtaLandingHandlerUseCase otaLandingHandlerUseCase =
      OtaLandingHandlerUseCaseImpl();
  late final BuildContext context;
  Function(OtaLandingHandlerModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "otaLanding";
  }

  @override
  Future<void> handle(
      {Function(OtaLandingHandlerModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    otaLandingHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(OtaLandingHandlerModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    loginModel.loginDataSetter(
      context: context,
      userId: data.userId,
      language: data.language,
      env: data.env,
      userType: data.userType,
      userName: data.userName,
    );
    AuthHelper.setAuthTokenFromChannel(data);
    if (onHandleSuccess == null) return;
    onHandleSuccess!(data);
  }

  @override
  void dispose() {
    otaLandingHandlerUseCase.dispose();
  }
}
