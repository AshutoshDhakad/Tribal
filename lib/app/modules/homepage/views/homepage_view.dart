import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tribal/app/modules/brandprofile/views/brandprofile_view.dart';
import 'package:tribal/app/modules/createProfile/views/create_profile_view.dart';
import 'package:tribal/app/modules/editProfile/views/edit_profile_view.dart';
import 'package:tribal/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:tribal/app/modules/singleFeedPage/views/single_feed_page_view.dart';
import '../../model/vertical.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final controller = Get.put(HomepageController());
  ScrollController scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        controller.fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  String formatDateToMonthDay(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('MMM dd').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
          backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
            body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Feed',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy-Bold',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Your action here, for example:
                            Get.to(() => EditProfileView(), arguments: '281');
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.black,
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
                  const SizedBox(height: 20),

                  //All buttton
                  Obx(() {
                    final verticals = controller.homeData.value.verticals ?? [];
                    final verticalsWithAll = [
                      Vertical(id: 0, verticalName: "All", image: null),
                      ...verticals,
                    ];

                    return SizedBox(
                      height: screenHeight * 0.06,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: verticalsWithAll.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (context, index) {
                          final item = verticalsWithAll[index];
                          final isSelected =
                              controller.selectedIndex.value == index;

                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                controller.updateIndex(
                                    index);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
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
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
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

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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

                    return Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: data.length + (controller.hasMore.value ? 1 : 0),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemBuilder: (context, index) {

                          if (index == data.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final item = data[index];
                          final userType = item.user?.userType ?? 'Unknown';

                          return GestureDetector(
                              onTap: () async {
                                Get.to(() => SingleFeedPageView(),arguments: item.id.toString());
                              },
                         child: Container(
                           color: const Color.fromRGBO(239, 239, 239, 1),
                           child: Column(
                               children: [
                                 const Divider(
                                   thickness: 1,
                                   color: Color.fromRGBO(138, 138, 138, 0.3),
                                   indent: 10,
                                   endIndent: 10,
                                 ),
                                 Padding(
                                   padding:
                                       const EdgeInsets.symmetric(horizontal: 10),

                                   child: GestureDetector(
                                       onTap: () async {
                                         Get.to(() =>  BrandprofileView(),);
                                       },
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         GestureDetector(
                                           onTap: () {
                                             print("Tapped on user with type: $userType");

                                             if (userType == "creator") {
                                               print("Navigating to CreateProfileView");
                                               Get.to(() => CreateProfileView(), arguments: item.user?.id.toString());
                                             } else if (userType == "brand") {
                                               print("Navigating to BrandProfileView");
                                               Get.to(() =>  BrandprofileView(), arguments: item.user?.id.toString());
                                             } else {
                                               print("Unknown user type: $userType");
                                             }
                                           },
                                           child: ClipOval(
                                             child: (item.user?.userProfile?.profileImage != null &&
                                                 item.user!.userProfile!.profileImage!.isNotEmpty)
                                                 ? CachedNetworkImage(
                                               imageUrl: item.user!.userProfile!.profileImage!,
                                               width: 40,
                                               height: 40,
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
                                             )
                                                 : Image.asset(
                                               'assets/assets/img.png',
                                               width: 40,
                                               height: 40,
                                               fit: BoxFit.cover,
                                             ),
                                           ),
                                         ),


                                         const SizedBox(width: 10),
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             Text(
                                               userType == "creator"
                                                   ? '${item.user?.firstName ?? ''} ${item.user?.lastName ?? ''}'
                                                   : '${item.user?.brandName}',
                                               style: const TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 color: Color.fromRGBO(43, 44, 41, 1),
                                                 fontSize: 14,
                                                 fontFamily: 'Gilroy-SemiBold',
                                               ),
                                             ),
                                           ],
                                         ),
                                         const Spacer(),
                                         Text(
                                           item.createdAt != null
                                               ? formatDateToMonthDay(
                                                   item.createdAt!.toString())
                                               : '',
                                           style: const TextStyle(
                                             fontSize: 13,
                                             color: Colors.black,
                                             fontWeight: FontWeight.w400,
                                             letterSpacing: 0.1,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                                     const SizedBox(height: 20),
                                 Align(
                                   alignment: Alignment.centerLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 10.0),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(item.title ?? '',
                                             style: const TextStyle(
                                               fontSize: 16,
                                               color: Color(0xFF2B2B30),
                                               fontWeight: FontWeight.bold,
                                                 fontFamily: 'Gilroy-SemiBold',
                                             )),
                                         const SizedBox(height: 4),
                                         Text(item.description ?? '',
                                             style: const TextStyle(
                                               fontSize: 14,
                                               color: Color(0xFF8A8A8A),
                                               fontFamily: 'Gilroy',
                                             )),
                                       ],
                                     ),
                                   ),
                                 ),
                                 const SizedBox(height: 20),
                                 Padding(
                                   padding:
                                       const EdgeInsets.symmetric(horizontal: 5.0),
                                   child: Row(
                                     children: [
                                        GestureDetector(
                                             onTap: () {
                                               controller.likePost(index);
                                             },
                                             child: Icon(
                                               item.alreadyLiked!
                                                   ? Icons.favorite
                                                   : Icons.favorite_border,
                                               color: const Color.fromRGBO(
                                                   55, 185, 197, 1),
                                             ),
                                           ),
                                       Obx(() => Text(
                                           ' ${controller.totalLikes.value}',
                                           style: const TextStyle(fontSize: 16))),
                                       const SizedBox(width: 20),
                                       Image.asset('assets/assets/text img.png',
                                           width: 18, height: 18),
                                       Text(' ${item.totalComments ?? 0}',
                                           style: const TextStyle(fontSize: 16)),
                                       const SizedBox(width: 78),
                                       Container(
                                         width: 145,
                                         height: 45,
                                         decoration: BoxDecoration(
                                           color: Colors.black,
                                           border: Border.all(
                                               color: const Color(0xFF2C2B30)),
                                           borderRadius: BorderRadius.circular(30),
                                         ),
                                         child: Container(
                                           child: const Center(
                                             child: Text('COMMENT',
                                                 style: TextStyle(
                                                   fontSize: 14,
                                                   color: Colors.white,
                                                   fontWeight: FontWeight.w600,
                                                 )),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                                 const SizedBox(height: 10),
                                 ],
                           ),
                         ));
                        },
                      ),
                    );
                  }),
                ])),
          ),
        ));
  }
}
