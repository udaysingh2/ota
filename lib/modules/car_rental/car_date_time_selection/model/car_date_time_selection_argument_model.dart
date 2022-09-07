import 'package:ota/core/app_config.dart';

class CarDateTimePickerArgumentModel {
  final DateTime pickUpDate;
  final DateTime dropOffDate;

  CarDateTimePickerArgumentModel({
    required this.pickUpDate,
    required this.dropOffDate,
  });

  factory CarDateTimePickerArgumentModel.from(
      DateTime? pickUpDate, DateTime? dropOffDate) {
    return CarDateTimePickerArgumentModel(
      pickUpDate: pickUpDate ??
          DateTime.now()
              .add(Duration(days: AppConfig().configModel.pickUpDeltaCar)),
      dropOffDate: dropOffDate ??
          DateTime.now()
              .add(Duration(days: AppConfig().configModel.dropOffDeltaCar)),
    );
  }
}
