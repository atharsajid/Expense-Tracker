import 'package:expense_tracker/presentation/add_transaction/controller/add_transaction_controller.dart';
import 'package:get/get.dart';

class AddTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddTransactionController>(
      AddTransactionController(),
    );
  }
}
