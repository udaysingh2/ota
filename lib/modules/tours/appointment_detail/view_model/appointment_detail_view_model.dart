class AppointmentDetailViewModel {
  String? location;
  String? meetingPoint;
  String? meetingPointLatitude;
  String? meetingPointLongitude;

  AppointmentDetailViewModel.mapFromData(
      {String? locationName,
      String? meetingPointValue,
      String? meetingLatitude,
      String? meetingLongitude}) {
    location = locationName;
    meetingPoint = meetingPointValue;
    meetingPointLatitude = meetingLatitude;
    meetingPointLongitude = meetingLongitude;
  }
}
