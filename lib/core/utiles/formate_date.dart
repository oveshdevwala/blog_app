import 'package:intl/intl.dart';

String formateDateByDMMMYYYY(String milliseconds) {
  return DateFormat('d MMM, y')
      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds)));
}
