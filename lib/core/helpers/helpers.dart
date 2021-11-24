import 'package:intl/intl.dart';

class Helpers {
  static String toLocaleDateString(DateTime dt) => DateFormat(
        'EEEE d, MMMM ' 'yyyy \n' 'HH:mm',
      ).format(dt.toLocal()).toString();
}
