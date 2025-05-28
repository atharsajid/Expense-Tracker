import 'package:expense_tracker/data/repository/transaction_repository.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/presentation/transaction/view/transaction_view.dart';
import 'package:expense_tracker/utilities/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  final homeTabs = [
    Container(
      color: AppTheme.primaryColor,
    ),
    const TransactionView(),
  ];
  RxInt currentTabIndex = (0).obs;

  final TransactionRepository _transactionRepository = TransactionRepository();
  RxList<Transaction> transactionList = <Transaction>[].obs;

  @override
  void onInit() {
    getAllTransaction();
    super.onInit();
  }

  getAllTransaction() async {
    transactionList.value = (await _transactionRepository.getAllTransaction() ?? []).reversed.toList();
    update();
  }
}
