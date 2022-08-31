import 'package:get/get.dart';
import 'package:kettik/screens/filter/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(
      () => FilterController(),
    );
  }
}
