import 'package:expense_tracker/presentation/add_transaction/binding/add_transaction_binding.dart';
import 'package:expense_tracker/presentation/add_transaction/view/add_transaction_view.dart';
import 'package:expense_tracker/presentation/home/binding/home_view_binding.dart';
import 'package:expense_tracker/presentation/home/view/home_view.dart';
import 'package:expense_tracker/presentation/transaction/binding/transaction_binding.dart';
import 'package:expense_tracker/presentation/transaction/view/transaction_view.dart';
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
    GetPage(
      name: Routes.ADD_TRANSACTION_SCREEN,
      page: () => const AddTransactionView(),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION_SCREEN,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),
  ];
}
