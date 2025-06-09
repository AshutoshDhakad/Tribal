import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/vertical.dart';

class HomepageController extends GetxController {
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  var homeData = Post().obs;
  Map<int, RxList<Datum>> postsByIndex = {};
  var totalLikes = 0.obs;

  // Pagination
  var currentPage = 1.obs;
  var isFetchingMore = false.obs;
  var hasMore = true.obs;
  final perPage = 10;

  final String token = '1554|OReTepM6iSUTUCG1YBmDpKRkmQcT53fm0ORBOJvE35f37fa6';

  Future<void> fetchPostsByIndex(int index, {int page = 1, bool clear = false}) async {
    if (!postsByIndex.containsKey(index)) {
      postsByIndex[index] = <Datum>[].obs;
    }

    if (page == 1) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      currentPage.value = 1;
      hasMore.value = true;

      if (clear) {
        postsByIndex[index]!.clear();
        homeData.value.data = [];
      }
    } else {
      isFetchingMore.value = true;
    }
 //pagination end

    String verticalId = '';
    if (index > 0 &&
        homeData.value.verticals != null &&
        (index - 1) < homeData.value.verticals!.length) {
      verticalId = homeData.value.verticals![index - 1].id.toString();
    }
    const url = "https://tribaldash.urlsdemo.net/api/all-posts";
    final body = {
      "vertical_id": verticalId,
      "per_page": perPage.toString(),
      "page_no": page.toString(),
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
        final parsed = Post.fromJson(json.decode(response.body));
        final newPosts = parsed.data ?? [];

        if (page == 1) {
          homeData.value = parsed;
        } else {
          homeData.update((val) {
            val?.data ??= [];
            val?.data!.addAll(newPosts);
          });
        }

        if (newPosts.isNotEmpty) {
          postsByIndex[index]!.addAll(newPosts);
          totalLikes.value = newPosts.first.totalLikes ?? 0;
          currentPage.value = page;
        }

        if (newPosts.length < perPage) {
          hasMore.value = false;
        }
      } else {
        Get.rawSnackbar(message: "Failed to load posts");
      }
    } catch (e) {
      Get.rawSnackbar(message: e.toString());
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  void fetchNextPage() {
    if (hasMore.value && !isFetchingMore.value) {
      final nextPage = currentPage.value + 1;
      fetchPostsByIndex(selectedIndex.value, page: nextPage);
    }
  }

  void likePost(int index) {
    final posts = postsByIndex[selectedIndex.value];
    if (posts != null && index < posts.length) {
      posts[index].alreadyLiked = !posts[index].alreadyLiked!;
      homeData.refresh();
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
    fetchPostsByIndex(index, page: 1, clear: true);
  }

  @override
  void onInit() {
    super.onInit();
    fetchPostsByIndex(0, page: 1, clear: true);
  }

//   RxList<Datum> get currentPosts =>
//       postsByIndex[selectedIndex.value] ?? <Datum>[].obs;
 }
