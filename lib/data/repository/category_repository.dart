import 'package:expense_tracker/constants/app_images.dart';
import 'package:expense_tracker/domain/models/transaction_category.dart';

class CategoryRepository {
  Future<List<TransactionCategory>> getAllCategories() async {
    return [
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
    ];
  }
}
