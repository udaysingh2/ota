import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/usecases/get_cognito_use_cases.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';
import 'package:ota/core_pack/graphql/auth_model.dart';
import 'package:ota/core_pack/graphql/jwt_decoder.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:provider/provider.dart';

class AuthHelper {
  Future<void> addTokenInfo(Map<String, String> header,
      {bool authRequired = true}) async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return;
    }
    String? deviceId = await getDeviceIdentifier();
    if (deviceId != null) header["X-device-token"] = deviceId;

    ///Todo : Access token hardocded here
    if (!OtaChannelConfig.isModule) {
      if (getLoginProvider().getEnvType() == "alpha") {
        header["Authorization"] =
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJvcmlnaW5fanRpIjoiNDJiNThjMWMtNTgwMC00NTI3LWJkZmMtYTRjMTRkNTdlMjVlIiwic3ViIjoiNTU2MmI3ZDMtYzI3NS00ODZmLTljYjItMDc5NzgwZmE2MzYwIiwiZXZlbnRfaWQiOiI0NzMxNjYyYy05YWJmLTQ2NTgtYmZiOC02MTdkMWQzZWRlN2MiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNjQ2MjkyNjk1LCJpc3MiOiJodHRwczovL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb20vYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiZXhwIjoxNjQ2MzIxNDk1LCJpYXQiOjE2NDYyOTI2OTUsImp0aSI6IjFmNjhiZjU4LTI2OTQtNGQxNS05NGM3LWRiNDYzMDQyMGVjNCIsImNsaWVudF9pZCI6IjFnc2M2a24zZGZ1MWkwN2s3cHE0djRyY2JyIiwidXNlcm5hbWUiOiJlNTYzYTkyNC01Mzk4LTQxZWEtOTU3YS1kMjUzNmU3MmMzZjgtYWFZM21RUGcifQ.fjhDsxPMnetOtQqFVIepWN4m7phAjhn8CQT1fwLnTmM";
      } else if (getLoginProvider().getEnvType() == "staging") {
        header["Authorization"] =
            'Bearer eyJraWQiOiJDM1pDY3BqSGZsdldQNjNVTExXMldERk10QVVKZ21pQlZKS0JIRUVRNDM4PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiJiNjY4MjQwZi0wMDZhLTQxMDUtYmY2Zi0zZWIwMTFkZDIzMDEiLCJldmVudF9pZCI6Ijc4NjlmODA0LTI4ZDYtNDA5My04NTYxLTg2Nzg2MWY5ZGFjYSIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE2NjExNDY0NjAsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5hcC1zb3V0aGVhc3QtMS5hbWF6b25hd3MuY29tXC9hcC1zb3V0aGVhc3QtMV9lTjNuV2dJRFciLCJleHAiOjE2NjExNTAwNjAsImlhdCI6MTY2MTE0NjQ2MCwianRpIjoiMWU4MzAwY2EtY2Y3Ni00M2QzLWFjYjQtMmY4ZGE1YWE5MTk2IiwiY2xpZW50X2lkIjoiMWpoNWxtMm5icXBxcW91MXQ1ZTk2YzdmcnIiLCJ1c2VybmFtZSI6Ijc4MGM5ZGRiLTMzN2UtNDUxNy1iMjkwLWFkM2Y2NWQyZjQwNS1NVmR2Q3JZZyJ9.j06DFSdMi8Kj322Uk7BBv8inViHdYc1w-1G6exKZpNJjlOc8CUiqYEnVjXFxUVbV7zhIt7k8tjEdhZ36Jl12UmYKHK28rmzC4-sIOvUAX31Cbu-bMffORKhDu1xu5VsQ0KteIxd02uTGTPH2RJdrnJiddVZI8NCofE3DzGEuyb4wbNZql5XTPu35WVEo4EcAV3L7HIU0V-zEqxwAga7u5MkSTpCcUe3giRehKswip37x2UquGwXZ_DdUMvwqMaQgypAHFlSXZoQj2Clyas7SPRmPCgpzJg-zgCKrShz4zfpcZyT3Y8GMY_Uc5v3ux4jHaX7juVSsvQbgVQZ6I13mgQ';
      } else {
        header["Authorization"] =
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJvcmlnaW5fanRpIjoiZjgyYTcxNDUtYmEyYi00Nzc1LWE2NzMtNGUwZTFiNzFkNWQ0Iiwic3ViIjoiNDAzOGYzMWUtY2Y2Mi00MzAxLTg2YTEtOGY1YzU2MmI5OWRkIiwiZXZlbnRfaWQiOiJmMWU0MjUyZS04NDQ3LTQ4ZjMtOThiYi00OWQ2MjQzYTdhOWYiLCJ0b2tlbl91c2UiOiJhY2Nlc3MiLCJzY29wZSI6ImF3cy5jb2duaXRvLnNpZ25pbi51c2VyLmFkbWluIiwiYXV0aF90aW1lIjoxNjM4MjQ0OTkzLCJpc3MiOiJodHRwczovL2NvZ25pdG8taWRwLmFwLXNvdXRoZWFzdC0xLmFtYXpvbmF3cy5jb20vYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiZXhwIjoxNjM4MjczNzkzLCJpYXQiOjE2MzgyNDQ5OTMsImp0aSI6IjY0ZTFjYzczLWFlMjYtNGFhYi1hNTdlLWQxOTRiZmNhMGM4ZCIsImNsaWVudF9pZCI6IjFnc2M2a24zZGZ1MWkwN2s3cHE0djRyY2JyIiwidXNlcm5hbWUiOiIzOGRhYzA3NC0xOTY2LTQ5YmMtODEyNS00MWRiNGExZWEwYWUtdlZ2Vk5UWDAifQ.GdeIvxWE6s5oHQy0dk6ToX1O5unjuipYlQbDF10GXA8";
      }
      header["idToken"] =
          "eyJraWQiOiI4cmJ6ZnhNdGwrbHptdnU4dW5NMXdhVWZ0cVdzZjczUm4xODlITVwvT1Zzaz0iLCJhbGciOiJSUzI1NiJ9.eyJvcmlnaW5fanRpIjoiZTc2YjExMmMtZWU0Ni00NTZjLWE3YTQtNWU5NzFmYzA3MDE3Iiwic3ViIjoiNDAzOGYzMWUtY2Y2Mi00MzAxLTg2YTEtOGY1YzU2MmI5OWRkIiwiYXVkIjoiMWdzYzZrbjNkZnUxaTA3azdwcTR2NHJjYnIiLCJldmVudF9pZCI6IjJhZTRkOWU2LWJjNDMtNGI2MC04ODFmLWJhNmFmYjg1M2Q3OSIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjM4NDI2Mzk1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuYXAtc291dGhlYXN0LTEuYW1hem9uYXdzLmNvbVwvYXAtc291dGhlYXN0LTFfNHdIUXdNUDN2IiwiY29nbml0bzp1c2VybmFtZSI6ImNhMDUxYmRkLWEwZGYtNDA3NC1hMWQ4LTljYjIxYjFjNzVhZC02VFRTUHJpbiIsImV4cCI6MTYzODQ1NTE5NSwiaWF0IjoxNjM4NDI2Mzk1LCJqdGkiOiI1MDI1OTVhMC0wZjRiLTQwYTktYjRiYS00ZjM0NzJlNWFmMTYifQ.gkDIhcJj8QDPmq8JuxcTZDkG5RgABiQU4cfmGYvFMWJYbxPB2jtyt4YOqNH0YufcfTMC4q9AgPx00YoI09cW1sa_x71Sa-RPHFK097LkEw5uVPPrxB_sAjHGDFh-lBU7l8VlwwCtxdPEulLfdi9QeTTTcD6nHbH7UNS_fEE5PRHpj7NuRuOq0lSdfWP7-2uROl68kw3R5wCxIUlPmQBGBmFGFgeZpGdUagSphyQsQHKpw1-40GGEUCwKhouK4OUq4aUMuioIg5AbaYfCvpybj42QWJSQIGzwa8obhBE1HZGmUZgizZb7xcScE25ZJM6ewo5sGobdpEjcU16-B14MwQ";
      return;
    }
    if (GlobalKeys.navigatorKey.currentContext != null && authRequired) {
      LoginModel loginModel = Provider.of<LoginModel>(
          GlobalKeys.navigatorKey.currentContext!,
          listen: false);
      _updateAuthHeader(loginModel, header);
    }
  }

  static void setAuthTokenFromChannel(AuthModel model) {
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    loginModel.data =
        TokenResult(idToken: model.idToken, accessToken: model.accessToken);
  }

  void _updateAuthHeader(LoginModel loginModel, Map<String, String> header) {
    String? idToken = loginModel.data?.idToken;
    if (idToken != null) header["idToken"] = idToken;
    String? accessToken = loginModel.data?.accessToken;
    if (accessToken != null) header["Authorization"] = "Bearer $accessToken";
  }

  Future<String?> getDeviceIdentifier() async {
    String? deviceIdentifier;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor;
    }
    return deviceIdentifier;
  }

  static bool isTokenExpiredFromQueryResult(QueryResult queryResult) {
    if (queryResult.exception?.linkException == null) {
      return false;
    }
    if (queryResult.exception?.linkException is HttpLinkServerException) {
      HttpLinkServerException serverException =
          queryResult.exception?.linkException as HttpLinkServerException;
      printDebug(serverException.response.statusCode);
      if (serverException.response.statusCode == 401) {
        return true;
      }
    }
    return false;
  }

  static bool isTokenExpiredFromAccessToken(String? accessToken) {
    if (accessToken == null) return true;
    if (accessToken.trim().isEmpty) return true;
    bool isExpired;
    try {
      isExpired = JwtDecoder.isExpired(accessToken);
    } catch (ex) {
      isExpired = true;
    }

    if (isExpired) {
      return true;
    }
    return false;
  }
}

enum AuthTokenRefresherState {
  refreshing,
  refreshed,
}

class AuthTokenRefresher extends Bloc<AuthTokenRefresherState> {
  AuthTokenRefresher._initial();
  static AuthTokenRefresher shared = AuthTokenRefresher._initial();
  factory AuthTokenRefresher() {
    return shared;
  }
  Future<void> checkAndRefreshTokenFromAccessToken(String? accessToken) async {
    if (state == AuthTokenRefresherState.refreshing) {
      return;
    }
    if (AuthHelper.isTokenExpiredFromAccessToken(accessToken)) {
      emit(AuthTokenRefresherState.refreshing);
    } else {
      emit(AuthTokenRefresherState.refreshed);
      return;
    }
    await updateTokenFromChannel();
    emit(AuthTokenRefresherState.refreshed);
  }

  void checkAndRefreshTokenFromResponse(QueryResult result) async {
    if (state == AuthTokenRefresherState.refreshing) {
      return;
    }
    if (AuthHelper.isTokenExpiredFromQueryResult(result)) {
      emit(AuthTokenRefresherState.refreshing);
    } else {
      emit(AuthTokenRefresherState.refreshed);
      return;
    }
    await updateTokenFromChannel();
    emit(AuthTokenRefresherState.refreshed);
  }

  Future<void> updateTokenFromChannel() async {
    GetCognitoUseCases getCognitoUseCases = GetCognitoUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    Either<Failure, GetCognitoResponseModelChannel> either =
        await getCognitoUseCases.invokeExampleMethod(
            methodName: "getCognitoToken",
            arguments: loginModel.getCognitoArgumentModelChannel());
    if (either.isRight) {
      GetCognitoResponseModelChannel model = either.right;
      loginModel.updateFromCognitoResponse(model);
    }
  }

  @override
  AuthTokenRefresherState initDefaultValue() {
    return AuthTokenRefresherState.refreshed;
  }
}
