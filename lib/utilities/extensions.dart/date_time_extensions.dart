import 'package:expense_tracker/constants/app_constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime? {
  String toFormatDateTime({String format = ''}) {
    if (this == null) return "";
    return DateFormat(format.isEmpty ? AppConstants.dateFormat : format).format(this!);
  }

  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(
    DateTime? fromDateTime,
    DateTime? toDateTime,
  ) {
    if (fromDateTime == null || toDateTime == null) return null;
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }
}
