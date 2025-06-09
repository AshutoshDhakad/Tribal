import 'package:get/get.dart';

import '../controllers/home_page1_controller.dart';

class HomePage1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePage1Controller>(
      () => HomePage1Controller(),
    );
  }
}
