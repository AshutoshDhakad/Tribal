import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tribal/app/modules/model/folowing.dart';

class FollowingController extends GetxController {
  var isLoading = true.obs;
  final followers = Rxn<Folowing>();

  final String Url = 'https://tribaldash.urlsdemo.net/api/view-followings';
  final String token = '1573|cPDVFg8FqT606IgvPLMsLw4E9wIPze314MBus3xccf4c65a9';

  Future<void> fetchFollowing({int page = 1, int perPage = 3}) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Url),
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
        followers.value = Folowing.fromJson(json);

      } else {
        throw Exception('Failed to load followers');
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFollowing();
  }
}