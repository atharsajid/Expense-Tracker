import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/utilities/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  List<Transaction> transactionListWhole = [];
  List<Transaction> transactionList = [];

  num totalSaving = 0;
  num totalIncome = 0;
  num totalExpense = 0;

  final TextEditingController monthController = TextEditingController(text: AppStrings.thisMonth);

  String selectedMonth = AppStrings.thisMonth;

  init(List<Transaction> transactions) {
    transactionListWhole = transactions;
    sortTransactionList();
    onMonthSelect();
  }

  getTransactionSummary() {
    totalSaving = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (var transaction in transactionList) {
      if (transaction.type == TransactionType.INCOME.name) {
        totalIncome += (transaction.amount ?? 0);
      } else if (transaction.type == TransactionType.EXPENSE.name) {
        totalExpense += (transaction.amount ?? 0);
      }
    }
    totalSaving = totalIncome - totalExpense;
  }

  onMonthSelect() {
    if (selectedMonth == AppStrings.lastMonth) {
      transactionList =
          transactionListWhole.where((element) => Helper.equalsMonth(element.date, DateTime(DateTime.now().year, DateTime.now().month - 1))).toList();
    } else {
      transactionList = transactionListWhole.where((element) => Helper.equalsMonth(element.date, DateTime.now())).toList();
    }
    getTransactionSummary();
    update();
  }

  sortTransactionList() {
    transactionList.sort((a, b) => (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
  }
}
