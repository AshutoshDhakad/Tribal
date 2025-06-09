import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/vertical.dart';

class HomePage1Controller extends GetxController {
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  var homeData = Post().obs;
  RxList<Datum> posts = <Datum>[].obs;
  var isLiked = false.obs;
  var totalLikes = 0.obs;
  String verticalId = '0';

  final String token = '1417|Ny36MeLEL7pzH1lme6lOMN6A49SjH8WqJ9p7JGOf7a3751cd';

  Future<void> fetchPostsByIndex(int index) async {
    isLoading.value = true;

    const url = "https://tribaldash.urlsdemo.net/api/all-posts";

    String verticalId;
    if (index == 0) {
      verticalId = '';
    } else if (homeData.value.verticals != null &&
        (index - 1) < homeData.value.verticals!.length) {
      verticalId = homeData.value.verticals![index - 1].id.toString();
    } else {
      verticalId = '';
    }

    final body = {
      "vertical_id": verticalId,
      "per_page": '10',
      "page_no": '1',
      if (verticalId.isNotEmpty) "vertical_id": verticalId,
    };


    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        homeData.value = Post.fromJson(json.decode(response.body));

        final firstPost = homeData.value.data?.isNotEmpty == true
            ? homeData.value.data!.first
            : null;

        if (firstPost != null) {
          totalLikes.value = firstPost.totalLikes ?? 0;
        }
      } else {
        Get.rawSnackbar(message: "Failed to load posts");
      }
    } catch (e) {
      Get.rawSnackbar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void likePost(int index){
    homeData.value.data?[index].alreadyLiked = !homeData.value.data![index].alreadyLiked!;
    homeData.refresh();
    print(homeData.value.data?[index].alreadyLiked);
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
    fetchPostsByIndex(index);
  }

  @override
  void onInit() {
    super.onInit();
    fetchPostsByIndex(0); // Load 'All' by default
  }
}
