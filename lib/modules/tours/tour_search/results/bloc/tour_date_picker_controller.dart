import 'package:ota/core_components/bloc/bloc.dart';

class TourDatePickerController extends Bloc<TourDatePickerViewModel> {
  @override
  TourDatePickerViewModel initDefaultValue() {
    return TourDatePickerViewModel(
        selectedDate: DateTime.now().add(const Duration(days: 1)));
  }

  void resetDate() {
    state.selectedDate = DateTime.now().add(const Duration(days: 1));
    emit(state);
  }
}

class TourDatePickerViewModel {
  DateTime selectedDate;
  TourDatePickerViewModel({
    required this.selectedDate,
  });
}
