import 'package:expense_tracker/presentation/home/binding/home_view_binding.dart';
import 'package:expense_tracker/presentation/home/view/home_view.dart';
import 'package:get/get.dart';

part "app_routes.dart";

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME_SCREEN;
  static final routes = [
    GetPage(
      name: Routes.HOME_SCREEN,
      page: () => const HomeView(),
      binding: HomeViewBinding(),
    ),
  ];
}
