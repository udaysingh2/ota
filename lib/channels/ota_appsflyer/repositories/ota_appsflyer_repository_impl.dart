import 'package:ota/channels/ota_appsflyer/data_source/ota_appsflyer_data_source.dart';
import 'package:ota/channels/ota_appsflyer/model/ota_appsflyer_model_channel.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/disposer.dart';

abstract class GetAppsFlyerChannelRepository extends Disposer {
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  });
}

class GetAppsFlyerChannelRepositoryImpl
    implements GetAppsFlyerChannelRepository {
  GetAppsFlyerChannelDataSource? cognitoChannelDataSource;

  GetAppsFlyerChannelRepositoryImpl(
      {GetAppsFlyerChannelDataSource? remoteDataSource}) {
    if (remoteDataSource == null) {
      cognitoChannelDataSource = GetAppsFlyerChannelDataSourceImpl();
    } else {
      cognitoChannelDataSource = remoteDataSource;
    }
  }

  @override
  void invokeExampleMethod({
    required String methodName,
    required GetAppsFlyerModelChannel arguments,
  }) {
    try {
      cognitoChannelDataSource?.invokeExampleMethod(
          methodName: methodName, arguments: arguments);
    } on Exception catch (error) {
      printDebug(error);
    }
  }

  @override
  void dispose() {
    cognitoChannelDataSource?.dispose();
  }
}
