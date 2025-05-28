import 'package:expense_tracker/data/repository/category_repository.dart';
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
  DateTimeRange? dateRange;

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  getAllCategories() async {
    categoryFilterList = await _categoryRepository.getAllCategories();
    update();
  }

  Future onDateSelect(BuildContext context) async {
    DateTimeRange? pickedRange =
        await Helper.showDataRangePicker(context: context, firstDate: DateTime(1970), lastDate: DateTime(DateTime.now().year + 10));
    if (pickedRange != null && Helper.equals(pickedRange.start, pickedRange.end)) {
      filterDateController.text = pickedRange.start.toFormatDateTime();
      dateRange = pickedRange;
    } else if (pickedRange != null) {
      filterDateController.text = "${pickedRange.start.toFormatDateTime()} - "
          "${pickedRange.end.toFormatDateTime()}";
      dateRange = pickedRange;
    }
  }
}
