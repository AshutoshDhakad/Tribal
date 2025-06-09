import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/post.dart';

class SingleFeedPageController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    String postId = Get.arguments;
    fetchPostById(postId);
  }

  var isLoading = false.obs;
  var feedData = Post().obs;
  var totalLikes = 0.obs;
  void likePost(int index) {
    final postInfo = feedData.value.postInfo;
    if (postInfo == null) return;
    final isLiked = postInfo.alreadyLiked == 1;
    postInfo.alreadyLiked = isLiked ? 0 : 1;
    postInfo.totalLikes = (postInfo.totalLikes ?? 0) + (isLiked ? -1 : 1);
    totalLikes.value = postInfo.totalLikes ?? 0;

  }
  final String token = '1554|OReTepM6iSUTUCG1YBmDpKRkmQcT53fm0ORBOJvE35f37fa6';

  Future<void> fetchPostById(String postId) async {
    const url = 'https://tribaldash.urlsdemo.net/api/post-info';

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      "post_id": postId,
    });

    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
      }
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final parsed = Post.fromJson(json.decode(response.body));
        feedData.value = parsed;
      } else {
        Get.snackbar("Error", "Failed to fetch post data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
  void updatePostData(Post newPost) {
    feedData.value = newPost;
    totalLikes.value = newPost.postInfo?.totalLikes ?? 0;
  }
}
