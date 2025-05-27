import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/domain/enums/transaction_type.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<TransactionCategory> categoryList = [];
  TransactionCategory? selectedCategory;

  TransactionType? selectedTransactionType;

  @override
  void onInit() {
    super.onInit();
    addCategories();
  }

  addCategories() {
    categoryList.addAll([
      TransactionCategory(
        id: "1",
        name: "Food",
        icon: AppImages.foodIcon,
      ),
      TransactionCategory(
        id: "2",
        name: "Transport",
        icon: AppImages.transportIcon,
      ),
      TransactionCategory(
        id: "3",
        name: "Salary",
        icon: AppImages.cashIcon,
      ),
      TransactionCategory(
        id: "4",
        name: "Rent",
        icon: AppImages.rentIcon,
      ),
      TransactionCategory(
        id: "5",
        name: "Shopping",
        icon: AppImages.bagIcon,
      ),
    ]);
  }
}
