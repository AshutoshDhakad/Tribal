import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/followers_controller.dart';

class FollowersView extends GetView<FollowersController> {
  @override
  final controller = Get.put(FollowersController());

  FollowersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(239, 239, 239, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const Text(
                    'Followers',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search Countries',
                  hintStyle: const TextStyle(
                      color: Color.fromRGBO(157, 157, 157, 1)),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                final flwList = controller.followers.value?.myFollowers ?? [];

                print('Followers count: ${flwList.length}');

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }else {
                  return ListView.builder(
                    itemCount: flwList.length,
                    itemBuilder: (context, index) {
                      final follower = flwList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16, top: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(follower.userProfile?.profileImage ?? ''),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  '${follower.firstName ?? ''} ${follower.lastName ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final id = follower.id;
                                  if (id != null) {
                                    print('Removing follower with ID: $id');
                                    controller.removeFollower(id);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),


                            ],
                          ),
                      );
                    },
                  );
                }
              }),
            ),


          ],
        ),
      ),
    );
  }
}

