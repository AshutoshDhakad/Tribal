import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/viewprofile.dart';

class CreateProfileController extends GetxController {
  final isLoading = false.obs;
  final profile1 = Rxn<Profile>();

  final String token = 'Bearer 1571|cI4Iz5YLmmvtNdbexIAiW2EMy32GjlZXSLFSKpRYd4bbc9d7';

  @override
  void onInit() {
    super.onInit();
    final userId = Get.arguments as String?;
    if (userId == null) {
      debugPrint("user_id is null in Get.arguments. Cannot load profile.");
      return;
    }

    fetchPostById(userId);
  }

  Future<void> fetchPostById(String userId) async {
    const url = 'https://tribaldash.urlsdemo.net/api/view-profile';

    final headers = {
      'Authorization': token,
     // 'Accept': 'application/json',
     // 'Content-Type': 'application/json',
    };

    final body = {
      "user_id": userId,
    };
    print("Sending user_id: $userId");
    print("Token: $token");


    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print('response == ${response.body}');

      if (response.statusCode == 200) {
        profile1.value = Profile.fromJson(json.decode(response.body));
      } else {
        Get.snackbar("Error", "Failed to fetch profile: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
