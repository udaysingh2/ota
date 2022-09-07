

import 'package:ota/channels/example_noreturn/models/example_argument_model_channel.dart';
import 'package:ota/common/network/failures.dart';

import 'example_channel_data_source.dart';

class ExampleMockDataSourceImpl implements ExampleChannelDataSource {
  ExampleMockDataSourceImpl();


  @override
  Future<SuccessResponse> invokeExampleMethod(
      {required String methodName,
      required ExampleArgumentModelChannel arguments}) async {
    return SuccessResponse.success;
  }

  @override
  void dispose() {}
}


