import 'package:flutter/widgets.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/channels/register_confirm_booking_handler/usecases/register_confirm_booking_use_cases.dart';
import 'package:ota/core_components/ota_channel/ota_channel_module.dart';
import 'package:ota/core_pack/graphql/auth_helper.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class OtaSuperAppToRegisterConfirmBooking
    implements ChanelModuleHandler<RegisterConfirmBookingModelChannel> {
  final RegisterConfirmBookingUseCases otaLandingHandlerUseCase =
      RegisterConfirmBookingUseCasesImpl();
  late final BuildContext context;
  Function(RegisterConfirmBookingModelChannel data)? onHandleSuccess;
  @override
  String getMethodName() {
    return "registerConfirmToBooking";
  }

  @override
  Future<void> handle(
      {Function(RegisterConfirmBookingModelChannel data)? onHandleSuccess,
      required BuildContext context}) async {
    this.context = context;
    this.onHandleSuccess = onHandleSuccess;
    otaLandingHandlerUseCase.handleMethodChannel(
      nativeResponse: onResponse,
      methodName: getMethodName(),
    );
  }

  @override
  Future<void> onResponse(RegisterConfirmBookingModelChannel data) async {
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
