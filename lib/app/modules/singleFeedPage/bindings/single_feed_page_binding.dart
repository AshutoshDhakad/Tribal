import 'package:get/get.dart';

import '../controllers/single_feed_page_controller.dart';

class SingleFeedPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleFeedPageController>(
      () => SingleFeedPageController(),
    );
  }
}
