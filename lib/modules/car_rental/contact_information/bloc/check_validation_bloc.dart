import 'package:ota/core_components/bloc/bloc.dart';

class CheckValidationBloc extends Bloc<CheckValidationBlocReload> {
  @override
  CheckValidationBlocReload initDefaultValue() {
    return CheckValidationBlocReload.reload;
  }

  void reload() {
    emit(CheckValidationBlocReload.reload);
  }
}

enum CheckValidationBlocReload {
  reload,
}
