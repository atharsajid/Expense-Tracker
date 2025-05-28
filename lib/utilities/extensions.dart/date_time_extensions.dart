import 'package:expense_tracker/constants/app_constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormatDateTime({String format = ''}) {
    return DateFormat(format.isEmpty ? AppConstants.dateFormat : format).format(this);
  }
}
