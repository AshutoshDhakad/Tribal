import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/vertical.dart';

class HomepageController extends GetxController {
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  // var postData = <Vertical>[].obs;
  var homeData = Post().obs;


  final Map<int, String> filterMap = {

  };

  final String token = '1417|Ny36MeLEL7pzH1lme6lOMN6A49SjH8WqJ9p7JGOf7a3751cd';

  Future<void> fetchPostsByIndex(int index) async {
    isLoading.value = true;

    const url = "https://tribaldash.urlsdemo.net/api/all-posts";

    final body = {
      "filter": filterMap[index] ?? '',
      "vertical_id": '0',
      "per_page": '10',
      "page_no": '1',
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

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print('json response == ${jsonResponse}');
        homeData.value = Post.fromJson(jsonResponse);
        print('home == ${homeData.value.verticals}');

        // print("Parsed verticals count: ${result.verticals.length}");

        // postData.assignAll(result.verticals); // Use assignAll to trigger UI updates
      } else {
        // postData.clear();
        Get.rawSnackbar(message: "Failed to load posts. Status: ${response.statusCode}");
      }
    } catch (e) {
      // postData.clear();
      Get.rawSnackbar(message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
    fetchPostsByIndex(index);
  }

  @override
  void onInit() {
    super.onInit();
    fetchPostsByIndex(0);
  }
}
