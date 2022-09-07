class CalendarUtils {
  String? covertToBhudhistDate(String date) {
    int yy = DateTime.parse(date).year;
    int dd = DateTime.parse(date).month;
    int mm = DateTime.parse(date).day;
    String thMonth = '';
    switch (mm) {
      case 1:
        {
          thMonth = 'ม.ค.';
        }
        break;
      case 2:
        {
          thMonth = 'ก.พ.';
        }
        break;
      case 3:
        {
          thMonth = 'มี.ค.';
        }
        break;
      case 4:
        {
          thMonth = 'เม.ย.';
        }
        break;
      case 5:
        {
          thMonth = 'พ.ค.';
        }
        break;
      case 6:
        {
          thMonth = 'มิ.ย.';
        }
        break;
      case 7:
        {
          thMonth = 'ก.ค.';
        }
        break;
      case 8:
        {
          thMonth = 'ส.ค.';
        }
        break;
      case 9:
        {
          thMonth = 'ก.ย.';
        }
        break;
      case 10:
        {
          thMonth = 'ต.ค.';
        }
        break;
      case 11:
        {
          thMonth = 'พ.ย.';
        }
        break;
      case 12:
        {
          thMonth = 'ธ.ค.';
        }
        break;
    }
    return (dd.toString() + " " + thMonth + " " + (yy + 543).toString());
  }
}
