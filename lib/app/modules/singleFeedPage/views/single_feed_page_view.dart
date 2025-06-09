import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tribal/app/modules/createProfile/views/create_profile_view.dart';

import '../controllers/single_feed_page_controller.dart';

class SingleFeedPageView extends GetView<SingleFeedPageController> {
  SingleFeedPageView({super.key});

  final feedcontroller = Get.put(SingleFeedPageController());

  String formatDateToMonthDay(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('MMM dd').format(dateTime);
    } catch (e) {
      return '';
    }
  }
  String formatToRelativeDay(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 17, right: 17),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 4),

                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/assets/nextarrow (1).png',
                      color: Colors.white,
                      scale: 0.8,// Icon color
                    ),
                  ),
                ),
                hintText: '  Post a reply',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(157, 157, 157, 1),
                  fontFamily: 'Gilroy-SemiBold',
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width:1,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left:15, right: 15, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                    onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    const Text(
                      'Feed',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy-Bold',
                      ),
                    ),
                    const Icon(Icons.flag_sharp, color: Color.fromRGBO(55, 185, 197, 1)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Obx(() {
                if (feedcontroller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final postInfo = feedcontroller.feedData.value.postInfo;
                final post1 = feedcontroller.feedData.value.comments;
                final post = postInfo;

                if (post == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Data not found",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: 'Gilroy-SemiBold',
                        ),
                      ),
                    ),
                  );
                }

                final item = post;
                final item1 = (post1 != null && post1.isNotEmpty) ? post1[0] : null;
                final userType = item.user?.userType ?? 'Unknown';
                final user = postInfo?.user;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        child: GestureDetector(
                          onTap: () async {
                            Get.to(() => CreateProfileView(), arguments: item.user?.id.toString(),);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      item?.user?.userProfile?.profileImage ?? '',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const SizedBox(
                                    width: 30,
                                    height: 30,
                                    child:
                                        CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/assets/img.png',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${postInfo?.user?.firstName ?? ''} ${postInfo?.user?.lastName ?? ''}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF2B2B30),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Gilroy-SemiBold',
                                      )),
                                ],
                              ),
                              const Spacer(),
                              Image.asset(
                                'assets/assets/backsign(1).png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postInfo?.title ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2B2B30),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Gilroy-SemiBold',
                              )),
                          const SizedBox(height: 4),
                          Text(postInfo?.description ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8A8A8A),
                                fontFamily: 'Gilroy-regular',
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            postInfo?.createdAt != null
                                ? formatDateToMonthDay(
                                    item.createdAt!.toString())
                                : '',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(44, 43, 48, 1),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0),
                      child: Row(
                        children: [
                          Image.asset('assets/assets/heart-fill.png',
                          width: 18, height: 18),
                      Text(' ${postInfo?.alreadyLiked ?? 0}',
                          style: const TextStyle(fontSize: 16)),

                          // Obx(() => GestureDetector(
                          //       onTap: () {
                          //         controller.likePost(0); // index is 0 now
                          //       },
                          //       child: Icon(
                          //         item.alreadyLiked.value
                          //             ? Icons.favorite
                          //             : Icons.favorite_border,
                          //         color: const Color.fromRGBO(55, 185, 197, 1),
                          //       ),
                          //     )),
                          // Obx(() => Text(' ${controller.totalLikes.value}',
                          //     style: const TextStyle(fontSize: 16))),
                          const SizedBox(width: 20),
                          Image.asset('assets/assets/text img.png',
                              width: 18, height: 18),
                          Text(' ${postInfo?.alreadyLiked ?? 0}',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color.fromRGBO(138, 138, 138, 0.3),
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        child: const Text('Comments',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: (item1?.comment?.isNotEmpty ?? false)
                                  ? CachedNetworkImage(
                                imageUrl: item1?.user?.userProfile?.profileImage ?? '',
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
                                  : const SizedBox.shrink(),

                            ),
                            const SizedBox(width: 10),
                            Text('${item1?.user?.firstName ?? ''} ${item1?.user?.lastName ?? ''}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2B2B30),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Gilroy-SemiBold',
                                )),
                            const SizedBox(width: 4,),
                            Text(
                              post1!.isNotEmpty ? (post1[0].comment ?? '') : '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(138, 138, 138, 1),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Gilroy-SemiBold',
                              ),
                            ),
                            const Spacer(),
                             item1?.alreadyLiked != null
                                ? const Icon(
                              Icons.favorite_border,
                              color: Colors.black,
                            )
                                : const SizedBox.shrink(),

                            // Text(' ${item.alreadyLiked ?? 0}',
                            //     style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text(
                                item1?.createdAt != null
                                    ? formatToRelativeDay(
                                        item.createdAt!.toString())
                                    : '',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.1,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(40, 20),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: item1?.commentReplies != null
                                      ? const Text(
                                    "Reply",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromRGBO(55, 185, 197, 1),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Gilroy-SemiBold',
                                    ),
                                  )
                                      : const SizedBox.shrink(),
                                ),

                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                );
              })
            ]),
          )),
    );
  }
}
