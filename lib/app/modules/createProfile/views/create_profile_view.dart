import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_profile_controller.dart';

class CreateProfileView extends GetView<CreateProfileController> {
  @override
  final controller = Get.put(CreateProfileController());

  CreateProfileView({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: CachedNetworkImage(
                        imageUrl: info.userProfile?.profileImage ?? '',
                        height: 360,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/assets/img.png',
                          height: 360,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/assets/img.png',
                          height: 360,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),


                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Row(
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
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: const Icon(Icons.more_vert, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.all(15),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                        children: [
                          Container(
                            width: 160,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: const Color(0xFF2C2B30)),
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
                          const SizedBox(width: 10),
                          Container(
                            width: 160,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(55, 185, 197, 1),
                              border: Border.all(color: const Color.fromRGBO(55, 185, 197, 1)),
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

                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(height: 20),
                           Text('${info.firstName ?? " "} ${info.lastName ?? ""}, ${info.age ?? ""}',
                               style:  const TextStyle(
                                   fontSize: 26, fontWeight: FontWeight.bold)),

                           const SizedBox(height: 12),
                           Text("About" ' ${info.firstName ?? " "} ${info.lastName ?? ""}',
                             style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.w600,),),

                           Text('${info.userProfile?.bio ?? ''}'),

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
                                   padding: const EdgeInsets.only(bottom: 5),
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

                           const SizedBox(height: 10),
                           Text("Social",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),),

                           SizedBox(height: 10,),
                           if (info.userProfile?.instagramUsername?.isNotEmpty == true)
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
                           if (info.userProfile?.tiktokUsername?.isNotEmpty == true)
                             Row(
                               children: [
                                 Image.asset(
                                   'assets/assets/tiktokimage.png', // use correct icon here
                                   height: 20,
                                   width: 20,
                                 ),
                                 const SizedBox(width: 8),
                                 Text('${info.userProfile?.tiktokUsername}'),
                               ],
                             ),



                           const SizedBox(height: 20),
                           const SizedBox(height: 8),
                         ],
                       ),

                     ],
                   ),
                 ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
