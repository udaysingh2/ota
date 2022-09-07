class StringToDate {
  static getDateFromString(String stringDate, String time) {
    DateTime? date;

    List<String> list = stringDate.split('-');
    List<String> listOfHourAndMinute = time.split(':');

    if (list.length > 1) {
      int day = int.parse(list[2].toString());
      int month = int.parse(list[1].toString());
      int year = int.parse(list[0].toString());
      int hour = int.parse(listOfHourAndMinute[0].toString());
      int minute = int.parse(listOfHourAndMinute[1].toString());
      int second = int.parse(listOfHourAndMinute[2].toString());

      date = DateTime(year, month, day, hour, minute, second);
    }

    return date ?? DateTime.now();
  }
}
