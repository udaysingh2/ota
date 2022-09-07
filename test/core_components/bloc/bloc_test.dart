import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_components/bloc/bloc.dart';

class MockBlock extends Bloc<int> {
  @override
  int initDefaultValue() {
    return 0;
  }

  void testEmit() {
    emit(1);
  }

  void testEmitWithNoState() {
    emitWithNoStateUpdate(2);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void main() {
  test('Bloc Test ...', () async {
    MockBlock mockBlock = MockBlock();
    expect(mockBlock.state, 0);
    mockBlock.testEmit();
    expect(mockBlock.state, 1);
    mockBlock.testEmitWithNoState();
    expect(mockBlock.stream.isBroadcast, true);
    expect(mockBlock.state, 1);
    mockBlock.dispose();
  });
}
