import 'package:get/get.dart';

import '../controllers/brandprofile_controller.dart';

class BrandprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandprofileController>(
      () => BrandprofileController(),
    );
  }
}
