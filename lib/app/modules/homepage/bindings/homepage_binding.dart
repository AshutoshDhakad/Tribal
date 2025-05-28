import 'package:get/get.dart';
import 'package:tribal/app/modules/homepage/controllers/homepage_controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomepageController());
  }
}
