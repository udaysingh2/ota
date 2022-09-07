import 'package:ota/domain/splash/data_sources/splash_remote_data_source.dart';
import 'package:ota/domain/splash/models/splash_model.dart';

class SplashMockDataSourceImpl implements SplashRemoteDataSource {
  SplashMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<SplashModel> getSplashData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return SplashModel.fromJson(_responseMock);
  }
}

var _responseMock = """
{
    "getSplashScreen": {
      "status": {
        "code": "1000",
        "header": "Success"
      },
      "data": {
        "splashScreenUrl": "https://trbhmanage.travflex.com/ImageData/Hotel/shangri_la_bangkok-general1.jpg"
      }
    }
}
""";
