import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/data/repository/category_repository.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';
import 'package:expense_tracker/utilities/app_helper.dart';
import 'package:expense_tracker/utilities/extensions.dart/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<TransactionCategory> categoryFilterList = [];
  Rxn<TransactionCategory> selectedCategory = Rxn();

  final TextEditingController filterDateController = TextEditingController();
  DateTime? dateRange;

  List<Transaction> transactionListWhole = [];
  RxList<Transaction> transactionList = <Transaction>[].obs;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  getAllCategories() async {
    categoryFilterList = await _categoryRepository.getAllCategories();
    categoryFilterList.insert(0, TransactionCategory(id: "0", name: "All", icon: AppImages.transportIcon));
    update();
  }

  Future onDateSelect(BuildContext context) async {
    dateRange =
        await Helper.openDatePicker(context, initialDate: dateRange, minimumDate: DateTime(1970), maximumDate: DateTime(DateTime.now().year + 10));

    filterDateController.text = dateRange.toFormatDateTime();
    applyFilter();
  }

  applyFilter() {
    //Filter by date
    if (dateRange != null) {
      transactionList.value = transactionListWhole.where((element) => Helper.equals(element.date, dateRange)).toList();
    } else {
      transactionList.value = transactionListWhole;
    }

    /// Filter by category
    if (selectedCategory.value != null && selectedCategory.value?.name != "All") {
      transactionList.value = transactionList.where((element) => element.category?.id == selectedCategory.value?.id).toList();
    }
    Get.back();
    update();
  }

  clearFilter() {
    selectedCategory.value = null;
    filterDateController.clear();
    dateRange = null;
    transactionList.value = transactionListWhole;
    Get.back();
    update();
  }
}
