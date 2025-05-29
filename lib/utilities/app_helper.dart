import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/widgets/custom_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Helper {
  static final FToast flutterToast = FToast();

  static Future<DateTime?> openDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) async {
    return await showDatePicker(
      context: context,
      firstDate: minimumDate ?? DateTime(1970),
      lastDate: maximumDate ?? DateTime(2030),
      initialDate: initialDate,
    );
  }

  static showSuccessSnackBar({
    String? heading,
    required String message,
    int durationMilliSec = 2000,
    Color bgColor = AppTheme.lightColor,
    Color textColor = AppTheme.darkGreyColor,
    Color titleColor = AppTheme.grey900,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    if (Get.overlayContext != null) {
      flutterToast.init(Get.overlayContext!);
      flutterToast.removeCustomToast();
      flutterToast.showToast(
        gravity: gravity,
        toastDuration: Duration(milliseconds: durationMilliSec),
        child: CustomToastMessageWidget(
          message: message,
          heading: heading,
          bgColor: bgColor,
          textColor: textColor,
          titleColor: titleColor,
          onCancelPressed: () => flutterToast.removeCustomToast(),
        ),
        positionedToastBuilder: (context, child, gravity) {
          return Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            left: 0,
            right: 0,
            child: child,
          );
        },
      );
    }
  }

  static showErrorSnackBar({
    String? heading,
    required String message,
    bool closeDialog = false,
    int durationMilliSec = 2000,
    Color bgColor = AppTheme.lightColor,
    Color textColor = AppTheme.darkGreyColor,
    Color titleColor = AppTheme.grey900,
    ToastGravity gravity = ToastGravity.TOP,
  }) {
    if (Get.context == null) return;
    if (Get.isDialogOpen == true && closeDialog) Get.back();
    if (Get.overlayContext != null) {
      flutterToast.init(Get.overlayContext!);
      flutterToast.removeCustomToast();
      flutterToast.showToast(
        gravity: ToastGravity.TOP,
        toastDuration: Duration(milliseconds: durationMilliSec),
        child: CustomToastMessageWidget(
          message: message,
          heading: heading,
          bgColor: bgColor,
          textColor: textColor,
          titleColor: titleColor,
          onCancelPressed: () => flutterToast.removeCustomToast(),
          isError: true,
        ),
        positionedToastBuilder: (context, child, gravity) {
          return Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            left: 0,
            right: 0,
            child: child,
          );
        },
      );
    }
  }

  static Color getCategoryColor(String? category) {
    switch (category) {
      case 'Food':
        return AppTheme.primaryColor;
      case 'Transport':
        return AppTheme.secondaryColor;
      case 'Salary':
        return AppTheme.darkSuccessColor;
      case 'Rent':
        return AppTheme.greyColor;
      case 'Shopping':
        return AppTheme.accentColor;
      default:
        return AppTheme.darkColor;
    }
  }

  static Future<DateTimeRange?> showDataRangePicker({
    required BuildContext context,
    DateTimeRange? initialDateRange,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    return await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: firstDate,
      lastDate: lastDate,
      saveText: "Confirm",
      helpText: "Select range or single day",
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (BuildContext context, Widget? child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(vertical: 90.0, horizontal: 12.0),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Theme(
              data: ThemeData(
                primaryColor: AppTheme.primaryColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppTheme.primaryColor,
                  primary: AppTheme.primaryColor,
                  secondary: AppTheme.secondaryColor,
                  surface: AppTheme.baseColor,
                  error: AppTheme.error500Color,
                ),
                datePickerTheme: DatePickerThemeData(
                  backgroundColor: Colors.white,
                  rangePickerBackgroundColor: Colors.white,
                  rangePickerHeaderBackgroundColor: Colors.white,
                  rangePickerShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  dividerColor: Colors.black,
                ),
              ),
              child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  removeTop: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: child!,
                  )),
            ),
          ),
        );
      },
    );
  }

  /// Check if two dates are equal
  static bool equals(DateTime? date1, DateTime? date2) {
    return date1?.day == date2?.day && date1?.month == date2?.month && date1?.year == date2?.year;
  }

  /// Check if month of two dates are equal
  static bool equalsMonth(DateTime? date1, DateTime? date2) {
    return date1?.month == date2?.month && date1?.year == date2?.year;
  }
}
