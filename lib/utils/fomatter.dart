import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UtilFormatter {
  static String formatNumber(double number) {
    //number = double.parse(number.toStringAsFixed(2));
    final tool = new NumberFormat("###.0#", "en_US");
    return tool.format(number).replaceAll(",", ".");
  }

  static String formatTimeStamp(Timestamp timestamp) {
    DateFormat formatter = DateFormat.yMMMMd().add_jm();
    var date =
    new DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return formatter.format(date);
  }
}