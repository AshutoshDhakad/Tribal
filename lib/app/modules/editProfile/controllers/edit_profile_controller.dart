import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/editpro.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import '../../model/verticalapi.dart';


class EditProfileController extends GetxController {
  Rx<File?> profileImage1 = Rx<File?>(null);
  Rx<File?> profileImage2 = Rx<File?>(null);
  Rx<File?> profileImage3 = Rx<File?>(null);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final bioController = TextEditingController();
  final instagramController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final tiktokController = TextEditingController();
  final twitterController = TextEditingController();
  final youtubeController = TextEditingController();
  RxList<int> selectedVerticalIds = <int>[].obs;


  final isLoading = false.obs;
  final edt = Welcome().obs;
  final verticaldata1 = Verticalsdata().obs;

  final String token = 'Bearer 1571|cI4Iz5YLmmvtNdbexIAiW2EMy32GjlZXSLFSKpRYd4bbc9d7';


  @override
  void onInit() {
    super.onInit();
    fetchVerticals();
    final userId = Get.arguments as String?;
    if (userId != null) {
      fetchPostById(userId);
    } else {
      debugPrint("user_id is null in Get.arguments.");
    }

  }


  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    instagramController.dispose();
    dobController.dispose();
    genderController.dispose();
    tiktokController.dispose();
    twitterController.dispose();
    youtubeController.dispose();
    super.onClose();
  }

  void setInitialData(Welcome editData) {
    firstNameController.text = editData.userInfo?.firstName ?? "";
    lastNameController.text = editData.userInfo?.lastName ?? "";
    bioController.text = editData.userInfo?.userProfile?.bio ?? "";
    instagramController.text = editData.userInfo?.userProfile?.instagramUsername ?? "";
    final dob = editData.userInfo?.userProfile?.dob;
    if (dob != null) {
      dobController.text = "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year}";
    } else {
      dobController.text = "";
    }
    genderController.text = editData.userInfo?.userProfile?.gender ?? "";
  }

  Future<void> fetchPostById(String userId) async {
    isLoading.value = true;

    try {
      final response = await dio.Dio().get(
        'https://tribaldash.urlsdemo.net/api/view-user-profile',
        options: dio.Options(
            headers: {"Authorization": token}),
      );

      if (response.statusCode == 200) {
        edt.value = Welcome.fromJson(response.data);
        setInitialData(edt.value);
      } else {
        Get.snackbar("Error", "Failed to fetch profile: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchVerticals({List<int> preSelectedIds = const []}) async {
    try {
      final response = await dio.Dio().post(
        'https://tribaldash.urlsdemo.net/api/verticals',
        options: dio.Options(headers: {"Authorization": token}),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.data}");

      if (response.statusCode == 200) {
        verticaldata1.value = Verticalsdata.fromJson(response.data);
        print("Parsed verticals: ${verticaldata1.value.data?.length}");


        selectedVerticalIds.assignAll(preSelectedIds);


      } else {
        Get.snackbar("Error", "Failed to fetch verticals: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception while fetching verticals: $e");
      print("Exception: $e");
    }
  }



  Future<void> updateProfileApi() async {
    isLoading.value = true;

    try {
      final formData = dio.FormData.fromMap({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "bio": bioController.text,
        "instagram_username": instagramController.text,
        "dob": dobController.text,
        "gender": genderController.text,
        "vertical_ids": selectedVerticalIds.toString(),
        "tiktok_username": tiktokController.text,
        "twitter": twitterController.text,
        "youtube": youtubeController.text,

        if (profileImage1.value != null)
          "main_image": await dio.MultipartFile.fromFile(profileImage1.value!.path),
        if (profileImage2.value != null)
          "second_image": await dio.MultipartFile.fromFile(profileImage2.value!.path),
        if (profileImage3.value != null)
          "third_image": await dio.MultipartFile.fromFile(profileImage3.value!.path),
      });

      final response = await dio.Dio().post("https://tribaldash.urlsdemo.net/api/update-profile",

        data: formData,
        options: dio.Options(
            headers: {"Authorization": token}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Profile updated successfully!");
      } else {
        Get.snackbar("Failed", "Update failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


