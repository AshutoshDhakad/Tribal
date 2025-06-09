import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/brandprofile_controller.dart';

class BrandprofileView extends GetView<BrandprofileController> {
  @override
  final controller = Get.put(BrandprofileController());

  BrandprofileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(239, 239, 239, 1),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final profileData = controller.profile1.value?.userProfileInfo;
          final verticals = controller.profile1.value?.verticals ?? [];

          if (profileData == null || profileData.id == null) {
            return const SizedBox.shrink();
          }
          final info = profileData;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.black,
                            size: 20,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(170, 173, 180, 0.5)
                          ),
                        ),
                      ),
                      Container(
                        width: 16,
                        child: const Icon(Icons.more_vert, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      width: 340,
                      height: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: info.userProfile?.profileImage ?? '',
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Image.asset(
                                'assets/assets/img.png',
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) =>
                              Image.asset(
                                'assets/assets/img.png',
                                fit: BoxFit.cover,
                              ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                    color: const Color(0xFF2C2B30)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/assets/addFriend.png',
                                      width: 17,
                                      height: 17,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'ADD FRIEND',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(55, 185, 197, 1),
                                border: Border.all(color: const Color.fromRGBO(
                                    55, 185, 197, 1)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/assets/message.png',
                                      width: 17,
                                      height: 17,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 3),
                                    const Text(
                                      'MESSAGE',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text('${info.brandName ?? ""}',
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold)),

                          const SizedBox(height: 12),

                          SizedBox(height: 10,),
                          if (info.userProfile?.instagramUsername?.isNotEmpty ==
                              true)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/assets/insta_logo.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('${info.userProfile?.instagramUsername}'),
                              ],
                            ),
                          const SizedBox(height: 3),
                          if (info.userProfile?.youtube?.isNotEmpty == true)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/assets/img_1.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('${info.userProfile?.youtube}'),
                              ],
                            ),
                          const SizedBox(height: 3),
                          if (info.userProfile?.twitter?.isNotEmpty == true)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/assets/twitter_logo.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('${info.userProfile?.twitter}'),
                              ],
                            ),
                          const SizedBox(height: 3),
                          if (info.userProfile?.tiktokUsername?.isNotEmpty ==
                              true)
                            Row(
                              children: [
                                Image.asset(
                                  'assets/assets/tiktokimage.png',
                                  // use correct icon here
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                Text('${info.userProfile?.tiktokUsername}'),
                              ],
                            ),
                          const SizedBox(height: 12),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Vertical",
                                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...verticals.map((vertical) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      if (vertical.image != null &&
                                          vertical.image!.isNotEmpty)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              8),
                                          child: Image.network(
                                            vertical.image!,
                                            height: 20,
                                            width: 20,
                                          ),
                                        )
                                      else
                                        Image.asset(
                                          'assets/assets/img.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      const SizedBox(width: 12),
                                      Text(
                                        vertical.verticalName ?? '',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),

                          const SizedBox(height: 1),
                          Text("About" ' ${info.brandName ?? " "} ${info
                              .lastName ?? ""}',
                            style: const TextStyle(color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,),),

                          Text(info.userProfile?.bio ?? '', style: TextStyle(color: Color.fromRGBO(138, 138, 138, 1)),),



                          const SizedBox(height: 20),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ],
                  ),


                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
