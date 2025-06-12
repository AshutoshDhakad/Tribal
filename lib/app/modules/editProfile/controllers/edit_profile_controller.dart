import 'dart:convert';
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

  final isLoading = false.obs;
  final isSelected = true.obs;
  final edt = Welcome().obs;
  final verticaldata1 = Verticalsdata().obs;

  RxList<Datum> allVerticals = <Datum>[].obs; // ✅ Correct type
  RxList<int> selectedVerticalIds = <int>[].obs;

  final String token = 'Bearer 1571|cI4Iz5YLmmvtNdbexIAiW2EMy32GjlZXSLFSKpRYd4bbc9d7';

  @override
  void onInit() {
    super.onInit();
    final userId = Get.arguments as String?;
    if (userId != null) {
      fetchData(userId);
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

  Future<void> fetchData(String userId) async {
    isLoading.value = true;

    try {
      // 1. Get user profile
      final userProfileResponse = await dio.Dio().get(
        'https://tribaldash.urlsdemo.net/api/view-user-profile',
        options: dio.Options(headers: {"Authorization": token}),
      );

      // 2. Get all verticals
      final verticalsResponse = await dio.Dio().post(
        'https://tribaldash.urlsdemo.net/api/verticals',
        options: dio.Options(headers: {"Authorization": token}),
      );

      if (userProfileResponse.statusCode == 200 &&
          verticalsResponse.statusCode == 200) {

        edt.value = Welcome.fromJson(userProfileResponse.data);
        verticaldata1.value = Verticalsdata.fromJson(verticalsResponse.data);
        setInitialData(edt.value);

        // ✅ Handle verticalIds string: "45,43"
        final rawIds = edt.value.userInfo?.userProfile?.verticalIds;
        List<int> selectedIds = [];

        if (rawIds is String) {
          selectedIds = rawIds
              .split(',')
              .map((e) => int.tryParse(e.trim()))
              .whereType<int>()
              .toList();
        }

        print("🟢 Parsed selected vertical IDs: $selectedIds");

        final all = verticaldata1.value.data ?? [];

        // ✅ Mark selected
        for (var v in all) {
          v.isSelected = selectedIds.contains(v.id);
        }

        // ✅ Update local reactive lists
        selectedVerticalIds.assignAll(selectedIds);
        allVerticals.assignAll(all);
      } else {
        Get.snackbar("Error", "Failed to fetch data");
      }
    } catch (e) {
      Get.snackbar("Exception", "Something went wrong: $e");
      print("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleVertical(int id) {
    final index = allVerticals.indexWhere((v) => v.id == id);
    if (index != -1) {
      final vertical = allVerticals[index];

      if (!vertical.isSelected && selectedVerticalIds.length >= 3) {
        Get.snackbar("Limit reached", "You can select up to 3 verticals.");
        return;
      }

      vertical.isSelected = !vertical.isSelected;

      if (vertical.isSelected) {
        selectedVerticalIds.add(id);
      } else {
        selectedVerticalIds.remove(id);
      }

      allVerticals.refresh();
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
        "vertical_ids": selectedVerticalIds.join(','),
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

      final response = await dio.Dio().post(
        "https://tribaldash.urlsdemo.net/api/update-profile",
        data: formData,
        options: dio.Options(headers: {"Authorization": token}),
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

