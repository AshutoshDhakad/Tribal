
import 'dart:convert';

Verticalsdata verticalsdataFromJson(String str) => Verticalsdata.fromJson(json.decode(str));

String verticalsdataToJson(Verticalsdata data) => json.encode(data.toJson());

class Verticalsdata {
  String? status;
  UserInfo? userInfo;
  List<Datum>? data;

  Verticalsdata({
    this.status,
    this.userInfo,
    this.data,
  });

  factory Verticalsdata.fromJson(Map<String, dynamic> json) => Verticalsdata(
    status: json["status"],
    userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userInfo": userInfo?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {

  int? id;
  String? verticalName;
  String? image;
  bool isSelected = false;

  Datum({
    this.id,
    this.verticalName,
    this.image,
    this.isSelected = false,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    verticalName: json["vertical_name"],
    image: json["image"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vertical_name": verticalName,
    "image": image,
  };
}

class UserInfo {
  int? id;
  dynamic firstName;
  dynamic lastName;
  String? brandName;
  String? userType;
  String? kyc;
  UserProfile? userProfile;

  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.brandName,
    this.userType,
    this.kyc,
    this.userProfile,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    brandName: json["brand_name"],
    userType: json["user_type"],
    kyc: json["kyc"],
    userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "brand_name": brandName,
    "user_type": userType,
    "kyc": kyc,
    "user_profile": userProfile?.toJson(),
  };
}

class UserProfile {
  int? userId;
  String? profileImage;

  UserProfile({
    this.userId,
    this.profileImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    userId: json["user_id"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "profile_image": profileImage,
  };
}
