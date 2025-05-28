import 'package:expense_tracker/presentation/transaction/controller/transaction_controller.dart';
import 'package:get/get.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TransactionController>(
      TransactionController(),
    );
  }
}
