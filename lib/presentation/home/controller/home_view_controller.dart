import 'package:expense_tracker/data/repository/transaction_repository.dart';
import 'package:expense_tracker/domain/models/transaction.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
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
