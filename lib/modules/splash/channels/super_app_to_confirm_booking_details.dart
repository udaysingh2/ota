import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ota/channels/booking_confirm_payment_handler/models/booking_confirm_handler_model_channel.dart';
import 'package:ota/channels/booking_confirm_payment_handler/usecases/booking_confirm_handler_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class SuperAppToConfirmBookingDetails
    implements ChanelModuleHandler<BookingConfirmHandlerModelChannel> {
  final BookingConfirmHandlerUseCase propertyDetailHandlerUseCase =
      BookingConfirmHandlerUseCaseImpl();
  late final BuildContext context;
  Function(BookingConfirmHandlerModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "bookingConfirm";
  }

  @override
  Future<void> handle(
      {Function(BookingConfirmHandlerModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    propertyDetailHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(BookingConfirmHandlerModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    loginModel.loginDataSetter(
      context: context,
      env: data.env,
      language: data.language,
      userId: loginModel.userId,
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
