import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/vertical.dart';
import '../controllers/home_page1_controller.dart';

class HomePage1View extends GetView<HomePage1Controller> {

  @override
  final controller = Get.put(HomePage1Controller());

  HomePage1View({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
      appBar: AppBar(
        toolbarHeight: 20,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hi David',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-Bold'),
                  ),
                  SizedBox(width: 130,),
                  CircleAvatar(
                      child: Image.asset('assets/assets/bell_icon.png',),
                  radius: 22, backgroundColor: Color.fromRGBO(230, 220, 220, 1),),
                  Image.asset('assets/assets/men_img.png')
                ],
              ),
              Padding(
                padding:  const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Search worldwide',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(157, 157, 157, 1)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(30),
                      borderSide:  const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Obx(() {
                final verticals = controller.homeData.value.verticals ?? [];
                final verticalsWithAll = [
                  Vertical(id: 0, verticalName: "All", image: null),
                  ...verticals,
                ];

                return SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: verticalsWithAll.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final item = verticalsWithAll[index];
                      final isSelected = controller.selectedIndex.value == index;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            controller.updateIndex(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 45,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (item.verticalName == "All")
                                  Image.asset(
                                    'assets/assets/Mask group.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  )
                                else if ((item.image ?? '').isNotEmpty)
                                  CachedNetworkImage(
                                    imageUrl: item.image!,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/assets/img.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                const SizedBox(width: 5),
                                Text(
                                  item.verticalName ?? '',
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontFamily: 'Gilroy-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending Plans",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy-Bold'),
                    ),
                    SizedBox(width: 100,),
                    Text('See All', style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(55, 185, 197, 1)
                    ),),
                    Icon(Icons.arrow_forward_outlined, color: Color.fromRGBO(55, 185, 197, 1),)
                    
                  ],
                ),
              ),

              Obx(() {
                final data = controller.homeData.value.data;

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Data not found",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 241,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return Container(
                        width: 190,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: item.user?.userProfile?.profileImage ?? '',
                                    width: 170,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/assets/img.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(item.user?.firstName ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'Gilroy-SemiBold')),
                                      Text(item.user?.brandName ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontFamily: 'Gilroy-Regular')),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(item.description ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFF8A8A8A), fontFamily: 'Gilroy')),
                              const Spacer(),
                              Row(
                                children: [
                                  Obx(() => GestureDetector(
                                    onTap: () => controller.likePost(index),
                                    child: Icon(
                                      item.alreadyLiked!
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Color.fromRGBO(55, 185, 197, 1),
                                    ),
                                  )),
                                  Obx(() => Text(' ${controller.totalLikes.value}',
                                      style: const TextStyle(fontSize: 16))),
                                  const SizedBox(width: 20),
                                  Image.asset('assets/assets/text img.png', width: 18, height: 18),
                                  Text(' ${item.totalComments ?? 0}',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 20,),
              const Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Plans You Joined",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy-Bold'),
                    ),
                    SizedBox(width: 85,),
                    Text('See All', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(55, 185, 197, 1)
                    ),),
                    Icon(Icons.arrow_forward_outlined, color: Color.fromRGBO(55, 185, 197, 1),)

                  ],
                ),
              ),
              Obx(() {
                final data = controller.homeData.value.data;

                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Data not found",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 241,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final item = data[index];

                      return Container(
                        width: 190,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: item.user?.userProfile?.profileImage ?? '',
                                    width: 170,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'assets/assets/img.png',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(item.user?.firstName ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              fontFamily: 'Gilroy-SemiBold')),
                                      Text(item.user?.brandName ?? '',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontFamily: 'Gilroy-Regular')),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(item.description ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: Color(0xFF8A8A8A), fontFamily: 'Gilroy')),
                              const Spacer(),
                              Row(
                                children: [
                                  Obx(() => GestureDetector(
                                    onTap: () => controller.likePost(index),
                                    child: Icon(
                                      item.alreadyLiked!
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Color.fromRGBO(55, 185, 197, 1),
                                    ),
                                  )),
                                  Obx(() => Text(' ${controller.totalLikes.value}',
                                      style: const TextStyle(fontSize: 16))),
                                  const SizedBox(width: 20),
                                  Image.asset('assets/assets/text img.png', width: 18, height: 18),
                                  Text(' ${item.totalComments ?? 0}',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

            ]
          ),
        ),
      ));
  }
}
