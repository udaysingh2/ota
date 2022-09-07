import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';
import 'package:ota/channels/hotel_detail_method_handler/usecases/hotel_detail_channel_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToPropertyDetail
    implements ChanelModuleHandler<PropertyDetailHandlerModelChannel> {
  final PropertyDetailHandlerUseCase propertyDetailHandlerUseCase =
      PropertyDetailHandlerUseCaseImpl();
  late final BuildContext context;
  Function(PropertyDetailHandlerModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "hotelProperty";
  }

  @override
  Future<void> handle(
      {Function(PropertyDetailHandlerModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    propertyDetailHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(PropertyDetailHandlerModelChannel data) async {
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
