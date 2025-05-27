import 'package:expense_tracker/presentation/home/controller/home_view_controller.dart';
import 'package:get/get.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeViewController>(
      HomeViewController(),
    );
  }
}
