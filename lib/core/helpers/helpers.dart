import 'package:intl/intl.dart';

class Helpers {
  static String toLocaleDateString(DateTime dt) => DateFormat(
        'EEE, MMM d, ' 'yy ' 'HH:MM',
      ).format(dt.toLocal()).toString();
}
