import 'dart:async';

abstract class Bloc<T> {
  late T _t;
  final _streamController = StreamController<T>.broadcast();
  Stream<T> get stream => _streamController.stream;
  T get state => _t;
  Bloc() {
    _t = initDefaultValue();
    _streamController.sink.add(_t);
  }
  T initDefaultValue();
  void emit(T data) {
    if (!_streamController.isClosed) {
      _t = data;
      _streamController.sink.add(data);
    }
  }

  void dispose() {
    _streamController.close();
  }

  void emitWithNoStateUpdate(T data) {
    _streamController.sink.add(data);
  }
}
