import 'package:expense_tracker/constants/app_constants.dart';
import 'package:expense_tracker/constants/app_strings.dart';
import 'package:expense_tracker/data/repository/category_repository.dart';
import 'package:expense_tracker/data/repository/transaction_repository.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';
import 'package:expense_tracker/utilities/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTransactionController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TransactionRepository _transactionRepository = TransactionRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<TransactionCategory> categoryList = [];
  TransactionCategory? selectedCategory;

  TransactionType? selectedTransactionType;

  DateTime? selectedDate;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future onDateSelect(BuildContext context) async {
    selectedDate = await Helper.openDatePicker(
      context,
      initialDate: selectedDate,
    );
    if (selectedDate != null) {
      dateController.text = DateFormat(AppConstants.dateFormat).format(selectedDate!);
      update(['date']);
    }
  }

  void onAddTransaction() async {
    try {
      Map<String, dynamic> data = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "date": selectedDate?.toIso8601String(),
        "category": selectedCategory?.toJson(),
        "type": selectedTransactionType?.name,
        "amount": num.tryParse(amountController.text),
        "description": descriptionController.text
      };
      final bool result = await _transactionRepository.addTransaction(data);
      if (result) {
        Get.back(result: Transaction.fromJson(data));
        Helper.showSuccessSnackBar(message: AppStrings.transactionAddedSuccessfullyMsg);
      } else {
        Helper.showErrorSnackBar(message: AppStrings.someThingWentWrongMsg);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getAllCategories() async {
    categoryList = await _categoryRepository.getAllCategories();
    update();
  }
}
