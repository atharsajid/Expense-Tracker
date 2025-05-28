import 'package:expense_tracker/data/repository/category_repository.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();

  List<TransactionCategory> categoryFilterList = [];
  Rxn<TransactionCategory> selectedCategory = Rxn();

  @override
  void onInit() {
    getAllCategories();
    super.onInit();
  }

  getAllCategories() async {
    categoryFilterList = await _categoryRepository.getAllCategories();
    update();
  }
}
