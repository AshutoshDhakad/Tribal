import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tribal/app/modules/homepage/controllers/homepage_controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final controller = Get.put(HomepageController());
  var selectedIndex = 0.obs;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              toolbarHeight: 20,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Text(
                        'Feed',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy-Bold'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: 'Search Countries',
                          hintStyle: const TextStyle(color: Color.fromRGBO(157, 157, 157, 1)),
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

                    const SizedBox(height: 10),
                    Obx(() {
                      final selectedIndex = controller.selectedIndex.value;

                      return SizedBox(
                        height: 40,
                        child: Obx(() => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.homeData.value.verticals?.length ?? 0,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, index) {
                            final item = controller.homeData.value.verticals?[index];
                            final isSelected = controller.selectedIndex.value == index;

                            if (item == null) return const SizedBox.shrink();

                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectedIndex.value = index;
                                  controller.fetchPostsByIndex(index); // must update `homeData.value.data`
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
                                      Image.network(item.image ?? '', width: 30, height: 30),
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
                        ))

                      );
                    }),


                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Most Relevant",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy-Bold'),
                          ),
                          Image.asset(
                            'assets/assets/notification 1.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                    ),

                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.homeData.value.data?.length ?? 0,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final item = controller.homeData.value.data?[index];
                        if (item == null) return const SizedBox.shrink();

                        return Column(
                          children: [
                            const Divider(thickness: 1, color: Color(0xFF2C2B29), indent: 10, endIndent: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Image.network(item.user?.userProfile?.profileImage ?? '', width: 40, height: 40),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.user?.firstName ?? '', style: const TextStyle(color: Color(0xFF2B2B30), fontSize: 14, fontFamily: 'Gilroy-SemiBold')),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(item.createdAt != null ? item.createdAt!.toString() : '', style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title ?? '', style: const TextStyle(fontSize: 16, color: Color(0xFF2B2B30), fontWeight: FontWeight.bold, fontFamily: 'Gilroy-SemiBold')),
                                  const SizedBox(height: 4),
                                  Text(item.description ?? '', style: const TextStyle(fontSize: 14, color: Color(0xFF8A8A8A), fontFamily: 'Gilroy')),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/assets/heart-fill.png', width: 18, height: 18),
                                  Text(' ${item.totalLikes ?? 0}', style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 20),
                                  Image.asset('assets/assets/text img.png', width: 18, height: 18),
                                  Text(' ${item.totalComments ?? 0}', style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 78),
                                  Container(
                                    width: 140,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(color: const Color(0xFF2C2B30)),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Center(
                                      child: Text('COMMENT', style: TextStyle(fontSize: 14, color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ))

                  ]
                )
                ),
              ),
            ));
  }
}
