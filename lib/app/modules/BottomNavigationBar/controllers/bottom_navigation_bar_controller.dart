import 'package:get/get.dart';
class BottomNavigationBarController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}