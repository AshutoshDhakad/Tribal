import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tribal/app/modules/explorePage/views/explore_page_view.dart';
import 'package:tribal/app/modules/homePage1/views/home_page1_view.dart';
import 'package:tribal/app/modules/notificationsPage/views/notifications_page_view.dart';
import 'package:tribal/app/modules/profilePage/views/profile_page_view.dart';
import '../controllers/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatelessWidget {
  BottomNavigationBarView({Key? key}) : super(key: key);

  final BottomNavigationBarController controller = Get.put(BottomNavigationBarController());

  final List<Widget> pages = [
     HomePage1View(),
     ExplorePageView(),
     NotificationsPageView(),
     ProfilePageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 239, 239, 1),
      body: Obx(() => pages[controller.currentIndex.value]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("FAB Pressed");
        },
        backgroundColor: const Color(0xFF37B9C5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: ClipRRect(borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
        child: BottomAppBar(
          height: 50,
          shape: const CircularNotchedRectangle(),
          color: const Color.fromRGBO(255, 255, 255, 1),
          notchMargin: 4.0,

        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildTabItem(icon: Icons.home, index: 0),
              buildTabItem(icon: Icons.explore, index: 1),
              const SizedBox(width: 40),
              buildTabItem(icon: Icons.notifications, index: 2 ),
              buildTabItem(icon: Icons.person, index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabItem({required IconData icon, required int index, }) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? const Color(0xFF37B9C5) : Colors.grey),
            ],
          ),
        ),
      );
    });
  }
}
