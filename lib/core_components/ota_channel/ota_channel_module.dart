import 'package:flutter/widgets.dart';
import 'package:ota/common/network/disposer.dart';

abstract class ChanelModuleHandler<T> extends Disposer {
  Future<void> handle({
    Function(T data)? onHandleSuccess,
    required BuildContext context,
  });
  Future<void> onResponse(T data);
  String getMethodName();
}
