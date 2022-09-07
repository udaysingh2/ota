import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/register_confirm_landing_handler/models/register_confirm_landing_response_model_channel.dart';
import 'package:ota/channels/register_confirm_landing_handler/usecases/register_confirm_landing_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToRegisterConfirmLanding
    implements ChanelModuleHandler<RegisterConfirmLandingModelChannel> {
  final RegisterConfirmLandingUseCases otaLandingHandlerUseCase =
      RegisterConfirmLandingUseCasesImpl();
  late final BuildContext context;
  Function(RegisterConfirmLandingModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "registerConfirmToLanding";
  }

  @override
  Future<void> handle(
      {Function(RegisterConfirmLandingModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    otaLandingHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(RegisterConfirmLandingModelChannel data) async {
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
