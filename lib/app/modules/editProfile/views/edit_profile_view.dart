import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  final controller = Get.put(EditProfileController());

  String _capitalize(String input) {
    if (input.isEmpty) return '';
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final editData = controller.edt.value.userInfo;
          final verticals = controller.edt.value.verticals ?? [];
          final allVerticalList = controller.verticaldata1.value.data ?? [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                          ),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.more_vert,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Profile Pictures',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Stack(
                        children: [
                          Obx(() {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: controller.profileImage1.value != null
                                  ? Image.file(
                                      controller.profileImage1.value!,
                                      height: 360,
                                      width: 340,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: editData
                                              ?.userProfile?.profileImage
                                              ?.trim() ??
                                          "",
                                      height: 360,
                                      width: 340,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/assets/img.png',
                                        height: 360,
                                        width: 340,
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/assets/img.png',
                                        height: 360,
                                        width: 340,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            );
                          }),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap: () async {
                                // Show bottom sheet for options
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Wrap(
                                        children: <Widget>[
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_camera),
                                            title: const Text('Camera'),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final pickedFile =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (pickedFile != null) {
                                                controller.profileImage1.value =
                                                    File(pickedFile
                                                        .path); // ✅ Fix

                                                controller.update();
                                              }
                                            },
                                          ),
                                          ListTile(
                                            leading:
                                                const Icon(Icons.photo_library),
                                            title: const Text('Gallery'),
                                            onTap: () async {
                                              Navigator.of(context).pop();
                                              final pickedFile =
                                                  await ImagePicker().pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              if (pickedFile != null) {
                                                controller.profileImage1.value =
                                                    File(pickedFile.path);
                                                controller
                                                    .update(); // if using GetX to update UI
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(55, 185, 197, 1),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                        child: Text(
                      "Main Profile Picture",
                      style: TextStyle(
                          color: Color.fromRGBO(138, 138, 138, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Obx(() {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: controller.profileImage1.value !=
                                              null
                                          ? Image.file(
                                              controller.profileImage1.value!,
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: editData?.userProfile
                                                      ?.profileImgSecond
                                                      ?.trim() ??
                                                  "",
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                'assets/assets/img.png',
                                                height: 360,
                                                width: 340,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/assets/img.png',
                                                height: 360,
                                                width: 340,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    );
                                  }),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "2nd Profile Picture",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(138, 138, 138, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: controller.profileImage2.value !=
                                              null
                                          ? Image.file(
                                              controller.profileImage2.value!,
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: editData?.userProfile
                                                      ?.profileImgSecond
                                                      ?.trim() ??
                                                  "",
                                              height: 160,
                                              width: 160,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                'assets/assets/img.png',
                                                height: 160,
                                                width: 160,
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/assets/img.png',
                                                height: 160,
                                                width: 160,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SafeArea(
                                                child: Wrap(
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.photo_camera),
                                                      title:
                                                          const Text('Camera'),
                                                      onTap: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        final pickedFile =
                                                            await ImagePicker()
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .camera);
                                                        if (pickedFile !=
                                                            null) {
                                                          controller
                                                                  .profileImage2
                                                                  .value =
                                                              File(pickedFile
                                                                  .path);
                                                        }
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.photo_library),
                                                      title:
                                                          const Text('Gallery'),
                                                      onTap: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        final pickedFile =
                                                            await ImagePicker()
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                        if (pickedFile !=
                                                            null) {
                                                          controller
                                                                  .profileImage2
                                                                  .value =
                                                              File(pickedFile
                                                                  .path);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromRGBO(55, 185, 197, 1),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() {
                                return DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(30),
                                  dashPattern: [6, 4],
                                  color: Colors.black,
                                  strokeWidth: 2,
                                  padding: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SafeArea(
                                            child: Wrap(
                                              children: <Widget>[
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.photo_camera),
                                                  title: const Text('Camera'),
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    final pickedFile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    if (pickedFile != null) {
                                                      controller.profileImage3
                                                              .value =
                                                          File(pickedFile.path);
                                                    }
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.photo_library),
                                                  title: const Text('Gallery'),
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    final pickedFile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    if (pickedFile != null) {
                                                      controller.profileImage3
                                                              .value =
                                                          File(pickedFile.path);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            220, 220, 220, 1),
                                        borderRadius: BorderRadius.circular(30),
                                        image: controller.profileImage3.value !=
                                                null
                                            ? DecorationImage(
                                                image: FileImage(controller
                                                    .profileImage3.value!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child:
                                          controller.profileImage3.value == null
                                              ? const Center(
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                )
                                              : null,
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(height: 8),
                              const Text(
                                "3rd Profile Picture",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(138, 138, 138, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Personal Details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 10),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              const Text("First Name",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: controller.firstNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color.fromRGBO(55, 185, 177, 1),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text("Last Name",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: controller.lastNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color.fromRGBO(55, 185, 177, 1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Bio
                              const Text("Bio",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: controller.bioController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Instagram Username
                              const Text("Instagram Username",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: controller.instagramController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Image.asset(
                                    'assets/assets/insta_fill_logo.png',
                                    color: Color.fromRGBO(55, 185, 177, 1),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Date of Birth
                              const Text("Date of Birth",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: controller.dobController,
                                readOnly: true, // prevent keyboard from opening
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        controller.dobController.text =
                                            "${pickedDate.day.toString().padLeft(2, '0')}/"
                                            "${pickedDate.month.toString().padLeft(2, '0')}/"
                                            "${pickedDate.year}";
                                      }
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Color.fromRGBO(55, 185, 177, 1),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Gender
                              const Text("Gender",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              const SizedBox(height: 8),



                              DropdownButtonFormField2<String>(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Gender',
                                ),
                                hint: const Text('Gender'),
                                value: controller.genderController.text.isNotEmpty
                                    ? _capitalize(controller.genderController.text)
                                    : null,
                                items: ['Male', 'Female'].map((gender) {
                                  return DropdownMenuItem<String>(

                                    value: gender,
                                    child: Text(gender),

                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.genderController.text = value;
                                  }
                                },
                                iconStyleData: const IconStyleData(
                                  icon: Icon(Icons.arrow_drop_down),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 12),
                          const Text("Vertical",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87)),
                          Obx(() {
                            final verticals = controller.allVerticals;

                            if (verticals.isEmpty) return const Text("No verticals found");

                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: verticals.map((data) {
                                return GestureDetector(
                                  onTap: () => controller.toggleVertical(data.id!),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: data.isSelected
                                            ? const Color.fromRGBO(55, 177, 185, 1)
                                            : Colors.grey.shade400,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (data.image != null && data.image!.isNotEmpty)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              data.image!,
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        else
                                          Image.asset('assets/assets/img.png', height: 20, width: 20),
                                        const SizedBox(width: 8),
                                        Text(
                                          data.verticalName ?? '',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: data.isSelected
                                                ? const Color.fromRGBO(55, 177, 185, 1)
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),


                          const SizedBox(height: 20),
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      await controller.updateProfileApi();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(340, 60),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
