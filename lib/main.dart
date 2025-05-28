import 'dart:async';

import 'package:expense_tracker/data/services/local_storage_service.dart';
import 'package:expense_tracker/routes/app_pages.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:expense_tracker/widgets/custom_error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageService.initLocalStorage();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (kReleaseMode) {
      setErrorBuilder();
    }
    runApp(const MyApp());
  }, (error, stack) {
    if (kDebugMode) {
      print("caught in runZonedGuarded main.dart");
      print(stack);
      print(error);
    }
  });
}

void setErrorBuilder() {
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    debugPrint("ErrorDetails ${errorDetails.exception}");
    debugPrint("ErrorDetails ${errorDetails.stack}");
    FlutterError.dumpErrorToConsole(errorDetails, forceReport: true);
    return const CustomErrorWidget();
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense-Tracker',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
