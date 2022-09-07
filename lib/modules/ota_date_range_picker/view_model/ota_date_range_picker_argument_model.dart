import 'package:ota/core/app_config.dart';

class OtaDateRangePickerArgumentModel {
  final DateTime checkInDate;
  final DateTime checkOutDate;

  OtaDateRangePickerArgumentModel({
    required this.checkInDate,
    required this.checkOutDate,
  });

  factory OtaDateRangePickerArgumentModel.from(
      DateTime? checkinDate, DateTime? checkoutDate) {
    return OtaDateRangePickerArgumentModel(
      checkInDate: checkinDate ??
          DateTime.now()
              .add(Duration(days: AppConfig().configModel.checkInDeltaHotel)),
      checkOutDate: checkoutDate ??
          DateTime.now()
              .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel)),
    );
  }
}
