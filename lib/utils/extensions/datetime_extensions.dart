import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get toDMY {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String get toHM {
    return DateFormat('HH:mm').format(this);
  }
}
