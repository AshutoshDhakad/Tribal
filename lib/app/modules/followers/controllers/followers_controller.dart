import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tribal/app/modules/model/folwers.dart';


class FollowersController extends GetxController {
  var isLoading = true.obs;
  final followers = Rxn<Folwers>();

  final String fetchUrl = 'https://tribaldash.urlsdemo.net/api/view-followers';
  final String removeUrl = 'https://tribaldash.urlsdemo.net/api/remove-followers';
  final String token = '1573|cPDVFg8FqT606IgvPLMsLw4E9wIPze314MBus3xccf4c65a9';

  Future<void> fetchFollowers({int page = 1, int perPage = 14}) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(fetchUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'per_page': perPage.toString(),
          'page_no': page.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final json = jsonDecode(response.body);
        followers.value = Folwers.fromJson(json);
      } else {
        throw Exception('Failed to load followers');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFollower(int followerId) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(removeUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'follower_id': followerId.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Remove Success: ${response.body}');
        // Optionally refresh the followers list
        await fetchFollowers();
      } else {
        print('Remove Failed: ${response.body}');
        throw Exception('Failed to remove follower');
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowers();
  }
}


