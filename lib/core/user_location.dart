import 'package:either_dart/either.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/usecases/get_user_location_use_cases.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class UserLocation {
  String latitude = "0.0";
  String longitude = "0.0";
  UserLocation._userLocation();
  static final UserLocation _instance = UserLocation._userLocation();
  static UserLocation get shared => _instance;
  factory UserLocation() {
    return _instance;
  }

  Future<void> getUserLocationFromChannel() async {
    GetUserLocationUseCases getUserLocationUseCases =
        GetUserLocationUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    Either<Failure, GetUserLocationResponseModelChannel> either =
        await getUserLocationUseCases.invokeExampleMethod(
            methodName: "otaUserLocation",
            arguments: loginModel.getUserLocationArgumentModelChannel());
    if (either.isRight) {
      GetUserLocationResponseModelChannel model = either.right;
      if (model.longitude != null) longitude = model.longitude!;
      if (model.latitude != null) latitude = model.latitude!;
    }
  }
}
