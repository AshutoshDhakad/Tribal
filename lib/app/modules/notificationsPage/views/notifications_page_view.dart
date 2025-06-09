import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_page_controller.dart';

class NotificationsPageView extends GetView<NotificationsPageController> {
  const NotificationsPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotificationsPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotificationsPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
