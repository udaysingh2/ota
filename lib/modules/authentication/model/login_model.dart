import 'package:flutter/material.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_argument_model_channel.dart';
import 'package:ota/channels/get_cognito_token_invoke/models/get_cognito_response_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_argument_model_channel.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/ota_channel/ota_channel_config.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

import '../../../main.dart';
import '../../car_rental/car_detail/view_model/car_detail_argument_model.dart';

class LoginModel with ChangeNotifier {
  TokenResult? data;
  String userId;
  LanguageCodes language;
  Environment env;
  String userName;
  UserType userType;
  LoginModel({
    this.userId = "",
    this.language = LanguageCodes.thai,
    this.env = Environment.dev,
    this.userName = "",
    this.userType = UserType.loggedInUser,
  });

  void loginDataSetter(
      {String? userId,
      String? env,
      String? language,
      String? userName,
      String? userType,
      required BuildContext context}) {
    setLanguage(language: language, context: context);
    setUserId(userId: userId);
    setEnv(env: env);
    setUserType(userType: userType);
    setUserName(userName: userName);
  }

  void setUserType({required String? userType}) {
    if (userType == null) return;
    if (userType.isEmpty) return;
    var tempType = this.userType;
    this.userType = UserTypeExt.fromChannelData(userType: userType);
    if (tempType != UserTypeExt.fromChannelData(userType: userType)) {
      notifyListeners();
    }
  }

  String getUserType() {
    return userType.getSuperAppString().toUpperCase();
  }

  void setUserName({required String? userName}) {
    if (userName == null) {
      this.userName = getLanguage() == "EN"
          ? AppConfig().configModel.guestUsername
          : AppConfig().configModel.guestUsernameTh;
      return;
    }
    this.userName = userName;
  }

  bool isLoggedIn() {
    return userType == UserType.loggedInUser;
  }

  String getLanguage() {
    return language.code.toUpperCase();
  }

  void setUserId({required String? userId}) {
    if (userId == null) {
      this.userId = "";
      return;
    }
    this.userId = userId;
  }

  void setEnv({required String? env}) {
    if (env == null) return;
    if (env.isEmpty) return;
    this.env = EnviornmentExt.fromChannelData(env: env.toUpperCase());
  }

  String getGraphqlUrl() {
    return env.getBaseUrl();
  }

  String getEnv() {
    return env.getSuperAppString().toUpperCase();
  }

  String getEnvType() {
    return envType;
  }

  void setLanguage({required String? language, required BuildContext context}) {
    if (language == null) return;
    if (language.isEmpty) return;
    this.language = LanguageCodeExtension.fromChannelData(
      language: language.toUpperCase(),
    );
    final kThaiLocale = Locale(
      this.language.code,
      this.language.countryCode,
    );
    MyApp.setLocale(context, kThaiLocale);
  }

  GetCognitoArgumentModelChannel getCognitoArgumentModelChannel() {
    return GetCognitoArgumentModelChannel(
      accessToken: data?.accessToken ?? "",
      idToken: data?.idToken ?? "",
      userId: userId,
      env: getEnv(),
    );
  }

  GetUserLocationArgumentModelChannel getUserLocationArgumentModelChannel() {
    return GetUserLocationArgumentModelChannel(
      accessToken: data?.accessToken ?? "",
      idToken: data?.idToken ?? "",
      userId: userId,
      env: getEnv(),
      latitude: "",
      longitude: "",
      userType: getUserType(),
      language: getLanguage(),
    );
  }

  void updateFromCognitoResponse(GetCognitoResponseModelChannel response) {
    data = TokenResult(
      idToken: response.idToken,
      accessToken: response.accessToken,
    );
    userId = response.userId ?? "";
    setEnv(env: response.env);
  }
}

class TokenResult {
  String? accessToken;
  String? idToken;
  TokenResult({this.accessToken, this.idToken});
}

enum Environment { dev, alpha, prod, pt, staging, preprod }

const envType = String.fromEnvironment("ENV_TYPE", defaultValue: "dev");

const graphQlBaseUrlDev = String.fromEnvironment("GRAPHQL_BASE_URL_DEV",
    defaultValue: "https://ota-api-interface-dev.np.scbtechx.io");
const graphQlBaseUrlAlpha = String.fromEnvironment("GRAPHQL_BASE_URL_ALPHA",
    defaultValue: "https://ota-api-interface-alpha.np.scbtechx.io");
const graphQlBaseUrlProd = String.fromEnvironment("GRAPHQL_BASE_URL_PROD",
    defaultValue: "https://ota-api-interface.scbtechx.io");
const graphQlBaseUrlPt = String.fromEnvironment("GRAPHQL_BASE_URL_PT",
    defaultValue: "https://ota-api-interface-pt.np.scbtechx.io");
const graphQlBaseUrlStaging = String.fromEnvironment("GRAPHQL_BASE_URL_STAGING",
    defaultValue: "https://ota-api-interface-staging.np.scbtechx.io");
const graphQlBaseUrlPreprod = String.fromEnvironment("GRAPHQL_BASE_URL_PREPROD",
    defaultValue: "https://ota-api-interface-preprod.np.scbtechx.io");

extension EnviornmentExt on Environment {
  String getBaseUrl() {
    if (OtaChannelConfig.isModule) {
      switch (this) {
        case Environment.dev:
          return graphQlBaseUrlDev;
        case Environment.alpha:
          return graphQlBaseUrlAlpha;
        case Environment.prod:
          return graphQlBaseUrlProd;
        case Environment.pt:
          return graphQlBaseUrlPt;
        case Environment.staging:
          return graphQlBaseUrlStaging;
        case Environment.preprod:
          return graphQlBaseUrlPreprod;
      }
    } else {
      switch (fromChannelData(env: envType)) {
        case Environment.dev:
          return graphQlBaseUrlDev;
        case Environment.alpha:
          return graphQlBaseUrlAlpha;
        case Environment.prod:
          return graphQlBaseUrlProd;
        case Environment.staging:
          return graphQlBaseUrlStaging;
        case Environment.preprod:
          return graphQlBaseUrlPreprod;
        case Environment.pt:
          return graphQlBaseUrlPt;
        default:
          return graphQlBaseUrlDev;
      }
    }
  }

  String getSuperAppString() {
    switch (this) {
      case Environment.dev:
        return "dev";
      case Environment.alpha:
        return "alpha";
      case Environment.prod:
        return "prod";
      case Environment.pt:
        return "pt";
      case Environment.staging:
        return "staging";
      case Environment.preprod:
        return "preprod";
    }
  }

  static Environment fromChannelData({required String env}) {
    switch (env.toLowerCase()) {
      case "dev":
        return Environment.dev;
      case "alpha":
        return Environment.alpha;
      case "prod":
        return Environment.prod;
      case "pt":
        return Environment.pt;
      case "staging":
        return Environment.staging;
      case "preprod":
        return Environment.preprod;
      default:
        return Environment.dev;
    }
  }
}

enum UserType {
  guestUser,
  loggedInUser,
}

extension UserTypeExt on UserType {
  String getSuperAppString() {
    switch (this) {
      case UserType.guestUser:
        return "GUEST";
      case UserType.loggedInUser:
        return "ACTIVE";
    }
  }

  static UserType fromChannelData({required String userType}) {
    switch (userType.toUpperCase()) {
      case "GUEST":
        return UserType.guestUser;
      case "ACTIVE":
        return UserType.loggedInUser;
      default:
        return UserType.guestUser;
    }
  }

  HotelDetailUserType getHotelDetailType() {
    switch (this) {
      case UserType.guestUser:
        return HotelDetailUserType.guestUser;
      case UserType.loggedInUser:
        return HotelDetailUserType.loggedInUser;
    }
  }

  CarRentalDetailUserType getCarDetailType() {
    switch (this) {
      case UserType.guestUser:
        return CarRentalDetailUserType.guestUser;
      case UserType.loggedInUser:
        return CarRentalDetailUserType.loggedInUser;
    }
  }
}
